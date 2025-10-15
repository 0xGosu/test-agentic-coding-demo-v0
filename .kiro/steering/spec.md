---
inclusion: fileMatch
fileMatchPattern: "**/*.spec.md"
---

# Specification File Creation Guidelines

## Naming Convention
- Format: `*.spec.md` in the same directory as the source file
- Match source filename exactly with `.spec.md` suffix:
  - `models.py` → `models.spec.md`
  - `api_client.go` → `api_client.spec.md`
  - `utils.ts` → `utils.spec.ts`

## Required Content Structure

### Overview
- Brief description of the module's purpose and responsibilities
- Key architectural decisions or patterns used

### Requirements
- List the requirements that this module aiming to fulfill (both functional and non-functional)
- Must include path to the `requirements.md` file plus the requirement ID, eg: FR1.1, FR1.2

### Public API
- List all public classes, methods, functions, and interfaces
- Methods and functions must include signatures, parameter types and return types
- Methods and functions must be documented with expected behaviors and side effects
- Methods and functions must not contain actual implementation code, only comments to describe its functionality
- Interfaces must be comprehensive
- Interfaces methods must include signatures, parameter types and return types
- Interfaces properties must include types
- Interfaces methods and properties must be documented with descriptions that explain their purpose and usage

### Dependencies
For each public method/function:
- List internal function calls and external dependencies
- Specify required parameters for dependency calls
- Note any configuration or environment requirements

### Test Scenarios
For each public method/function:
- Define comprehensive test cases covering:
  - Happy path scenarios
  - Edge cases and boundary conditions
  - Error conditions and exception handling
- Include expected inputs, outputs, and side effects
- Specify any setup or teardown requirements


## General Guidelines
- MUST include only information directly relevant to the module's technical functionality.
- Complicated logic can be expressed with code examples/snippets, but avoid overuse of code snippets
  - All code examples/snippets must be short and focused on illustrating specific points
- Markdown anchor links must be valid and correctly formatted. Links to other markdown must include both file path and section title ref. All links must start with a leading slash `/` to indicate this is the path from the repository root to the target file. Examples:
  - Correct: `[Public-API](/src/my-app-name/controllers/data.controller.spec.md#public-api)`
  - Incorrect: `[Public-API](../controllers/data.controller.spec.md#public-api)`
  - Correct:  `[FR1](/.kiro/spec/feature-name/requirements.md#fr1)`
  - Incorrect: `[FR1](.kiro/spec/feature-name/requirements.md)`
- Ensure the entire specification file does not exceed 500 lines. If necessary, remove code examples/snippets, comments, private methods, private functions, private interfaces or simplify test scenarios (prioritize removing less important content first) to reduce file size.

## Example Specification File
Below is a complete example of a specification file following these guidelines:

```markdown
# Utils Module Specification

## Overview
The utils module provides common utility functions for the gosu MCP server. Currently, it contains timestamp parsing functionality to handle ISO 8601 formatted date strings with support for both full timestamps and date-only formats.

## Requirements
This module fulfills the following requirements:
- **gosu-mcp-server** NFR2.4: Handle invalid input gracefully and return meaningful error messages [NFR2](/.kiro/specs/gosu-mcp-server/requirements.md#nfr2)

## Public API

### Functions

#### parseISOTimestamp(timestamp string) (time.Time, error)
**Purpose**: Parses an ISO 8601 timestamp string into a time.Time object.

**Parameters**:
- `timestamp` (string): ISO 8601 formatted timestamp string

**Return Values**:
- `time.Time`: Parsed timestamp
- `error`: Error if parsing fails or input is invalid

**Behavior**:
- Accepts RFC3339 format (e.g., "2023-01-15T14:30:00Z")
- Accepts simple date format (e.g., "2023-01-15")
- Returns zero time.Time and descriptive error for invalid formats
- Returns specific error for empty string input

**Side Effects**: None - pure function with no side effects

## Dependencies

### parseISOTimestamp Dependencies
**Internal Dependencies**: None

**External Dependencies**:
- `time.Parse(time.RFC3339, timestamp)` - Standard library time parsing for full timestamps
- `time.Parse("2006-01-02", timestamp)` - Standard library time parsing for date-only format
- `fmt.Errorf()` - Standard library error formatting

**Configuration Requirements**: None
**Environment Requirements**: None

## Test Scenarios

### parseISOTimestamp Test Cases

#### Happy Path Scenarios
1. **Valid RFC3339 timestamp**
   - Input: `"2023-01-15T14:30:00Z"`
   - Expected Output: `time.Time` representing January 15, 2023 at 14:30:00 UTC, `nil` error
   - Setup: None required
   - Teardown: None required

2. **Valid date-only format**
   - Input: `"2023-01-15"`
   - Expected Output: `time.Time` representing January 15, 2023 at 00:00:00 UTC, `nil` error
   - Setup: None required
   - Teardown: None required

#### Edge Cases and Boundary Conditions
3. **Leap year date**
   - Input: `"2024-02-29"`
   - Expected Output: Valid `time.Time` for February 29, 2024, `nil` error
   - Setup: None required
   - Teardown: None required

4. **Year boundary**
   - Input: `"1999-12-31T23:59:59Z"`
   - Expected Output: Valid `time.Time` for December 31, 1999 at 23:59:59 UTC, `nil` error
   - Setup: None required
   - Teardown: None required

#### Error Conditions and Exception Handling
5. **Empty string input**
   - Input: `""`
   - Expected Output: Zero `time.Time`, error with message "empty timestamp"
   - Setup: None required
   - Teardown: None required

6. **Invalid date format**
   - Input: `"invalid-date"`
   - Expected Output: Zero `time.Time`, error containing "invalid ISO 8601 timestamp" and supported formats
   - Setup: None required
   - Teardown: None required

7. **Invalid date values**
   - Input: `"2023-13-45"`
   - Expected Output: Zero `time.Time`, error containing "invalid ISO 8601 timestamp" and supported formats
   - Setup: None required
   - Teardown: None required

8. **Partial timestamp format**
   - Input: `"2023-01-15T14:30"`
   - Expected Output: Zero `time.Time`, error containing "invalid ISO 8601 timestamp" and supported formats
   - Setup: None required
   - Teardown: None required
```