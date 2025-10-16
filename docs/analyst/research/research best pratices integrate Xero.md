<img src="https://r2cdn.perplexity.ai/pplx-full-logo-primary-dark%402x.png" style="height:64px;margin-right:32px"/>

# research best pratices for nextjs on superbase to integrate with Xero API

Now I have gathered comprehensive information about Next.js, Supabase, and Xero API integration best practices. Let me compile this into a detailed report.

## Best Practices for Next.js on Supabase to Integrate with Xero API

Integrating the Xero API with a Next.js application on Supabase requires careful consideration of authentication, data security, architecture patterns, and performance optimization. This guide covers production-ready best practices for building a robust integration.

### Authentication and OAuth 2.0 Implementation

**OAuth 2.0 Flow with Xero**

Xero uses OAuth 2.0 with PKCE (Proof Key for Code Exchange) for secure authentication[^1_1][^1_2]. The recommended approach is to implement the authorization code flow server-side using Next.js API routes or Server Actions to protect your client credentials[^1_3][^1_4].

Key implementation steps:

**Initialize the Xero Client:** Use the official `xero-node` SDK with your credentials stored securely in environment variables (never prefixed with `NEXT_PUBLIC_`)[^1_5][^1_3]. Configure your OAuth app in the Xero Developer Portal with the appropriate scopes like `accounting.transactions`, `offline_access`, and OpenID scopes (`openid`, `profile`, `email`)[^1_1][^1_6].

**Authorization Redirect:** Create a Next.js API route (e.g., `/api/xero/connect`) that redirects users to Xero's authorization URL with PKCE challenge[^1_1][^1_7]. Store the `code_verifier` securely in the user's session[^1_8][^1_1].

**Callback Handling:** Implement a callback route (e.g., `/api/xero/callback`) that exchanges the authorization code for access and refresh tokens[^1_1][^1_6]. Validate the state parameter to prevent CSRF attacks[^1_9].

**Token Storage:** Store tokens securely in your Supabase database, not in browser storage[^1_10][^1_11]. Use the `xero-user-id` as the primary key to avoid token invalidation issues[^1_11]. Encrypt sensitive token data using AES-256 or similar encryption at rest[^1_9].

```typescript
// Example: /app/api/xero/connect/route.ts
import { XeroClient } from 'xero-node';

export async function GET(request: Request) {
  const xero = new XeroClient({
    clientId: process.env.XERO_CLIENT_ID!,
    clientSecret: process.env.XERO_CLIENT_SECRET!,
    redirectUris: [process.env.XERO_REDIRECT_URI!],
    scopes: ['openid', 'profile', 'email', 'accounting.transactions', 'offline_access']
  });

  const consentUrl = await xero.buildConsentUrl();
  return Response.redirect(consentUrl);
}
```


### Token Management and Refresh Strategy

**Automatic Token Refresh**

Access tokens expire after 30 minutes[^1_10][^1_12]. Implement a robust token refresh mechanism with retry logic[^1_10][^1_13]:

**Monitor Token Expiration:** Check the token's `expires_at` timestamp before making API calls[^1_10][^1_12].

**Implement Retry Pattern:** When receiving a 401 Unauthorized response, automatically refresh the token using the refresh token and retry the original request[^1_10][^1_14].

**Store Updated Tokens:** Always update both access and refresh tokens in your database after a successful refresh[^1_10][^1_12].

**Handle Revocation:** Gracefully handle cases where users have revoked access to your application[^1_8][^1_10].

```typescript
// Example token refresh logic
async function refreshXeroToken(userId: string) {
  const { data: tokens } = await supabase
    .from('xero_tokens')
    .select('*')
    .eq('user_id', userId)
    .single();

  const tokenSet = await xero.refreshToken();
  
  await supabase
    .from('xero_tokens')
    .update({
      access_token: tokenSet.access_token,
      refresh_token: tokenSet.refresh_token,
      expires_at: new Date(Date.now() + tokenSet.expires_in * 1000)
    })
    .eq('user_id', userId);
}
```


### Tenant Management and Multi-Organization Support

Xero uses tenant IDs to identify organizations[^1_15][^1_16]. Every API request must include the `xero-tenant-id` header[^1_12][^1_15]:

**Store Tenant Associations:** Save tenant IDs alongside user tokens in your Supabase database[^1_15][^1_11].

**Handle Multiple Tenants:** Users may have access to multiple organizations - allow them to select which organization to work with[^1_15][^1_11].

**Database Schema Design:** Include a `tenant_id` or `xero_tenant_id` field in relevant tables to maintain data isolation[^1_17][^1_11].

```sql
-- Example schema
CREATE TABLE xero_tokens (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID REFERENCES auth.users(id),
  xero_user_id TEXT UNIQUE NOT NULL,
  xero_tenant_id TEXT NOT NULL,
  access_token TEXT NOT NULL,
  refresh_token TEXT NOT NULL,
  expires_at TIMESTAMPTZ NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_xero_tokens_user_id ON xero_tokens(user_id);
CREATE INDEX idx_xero_tokens_tenant_id ON xero_tokens(xero_tenant_id);
```


### API Architecture: Server Actions vs API Routes

**When to Use Each Approach**

For Xero integration, the choice between Server Actions and API Routes depends on your use case[^1_18][^1_19][^1_20]:

**Use API Routes When:**

- Building RESTful endpoints that need to be accessible by external clients (mobile apps, webhooks)[^1_18][^1_20]
- Implementing webhook receivers from Xero[^1_21][^1_22]
- Requiring fine-grained control over HTTP headers, status codes, and middleware[^1_23][^1_18]
- Building endpoints that need rate limiting or complex authentication[^1_23][^1_9]

**Use Server Actions When:**

- Handling form submissions directly from React components[^1_18][^1_19]
- Performing simple mutations within your Next.js app[^1_18][^1_24]
- Wanting to reduce HTTP overhead for internal operations[^1_18][^1_19]
- Working exclusively with Next.js clients (no mobile apps or external integrations)[^1_18][^1_20]

**Recommendation for Xero Integration:** Use API Routes for the OAuth flow, webhook handling, and any endpoints that interact with Xero directly[^1_1][^1_25][^1_26]. This provides better separation of concerns and easier debugging[^1_18][^1_20].

### Rate Limiting and Error Handling

**Xero API Rate Limits**

Xero imposes strict rate limits[^1_27][^1_28][^1_29]:

- **Concurrent Limit:** 5 calls in progress simultaneously
- **Minute Limit:** 60 calls per minute
- **Daily Limit:** 5,000 calls per day

**Best Practices for Rate Limit Management:**

**Implement Exponential Backoff:** When receiving a 429 (Too Many Requests) response, use exponential backoff with jitter[^1_30][^1_14][^1_31]:

```typescript
async function callXeroWithRetry(apiCall: () => Promise<any>, maxRetries = 5) {
  for (let attempt = 0; attempt < maxRetries; attempt++) {
    try {
      return await apiCall();
    } catch (error) {
      if (error.response?.status === 429) {
        const retryAfter = parseInt(error.response.headers['retry-after'] || '60');
        const delay = Math.min(2 ** attempt * 1000 + Math.random() * 1000, 32000);
        await new Promise(resolve => setTimeout(resolve, Math.max(delay, retryAfter * 1000)));
        continue;
      }
      throw error;
    }
  }
  throw new Error('Max retries exceeded');
}
```

**Monitor Usage:** Track API call counts and implement client-side rate limiting before hitting Xero's limits[^1_30][^1_29][^1_14].

**Use Webhooks:** Instead of polling for changes, implement Xero webhooks to receive real-time notifications[^1_21][^1_22][^1_32].

**Batch Operations:** Xero supports batching up to 50 records in a single request - use this to reduce API call volume[^1_33].

**Optimize Pagination:** Xero now supports up to 1,000 results per page (increased from 100)[^1_34][^1_35]. Always use pagination for large datasets and implement the `if-modified-since` parameter to fetch only changed records[^1_32][^1_34].

### Supabase Integration Architecture

**Row Level Security (RLS)**

Always enable RLS on tables containing Xero data to ensure users can only access their own integration data[^1_36][^1_37][^1_38]:

```sql
-- Enable RLS
ALTER TABLE xero_tokens ENABLE ROW LEVEL SECURITY;

-- Policy: Users can only access their own tokens
CREATE POLICY "Users can access own tokens"
  ON xero_tokens
  FOR ALL
  USING (auth.uid() = user_id);

-- Policy: Service role has full access
CREATE POLICY "Service role has full access"
  ON xero_tokens
  FOR ALL
  USING (auth.role() = 'service_role');
```

**Connection Pooling for Serverless**

Use Supabase's transaction mode pooler for serverless Next.js deployments[^1_39][^1_40][^1_41]:

```typescript
// Use transaction pooler connection string
const connectionString = process.env.SUPABASE_DATABASE_URL; // Port 6543 for pooling
```

Configure your database connection with appropriate pool sizes based on your compute tier[^1_40][^1_41]. Transaction mode is ideal for short-lived connections typical in serverless functions[^1_40][^1_42].

**Edge Functions for Background Jobs**

For long-running Xero sync operations, use Supabase Edge Functions called via cron jobs[^1_43][^1_44][^1_45]:

```sql
-- Schedule daily Xero invoice sync
SELECT cron.schedule(
  'sync-xero-invoices',
  '0 2 * * *', -- Run at 2 AM daily
  $$
  SELECT net.http_post(
    url := 'https://YOUR_PROJECT.supabase.co/functions/v1/sync-xero',
    headers := '{"Authorization": "Bearer YOUR_SERVICE_ROLE_KEY"}'::jsonb
  );
  $$
);
```

**Custom Claims for Authorization**

Store Xero tenant associations in Supabase Auth's `app_metadata` for use in RLS policies[^1_46][^1_47][^1_48]:

```typescript
// Add tenant_id to user metadata
await supabaseAdmin.auth.admin.updateUserById(userId, {
  app_metadata: {
    xero_tenant_id: tenantId,
    xero_connected: true
  }
});
```

Access these claims in RLS policies using `auth.jwt()`[^1_36][^1_48][^1_49].

### Data Synchronization Strategy

**Incremental Sync with Webhooks**

Implement a hybrid approach combining webhooks and scheduled polling[^1_21][^1_50][^1_32]:

**Primary Method - Webhooks:** Register webhooks for real-time notifications on invoice, contact, and payment changes[^1_21][^1_22][^1_51].

**Webhook Verification:** Always verify webhook signatures using HMAC-SHA256 to ensure requests are from Xero[^1_21][^1_52][^1_53]:

```typescript
import crypto from 'crypto';

export async function POST(request: Request) {
  const rawBody = await request.text();
  const signature = request.headers.get('x-xero-signature');
  
  const computedSignature = crypto
    .createHmac('sha256', process.env.XERO_WEBHOOK_KEY!)
    .update(rawBody)
    .digest('base64');
  
  if (signature !== computedSignature) {
    return new Response('Unauthorized', { status: 401 });
  }
  
  // Process webhook payload
  const payload = JSON.parse(rawBody);
  // ... handle events
}
```

**Fallback Polling:** Use scheduled cron jobs to catch any missed webhook events[^1_44][^1_45][^1_32]. Implement `if-modified-since` filtering to only fetch changed records[^1_50][^1_32][^1_34].

**Handling Large Datasets:** For initial syncs or large organizations, implement pagination with the new 1,000 records per page limit[^1_34][^1_35]:

```typescript
async function syncAllInvoices(tenantId: string, modifiedSince?: Date) {
  let page = 1;
  let hasMore = true;
  
  while (hasMore) {
    const invoices = await xero.accountingApi.getInvoices(
      tenantId,
      modifiedSince,
      undefined, // where
      undefined, // order
      undefined, // IDs
      undefined, // invoiceNumbers
      undefined, // contactIDs
      undefined, // statuses
      page,
      1000 // pageSize - new maximum
    );
    
    await storeInvoices(invoices.body.invoices);
    
    hasMore = invoices.body.invoices.length === 1000;
    page++;
  }
}
```


### Security Best Practices

**Environment Variables**

Never expose sensitive credentials to the client[^1_54][^1_55][^1_3][^1_4]:

```bash
# Server-only variables (no NEXT_PUBLIC_ prefix)
XERO_CLIENT_ID=your_client_id
XERO_CLIENT_SECRET=your_client_secret
XERO_WEBHOOK_KEY=your_webhook_key
SUPABASE_SERVICE_ROLE_KEY=your_service_role_key

# Client-accessible variables
NEXT_PUBLIC_SUPABASE_URL=your_supabase_url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your_anon_key
```

**API Route Protection**

Implement authentication middleware for all Xero-related API routes[^1_26][^1_56][^1_23]:

```typescript
// middleware.ts
import { createMiddlewareClient } from '@supabase/auth-helpers-nextjs';
import { NextResponse } from 'next/server';
import type { NextRequest } from 'next/server';

export async function middleware(req: NextRequest) {
  const res = NextResponse.next();
  const supabase = createMiddlewareClient({ req, res });
  
  const { data: { session } } = await supabase.auth.getSession();
  
  if (!session && req.nextUrl.pathname.startsWith('/api/xero')) {
    return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });
  }
  
  return res;
}

export const config = {
  matcher: ['/api/xero/:path*']
};
```

**Input Validation**

Always validate and sanitize input data before sending to Xero or storing in Supabase[^1_9]. Use Zod for schema validation[^1_9]:

```typescript
import { z } from 'zod';

const invoiceSchema = z.object({
  contact_id: z.string().uuid(),
  line_items: z.array(z.object({
    description: z.string().max(4000),
    quantity: z.number().positive(),
    unit_amount: z.number().positive(),
    account_code: z.string()
  })),
  due_date: z.string().datetime()
});
```


### Testing and Monitoring

**Testing Xero Integration**

Use Xero's demo company for testing without affecting production data[^1_1][^1_33]. Mock Xero API calls in unit tests using Jest[^1_57][^1_58][^1_59]:

```typescript
// __tests__/xero-integration.test.ts
import { XeroClient } from 'xero-node';

jest.mock('xero-node');

describe('Xero Invoice Sync', () => {
  it('should fetch and store invoices', async () => {
    const mockInvoices = [
      { invoiceID: '123', status: 'AUTHORISED', total: 1000 }
    ];
    
    (XeroClient.prototype.accountingApi.getInvoices as jest.Mock)
      .mockResolvedValue({ body: { invoices: mockInvoices } });
    
    const result = await syncInvoices('tenant-123');
    
    expect(result).toHaveLength(1);
    expect(result[^1_0].invoiceID).toBe('123');
  });
});
```

**Audit Logging**

Implement comprehensive audit logging using Supabase triggers[^1_60][^1_61][^1_62]:

```sql
-- Enable audit logging for Xero sync operations
SELECT audit.enable_tracking('public.xero_invoices'::regclass);
```

**Error Tracking**

Use Supabase Edge Function logs and implement error monitoring[^1_43][^1_9]:

```typescript
try {
  await xero.accountingApi.createInvoices(tenantId, invoices);
} catch (error) {
  console.error('Xero API Error:', {
    message: error.message,
    status: error.response?.status,
    body: error.response?.body
  });
  
  // Log to Supabase for monitoring
  await supabase.from('error_logs').insert({
    source: 'xero_integration',
    error: error.message,
    metadata: { tenant_id: tenantId }
  });
}
```


### Performance Optimization

**Caching Strategy**

Implement strategic caching for frequently accessed Xero data[^1_33][^1_32]:

```typescript
// Cache Xero organization details
const orgCache = new Map<string, { data: any, expires: number }>();

async function getXeroOrganization(tenantId: string) {
  const cached = orgCache.get(tenantId);
  if (cached && cached.expires > Date.now()) {
    return cached.data;
  }
  
  const org = await xero.accountingApi.getOrganisations(tenantId);
  orgCache.set(tenantId, {
    data: org.body.organisations[^1_0],
    expires: Date.now() + 3600000 // 1 hour
  });
  
  return org.body.organisations[^1_0];
}
```

**Database Indexing**

Create appropriate indexes on frequently queried fields[^1_17][^1_63]:

```sql
CREATE INDEX idx_invoices_xero_id ON invoices(xero_invoice_id);
CREATE INDEX idx_invoices_tenant_updated ON invoices(xero_tenant_id, updated_at);
```


### Production Deployment Checklist

Before deploying to production[^1_64][^1_65][^1_9]:

- ✅ Enable RLS on all Xero-related tables
- ✅ Configure proper environment variables with no client exposure
- ✅ Implement rate limiting and exponential backoff
- ✅ Set up webhook signature verification
- ✅ Configure connection pooling for serverless
- ✅ Enable audit logging for compliance
- ✅ Implement comprehensive error handling and monitoring
- ✅ Test token refresh logic thoroughly
- ✅ Validate SSL/TLS connections to both Xero and Supabase
- ✅ Set up scheduled cron jobs for data synchronization
- ✅ Configure CORS policies appropriately
- ✅ Implement proper multi-tenant data isolation


### Conclusion

Successfully integrating Xero API with Next.js on Supabase requires careful attention to OAuth 2.0 flows, token management, rate limiting, and security best practices. By implementing server-side API routes for sensitive operations, leveraging Supabase's RLS for data isolation, using connection pooling for serverless deployments, and employing webhooks combined with scheduled syncs, you can build a robust, scalable integration that maintains data integrity and security[^1_1][^1_36][^1_27][^1_32].

The architecture should prioritize server-side execution for API calls, proper token encryption and storage, comprehensive error handling with retry logic, and efficient data synchronization strategies. Testing with Xero's demo company and monitoring production usage through audit logs ensures reliability as your integration scales[^1_1][^1_60][^1_9].
<span style="display:none">[^1_100][^1_101][^1_102][^1_103][^1_104][^1_105][^1_106][^1_107][^1_108][^1_109][^1_110][^1_111][^1_112][^1_113][^1_114][^1_115][^1_116][^1_117][^1_118][^1_119][^1_120][^1_121][^1_122][^1_123][^1_124][^1_125][^1_126][^1_127][^1_128][^1_129][^1_130][^1_131][^1_132][^1_133][^1_134][^1_135][^1_136][^1_137][^1_66][^1_67][^1_68][^1_69][^1_70][^1_71][^1_72][^1_73][^1_74][^1_75][^1_76][^1_77][^1_78][^1_79][^1_80][^1_81][^1_82][^1_83][^1_84][^1_85][^1_86][^1_87][^1_88][^1_89][^1_90][^1_91][^1_92][^1_93][^1_94][^1_95][^1_96][^1_97][^1_98][^1_99]</span>

<div align="center">⁂</div>

[^1_1]: https://www.deplyr.com/blog/integrating-with-the-xero-api-from-scratch-a-developers-tutorial

[^1_2]: https://developer.xero.com/documentation/guides/oauth2/auth-flow/

[^1_3]: https://stackoverflow.com/questions/72532698/is-it-secure-to-expose-secret-keys-to-a-next-js-app-via-environment-variables

[^1_4]: https://dev.to/itselftools/securing-nextjs-apis-with-middleware-using-environment-variables-2hph

[^1_5]: https://github.com/XeroAPI/xero-node

[^1_6]: https://devblog.xero.com/build-super-sweet-accounting-apps-with-xero-and-node-js-2ac6e673bee

[^1_7]: https://github.com/XeroAPI/node-oauth2-example

[^1_8]: https://supabase.com/docs/guides/integrations/build-a-supabase-integration

[^1_9]: https://www.turbostarter.dev/blog/complete-nextjs-security-guide-2025-authentication-api-protection-and-best-practices

[^1_10]: https://developer.xero.com/documentation/best-practices/data-integrity/managing-tokens

[^1_11]: https://developer.xero.com/documentation/best-practices/managing-connections/multi-tenancy/

[^1_12]: https://devblog.xero.com/xeroapi-oauth-migration-strategy-8af06389ba32

[^1_13]: https://stackoverflow.com/questions/60131163/xero-oauth2-node-examples

[^1_14]: https://moldstud.com/articles/p-xero-development-mastering-exception-handling-for-rate-limit-issues

[^1_15]: https://devblog.xero.com/getting-data-integrity-right-for-organisations-e1b9dc7fe01a

[^1_16]: https://developer.xero.com/documentation/guides/oauth2/tenants/

[^1_17]: https://www.reddit.com/r/Supabase/comments/1ace4ag/database_architecture_for_multitenant_apps/

[^1_18]: https://www.reddit.com/r/nextjs/comments/1mbjs26/server_actions_vs_api_routes_for_largescale/

[^1_19]: https://www.wisp.blog/blog/server-actions-vs-api-routes-in-nextjs-15-which-should-i-use

[^1_20]: https://www.usesaaskit.com/blog/next-js-api-routes-vs-server-actions-which-one-should-you-use-in-2025

[^1_21]: https://devblog.xero.com/keeping-your-integration-in-sync-implementing-xero-webhooks-using-node-express-and-ngrok-6d2976baac6d

[^1_22]: https://devblog.xero.com/using-xero-webhooks-with-node-express-hapi-examples-7c607b423379

[^1_23]: https://www.dhiwise.com/post/how-to-secure-your-api-routes-with-nextjs-middleware

[^1_24]: https://dev.to/eva_clari_289d85ecc68da48/server-actions-in-nextjs-15-the-end-of-api-routes-as-we-know-them-2452

[^1_25]: https://nextjs.org/docs/pages/building-your-application/routing/api-routes

[^1_26]: https://nextjs.org/docs/app/guides/authentication

[^1_27]: https://developer.xero.com/documentation/best-practices/integration-health/rate-limits/

[^1_28]: https://developer.xero.com/documentation/guides/oauth2/limits/

[^1_29]: https://developer.xero.com/faq/limits

[^1_30]: https://iclick.co.nz/xero-api-limits-error-handling/

[^1_31]: https://drdroid.io/integration-diagnosis-knowledge/xero-api-ratelimitexceeded-error-encountered-when-making-api-requests

[^1_32]: https://devblog.xero.com/building-resilience-into-your-xero-api-integration-972bf654f89b

[^1_33]: https://datasights.co/xero-api-examples/

[^1_34]: https://devblog.xero.com/conquer-data-overload-mastering-paging-in-the-xero-api-03ceacfeb184

[^1_35]: https://developer.xero.com/documentation/best-practices/integration-health/paging/

[^1_36]: https://supabase.com/docs/guides/database/postgres/row-level-security

[^1_37]: https://supabase.com/docs/guides/api/securing-your-api

[^1_38]: https://supabase.com/features/row-level-security

[^1_39]: https://supabase.com/blog/supabase-pgbouncer

[^1_40]: https://supabase.com/docs/guides/database/connecting-to-postgres

[^1_41]: https://www.reddit.com/r/Supabase/comments/1g164c2/pooled_vs_direct_connection/

[^1_42]: https://docs-8gcdp4orx-supabase.vercel.app/docs/guides/database/connecting-to-postgres

[^1_43]: https://supabase.com/docs/guides/functions

[^1_44]: https://supabase.com/blog/supabase-cron

[^1_45]: https://supabase.com/docs/guides/cron

[^1_46]: https://github.com/orgs/supabase/discussions/30381

[^1_47]: https://supabase.com/docs/guides/auth/managing-user-data

[^1_48]: https://supabase.com/docs/guides/auth/auth-hooks/custom-access-token-hook

[^1_49]: https://github.com/supabase-community/supabase-custom-claims

[^1_50]: https://stackoverflow.com/questions/45341544/xero-api-synchronising-attachment-changes-for-xero-invoices

[^1_51]: https://developer.xero.com/documentation/guides/webhooks/creating-webhooks/

[^1_52]: https://stackoverflow.com/questions/77559376/xero-webhook-verification-failing-on-nodejs-express-backend

[^1_53]: https://gist.github.com/f4d8390ba1bfcfcceb649f51116f5731

[^1_54]: https://nextjs.org/docs/app/guides/data-security

[^1_55]: https://nextjs.org/docs/pages/guides/environment-variables

[^1_56]: https://nextjs.org/docs/app/api-reference/file-conventions/middleware

[^1_57]: https://stackoverflow.com/questions/62230808/test-nextjs-api-middleware-with-jest

[^1_58]: https://www.edupen.in/posts/mocking-in-jest-for-nextjs

[^1_59]: https://nextjs.org/docs/pages/guides/testing/jest

[^1_60]: https://supabase.com/blog/postgres-audit

[^1_61]: https://supabase.com/docs/guides/database/extensions/pgaudit

[^1_62]: https://supabase.com/docs/guides/database/postgres/triggers

[^1_63]: https://github.com/dikshantrajput/supabase-multi-tenancy

[^1_64]: https://nextjs.org/docs/13/pages/building-your-application/deploying/production-checklist

[^1_65]: https://developer.xero.com/partner/security-standard-for-xero-api-consumers

[^1_66]: https://www.reddit.com/r/Supabase/comments/1dmn657/best_practices_for_api_calls_in_next/

[^1_67]: https://stackoverflow.com/questions/76094823/create-sign-in-with-xero-button-in-next-js-app

[^1_68]: https://www.synchub.io/xero-to-supabase-connector

[^1_69]: https://github.com/orgs/supabase/discussions/4704

[^1_70]: https://supabase.com/partners/integrations

[^1_71]: https://developer.xero.com/documentation/guides/how-to-guides/integration-best-practices/

[^1_72]: https://developer.xero.com/documentation/guides/oauth2/overview/

[^1_73]: https://glama.ai/mcp/servers/@hiltonbrown/xero-mcp-with-next-js/blob/449d8d3b47be8e86634d0be795924dc856ff7094/Development-prompts.md

[^1_74]: https://supabase.com/docs/guides/getting-started/tutorials/with-nextjs

[^1_75]: https://docs.zeroqode.com/plugins/supabase-pro-kit

[^1_76]: https://forum.cursor.com/t/best-practices-for-structuring-a-next-js-fastapi-supabase-project/49706

[^1_77]: https://peliqan.io/connectors/Xero/Supabase/

[^1_78]: https://www.reddit.com/r/nextjs/comments/1bplsk0/benefits_of_nextjs_api_routes_when_using_an/

[^1_79]: https://www.descope.com/blog/post/nextjs-supabase-descope

[^1_80]: https://hotglue.com/blog/how-to-use-supabase-and-hotglue-to-offer-a-native-integration-in-your-product

[^1_81]: https://supabase.com/docs/guides/api

[^1_82]: https://thegraph.com/docs/en/subgraphs/guides/secure-api-keys-nextjs/

[^1_83]: https://www.reddit.com/r/Supabase/comments/1c3xmgl/do_i_still_need_row_level_security/

[^1_84]: https://javascript.plainenglish.io/setting-up-environment-variables-in-next-js-6a790021aceb

[^1_85]: https://dev.to/asheeshh/mastering-supabase-rls-row-level-security-as-a-beginner-5175

[^1_86]: https://www.reddit.com/r/nextjs/comments/1dodywi/best_way_to_hide_api_keys_secrets_from_front_end/

[^1_87]: https://www.reddit.com/r/Supabase/comments/1ccw5jt/post_to_external_api_in_supabase_edge_function/

[^1_88]: https://nextjs.org/docs/pages/guides/authentication

[^1_89]: https://coefficient.io/xero-api/xero-webhooks

[^1_90]: https://supabase.com/blog/simplify-backend-with-data-api

[^1_91]: https://clerk.com/articles/complete-authentication-guide-for-nextjs-app-router

[^1_92]: https://bootstrapped.app/guide/how-to-use-supabase-functions-to-call-external-apis

[^1_93]: https://community.flutterflow.io/database-and-apis/post/guide-for-supabase-edge-functions-for-no-low-coders-2VsQ0BHDkex1mV4

[^1_94]: https://supertokens.com/blog/mastering-nextjs-api-routes

[^1_95]: https://nextjs.org/docs/14/app/building-your-application/routing/middleware

[^1_96]: https://ngrok.com/docs/integrations/webhooks/xero-webhooks

[^1_97]: https://www.antstack.com/blog/multi-tenant-applications-with-rls-on-supabase-postgress/

[^1_98]: https://bootstrapped.app/guide/how-to-set-up-supabase-with-a-multi-tenant-architecture

[^1_99]: https://developer.xero.com/documentation/best-practices/managing-connections/connections/

[^1_100]: https://stackoverflow.com/questions/79457679/server-actions-vs-api-routes-when-to-use-what

[^1_101]: https://clerk.com/blog/multitenancy-clerk-supabase-b2b

[^1_102]: https://devblog.xero.com/introducing-our-new-technical-best-practices-guides-b875faff5cfc

[^1_103]: https://www.youtube.com/watch?v=NWx8oVLEdwE

[^1_104]: https://www.youtube.com/watch?v=ZKggtU4InrM

[^1_105]: https://www.linkedin.com/pulse/why-you-should-avoid-using-server-actions-data-fetching-alvis-ng-nnapc

[^1_106]: https://www.reddit.com/r/Supabase/comments/1gzndk8/best_practice_for_audit_log_hosted_project_pro/

[^1_107]: https://devblog.xero.com/javascript-for-enterprise-development-part-3-hello-typescript-df0b247733bb

[^1_108]: https://pganalyze.com/blog/5mins-postgres-auditing-pgaudit-supabase-supa-audit

[^1_109]: https://devblog.xero.com/building-sdks-for-the-future-b79ff726dfd6

[^1_110]: https://supabase.com/docs/guides/auth/audit-logs

[^1_111]: https://nextjs.org/docs/pages/api-reference/config/typescript

[^1_112]: https://developer.xero.com/documentation/api/accounting/invoices

[^1_113]: https://supabase.com/modules/cron

[^1_114]: https://www.merge.dev/blog/xero-api

[^1_115]: https://www.synchub.io/xeropayrollau-to-supabase-connector

[^1_116]: https://n8n.io/integrations/supabase/and/xero/

[^1_117]: https://satvasolutions.com/blog/xero-journal-api-limitations-guide

[^1_118]: https://mazaal.ai/apps/xero/integrations/supabase

[^1_119]: https://nextjs.org/docs/app/getting-started/server-and-client-components

[^1_120]: https://github.com/XeroAPI/xero-node-sso-app

[^1_121]: https://www.reddit.com/r/Supabase/comments/1i4tqos/custom_claims_in_app_metadata_missing_from_local/

[^1_122]: https://nextjs.org/docs/app/getting-started/fetching-data

[^1_123]: https://auth0.com/blog/using-nextjs-server-actions-to-call-external-apis/

[^1_124]: https://www.wisp.blog/blog/nextjs-15-api-get-and-post-request-examples

[^1_125]: https://github.com/XeroAPI/xero-node-sso-form

[^1_126]: https://nextjs.org/docs/app/api-reference/config/next-config-js/serverExternalPackages

[^1_127]: https://supabase.com/docs/guides/auth/users

[^1_128]: https://www.reddit.com/r/nextjs/comments/1e6mxjt/i_dont_understand_the_deal_with_server_components/

[^1_129]: https://www.answeroverflow.com/m/1384654521665589590

[^1_130]: https://developer.xero.com/documentation/api/accounting/requests-and-responses

[^1_131]: https://www.youtube.com/watch?v=k0LPNKWCxx0

[^1_132]: https://docs.redwoodjs.com/docs/connection-pooling/

[^1_133]: https://devblog.xero.com/leveraging-your-ide-to-debug-jest-unit-tests-622a71b80e56

[^1_134]: https://stackoverflow.com/questions/61829156/xero-api-how-to-specify-page-size-in-the-pagination

[^1_135]: https://www.reddit.com/r/nextjs/comments/17y1jia/jest_test_for_nextjs_13_api_route_handlers_test/

[^1_136]: https://supabase.com/blog/supavisor-1-million

[^1_137]: https://coefficient.io/xero-api/xero-api-rate-limits

