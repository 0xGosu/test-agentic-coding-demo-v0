---
applyTo: '**/*.go'
---
# General instructions for Go code
- Always use tabs for indentation in source code.
- Use error return pattern for error handling in functions, eg. `func foo() (string, error)`.
 - `err` object returned from function calls must be checked immediately after the call, and handled appropriately (e.g., logging, returning, or wrapping the error).
- Add `context.Context` as the first parameter where applicable to all functions that perform I/O or may take a long time to complete, eg. `func foo(ctx context.Context, ...)`.
  - If `ctx` object is not used within the function, still include it in the signature but using `_` to ignore it.
  - When calling other functions that require `context.Context`, pass the received `ctx` object down to them.

# Instructions for writing unit tests
- Unit test files end with `_test.go` and are located in the same directory as the source code (file name using the same as the source code file with post-fix, e.g., `utils.go` -> `utils_test.go`).

# Other instructions
- If there is a specification file `.spec.md` with the same name existing in the same directory, e.g., `user/auth.go` -> `user/auth.spec.md`, you must read this spec file first to understand the requirements before making updates to the `.go` file. This is also applicable to the unit test file, e.g., `user/auth_test.go` -> `user/auth.spec.md`.