---
inclusion: fileMatch
fileMatchPattern: "**/*_test.py,**/test_*.py,**/*.test.ts,**/*.test.js,**/*_test.go,**/test_*.go"
---

# Unit-Test File Creation Guidelines

## Naming Conventions

Test files must be co-located with source files and follow language-specific naming patterns:

- **Python**: `*_test.py` (e.g., `models.py` → `models_test.py`)
- **TypeScript**: `*.test.ts` (e.g., `utils.ts` → `utils.test.ts`)
- **Go**: `*_test.go` (e.g., `client.go` → `client_test.go`)

## Test Structure Requirements

- Write minimal unit tests focusing on core functionality
- Include docstrings/comments describing test scenarios and expected outcomes
- Test all cases outlined in corresponding `.spec.md` files
- Use simple assertions with clear pass/fail criteria
- Avoid complex setup or teardown unless absolutely necessary

## Test Content Standards

- Each test function should verify a single behavior or edge case
- Use descriptive test function names that explain what is being tested
- Include both positive and negative test cases where applicable
- Mock external dependencies to ensure tests are isolated and fast
- Follow the arrange-act-assert pattern for test organization

## Example Unit Test Files

### Go Test Example (`pkg/gosu/resource_manager_test.go`)

```go
package gosu

import (
    "testing"
)

func TestResourceManager_LoadResources(t *testing.T) {
    // Arrange
    // TODO: Set up test data and dependencies
    
    // Act
    // TODO: Call the method under test
    
    // Assert
    // TODO: Verify expected outcomes
    t.Skip("Test implementation needed")
}

func TestResourceManager_InvalidPath(t *testing.T) {
    // Arrange
    // TODO: Set up invalid path scenario
    
    // Act
    // TODO: Call method with invalid input
    
    // Assert
    // TODO: Verify error handling
    t.Skip("Test implementation needed")
}
```

### TypeScript Test Example (`src/utils/validator.test.ts`)

```typescript
import { describe, it, expect } from 'vitest';
import { validateEmail, validateRequired } from './validator';

describe('validateEmail', () => {
    it('should return true for valid email addresses', () => {
        // Arrange
        // TODO: Set up valid email test data
        
        // Act
        // TODO: Call validateEmail with test data
        
        // Assert
        // TODO: Verify return value is true
        expect.assertions(0); // Remove when implementing
    });
    
    it('should return false for invalid email addresses', () => {
        // Arrange
        // TODO: Set up invalid email test data
        
        // Act & Assert
        // TODO: Test each invalid email case
        expect.assertions(0); // Remove when implementing
    });
});

describe('validateRequired', () => {
    it('should return false for empty values', () => {
        // Arrange
        // TODO: Set up empty/null test values
        
        // Act & Assert
        // TODO: Test each empty value case
        expect.assertions(0); // Remove when implementing
    });
});
```

### Python Test Example (`src/models/user_test.py`)

```python
import unittest
from unittest.mock import Mock, patch
from models.user import User, UserRepository

class TestUser(unittest.TestCase):
    """Test cases for User model"""
    
    def setUp(self):
        """Arrange - Set up test fixtures"""
        # TODO: Initialize test data and mock objects
        pass
    
    def test_user_creation(self):
        """Test that User instances are created correctly"""
        # Arrange
        # TODO: Set up user creation data
        
        # Act
        # TODO: Create User instance
        
        # Assert
        # TODO: Verify user properties are set correctly
        self.skipTest("Test implementation needed")
    
    def test_user_invalid_email(self):
        """Test that invalid email raises ValueError"""
        # Arrange
        # TODO: Set up invalid email scenario
        
        # Act & Assert
        # TODO: Verify ValueError is raised
        self.skipTest("Test implementation needed")

class TestUserRepository(unittest.TestCase):
    """Test cases for UserRepository"""
    
    @patch('models.user.database')
    def test_find_by_id(self, mock_db):
        """Test finding user by ID with mocked database"""
        # Arrange
        # TODO: Set up mock database response
        
        # Act
        # TODO: Call find_by_id method
        
        # Assert
        # TODO: Verify user returned and database called correctly
        self.skipTest("Test implementation needed")

if __name__ == '__main__':
    unittest.main()
```