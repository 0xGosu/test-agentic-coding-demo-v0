---
inclusion: manual
---

# Project Scaffolding Guidelines

## Directory Structure

Follow the directory structure defined in the `design.md`. If no structure is provided use the below:

For backend API application:
```
./
├── src
│   ├── common
│   │   ├── decorators
│   │   ├── filters
│   │   ├── interceptors
│   │   └── services
│   ├── config
│   └── modules
│       ├── core
│       ├── auth
│       └── module-no3-name
└── test
    ├── integration
    └── e2e
```

For frontend application:
``` 
./
├── public
├── src
│   ├── api
│   │   └── services
│   ├── components
│   │   ├── features
│   │   ├── layout
│   │   └── ui
│   ├── hooks
│   ├── pages
│   ├── stores
│   ├── styles
│   ├── types
│   └── utils
└── test
    ├── integration
    └── e2e
```
## Code Organization

- All source code must be placed in the `src/` directory
- Each module/component should be self-contained within its own subdirectory
- Use descriptive module names that reflect functionality
- Maintain consistent naming conventions across modules
- Always create companion files for each source code file:
  - A specification file (`*.spec.md`) for documentation
  - A test file (`*test.(py|ts|go)`) for unit tests
  - Both files must be co-located in the same directory as the source code file

## Python Project Standards

- Create a `pyproject.toml` with `uv` for dependency management and project configuration 
- Follow PEP 8 style guidelines
- Structure modules with clear separation of concerns
- Include `__init__.py` files for proper package structure

## Typescript Project Standards

- Use `tsconfig.json` for TypeScript configuration
- Create a `package.json` with `pnpm` for dependency management and project configuration
- Follow TypeScript best practices
- Structure modules with clear separation of concerns
- Include `index.ts` files for proper module exports

## Go Project Standards

- Create a `go.mod` for dependency management
- Follow Go conventions for package structure
- Use `main.go` for the entry point of the application
- Structure packages with clear separation of concerns
