---
applyTo: '**/*.ts'
---
# General instructions for TypeScript code
- Always use single quotes and 2 spaces for indentation in source code.
- Avoid using type 'any' in the code, use specific types instead.
- Must not use complex one-liner conditional statements or one-liner arrow functions, always use multi-line statements for better readability.

# Instructions for writing unit tests
- Unit test files end with `.test.ts` and are located in the same directory as the source code (file name using the same as the source code file with post-fix, e.g., `utils.ts` -> `utils.test.ts`).

# Other instructions
- If there is a specification file `.spec.md` with the same name existing in the same directory, e.g., `user/auth.ts` -> `user/auth.spec.md`, you must read this spec file first to understand the requirements before making updates to the `.ts` file. This is also applicable to the unit test file, e.g., `user/auth.test.ts` -> `user/auth.spec.md`.