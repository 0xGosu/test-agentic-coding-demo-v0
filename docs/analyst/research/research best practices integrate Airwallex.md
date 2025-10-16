# Airwallex integration best practices — Next.js (TS) + Supabase (Postgres + Auth)

Summary (one-line)
- Keep all Airwallex secret keys and server-to-server calls on your backend (Supabase Edge Function / server), use Airwallex client components or hosted flows on the frontend, validate webhooks, map users → Airwallex customers in Postgres, and test thoroughly in sandbox.  [oai_citation:0‡Airwallex](https://www.airwallex.com/docs/developer-tools__sandbox-environment-overview?utm_source=chatgpt.com)

1) Recommended architecture (high level)
- Frontend (Next.js/TS)
  - Render Airwallex Payment Element / hosted checkout or fetch a short-lived client token from your backend and initialize the client-side element. (Do **not** embed secret keys in the browser).  [oai_citation:1‡GitHub](https://github.com/airwallex/airwallex-payment-demo?utm_source=chatgpt.com)
- Backend (Supabase)
  - Use Supabase Edge Functions (or a small Node service) to hold Airwallex secrets, call the Airwallex REST/Node SDK, create payment intents / customers, and return only client-side tokens/secrets to the browser.  [oai_citation:2‡Airwallex](https://www.airwallex.com/docs/developer-tools__sdks__server-side-sdks-%28beta%29?utm_source=chatgpt.com)
- Database (Supabase Postgres)
  - Persist: user_id → airwallex_customer_id, payment_intent_id, status, idempotency_key, webhook events, and reconciliation records.
- Webhooks
  - Expose a secure webhook endpoint (Edge Function or server route). Verify HMAC signatures, respond 2xx quickly, store raw payload + verification result for audits.  [oai_citation:3‡Airwallex](https://www.airwallex.com/docs/developer-tools__listen-for-webhook-events?utm_source=chatgpt.com)

2) Frontend specifics (Next.js + TypeScript)
- Only request short-lived client tokens / intent IDs from your backend.
- Use Airwallex-provided payment component examples (React/TS) or the hosted element to avoid PCI scope.  [oai_citation:4‡CodeSandbox](https://codesandbox.io/s/airwallex-payment-demo-react-typescript-buuhk?utm_source=chatgpt.com)
- Keep network calls minimal: create intent server-side, confirm client-side using client token.

3) Backend specifics (Supabase)
- Where to run server code:
  - Prefer Supabase Edge Functions (Node/TS) or a small serverless function for endpoints that call Airwallex.
- Secrets & config:
  - Store Airwallex API keys in Supabase project secrets / environment variables (never in client bundle).
  - Use least privilege keys, rotate keys, and log access.
- Use Airwallex Node SDK for convenience; fall back to REST for unsupported calls. Implement idempotency for retried requests.  [oai_citation:5‡Airwallex](https://www.airwallex.com/docs/developer-tools__sdks__server-side-sdks-%28beta%29?utm_source=chatgpt.com)
- Map Supabase Auth users to Airwallex Customer objects in Postgres.

4) Webhooks & asynchronous events
- Implementation:
  - Configure webhooks in the Airwallex dashboard; test via sandbox test events.  [oai_citation:6‡Airwallex](https://www.airwallex.com/docs/developer-tools__test-webhook-event-payloads?utm_source=chatgpt.com)
  - Verify signatures (HMAC) on receipt, return 200 quickly, and process asynchronously (enqueue heavy work).
- Security:
  - Store webhook secret in server env; use constant-time comparison to validate signatures.
  - Consider retry/backoff logic and idempotency for event processing.

5) Security & compliance
- Avoid handling raw card data by using Airwallex-hosted elements or tokenization. This minimizes PCI scope.  [oai_citation:7‡GitHub](https://github.com/airwallex/airwallex-payment-demo?utm_source=chatgpt.com)
- Transport: TLS everywhere; enable IP whitelisting for webhooks if required.  [oai_citation:8‡Airwallex](https://www.airwallex.com/docs/payments__integration-checklist?utm_source=chatgpt.com)
- Audit: persist raw webhook payloads, verification status, and user mapping.
- Apply least privilege for keys; use separate sandbox and production keys.

6) Reliability & ops
- Timeouts & retries: set sensible timeouts and exponential backoff for API calls.
- Idempotency: store and reuse idempotency keys for critical ops (payments, transfers).
- Logging & monitoring: capture request/response, webhook events, reconciliation mismatches; push alerts for failures.
- Sandbox testing: use sandbox account + test webhook events before go-live.  [oai_citation:9‡Airwallex](https://www.airwallex.com/docs/developer-tools__sandbox-environment-overview?utm_source=chatgpt.com)

7) Developer ergonomics (examples)
- Server: create payment intent (pseudo Node / Supabase Edge Function)
```ts
// Example (simplified)
import { createClient } from '@airwallex/sdk' // pseudo; use official package / REST per docs
export default async function handler(req, res) {
  const { userId, amount, currency } = req.body;
  // authorize user via Supabase session (server-side)
  // create payment intent on server:
  const client = createClient({ apiKey: process.env.AIRWALLEX_SECRET });
  const intent = await client.payments.createPaymentIntent({ amount, currency, /* ... */ });
  // persist intent id + user mapping to Postgres
  res.json({ client_secret: intent.client_secret, intent_id: intent.id });
}
```
- Webhook verification (concept)
```ts
// verify HMAC header against your webhook secret
const signature = req.headers['x-airwallex-signature'];
const valid = verifyHmac(req.rawBody, process.env.AIRWALLEX_WEBHOOK_SECRET, signature);
if (!valid) return res.status(400).send('invalid signature');
enqueueProcessing(req.body);
res.status(200).send('ok');
```
(See Airwallex webhook signing examples for exact header name and algorithm.)  [oai_citation:10‡Airwallex](https://www.airwallex.com/docs/developer-tools__listen-for-webhook-events__code-examples?utm_source=chatgpt.com)

8) Common pitfalls & how to avoid them
- Exposing secret keys in frontend → always keep keys server-side.
- Not verifying webhooks → replay attacks / false updates.
- Missing idempotency → duplicate charges on retries.
- Not mapping users to Airwallex customers → reconciliation headaches.
- Skipping sandbox tests → production regressions.  [oai_citation:11‡Airwallex](https://www.airwallex.com/docs/payments__integration-checklist?utm_source=chatgpt.com)

9) Quick integration checklist (pre-launch)
- [ ] Implement server-side token/intent creation.  [oai_citation:12‡Airwallex](https://www.airwallex.com/docs/payments__native-api?utm_source=chatgpt.com)
- [ ] Use Airwallex client element or hosted flow on frontend.  [oai_citation:13‡GitHub](https://github.com/airwallex/airwallex-payment-demo?utm_source=chatgpt.com)
- [ ] Store mapping user ↔ customer ↔ intent in Postgres.
- [ ] Implement & verify webhooks; store raw events.  [oai_citation:14‡Airwallex](https://www.airwallex.com/docs/developer-tools__listen-for-webhook-events?utm_source=chatgpt.com)
- [ ] Test end-to-end in sandbox; simulate webhook events.  [oai_citation:15‡Airwallex](https://www.airwallex.com/docs/developer-tools__test-webhook-event-payloads?utm_source=chatgpt.com)
- [ ] Add monitoring, logging, and retries.

10) Questions (if you want more tailored guidance)
- Do you plan:
  - A: Single-merchant (your company processes payments) — *default*: design for single-merchant.
  - B: Marketplace/Managed platform (you process on behalf of multiple merchants) — requires OAuth & partner flows.  [oai_citation:16‡Airwallex](https://www.airwallex.com/docs/developer-tools__integration-guide?utm_source=chatgpt.com)
- Do you want Supabase Edge Functions examples (TS) or a separate Node microservice?  
  - *Default:* Edge Functions (simpler; keeps infra consolidated).

If you confirm choice (A or B) I will:
- Provide a minimal Edge Function code sample (TS) to create an intent and a webhook handler integrated with Supabase Postgres and Auth.
- Or provide a marketplace flow diagram and code for OAuth/partner onboarding.
