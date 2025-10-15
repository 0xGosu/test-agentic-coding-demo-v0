---
applyTo: '**/*.py'
---
# General instructions for Python code
- Always use single quotes and 4 spaces for indentation in source code.
- Use type hints for all function parameters and return values.
- Must not use complex one-liner conditional statements or complicated lambda functions, always use multi-line statements for better readability.

# Instructions for writing unit tests
- Unit test files end with `_test.py` and are located in the same directory as the source code (file name using the same as the source code file with post-fix, e.g., `utils.py` -> `utils_test.py`).

# Other instructions
- If there is a specification file `.spec.md` with the same name existing in the same directory, e.g., `user/auth.py` -> `user/auth.spec.md`, you must read this spec file first to understand the requirements before making updates to the `.py` file. This is also applicable to the unit test file, e.g., `user/auth_test.py` -> `user/auth.spec.md`.