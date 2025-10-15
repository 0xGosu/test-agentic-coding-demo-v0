---
inclusion: fileMatch
fileMatchPattern: "**/*requirements.md"
---

- You MUST format the initial requirements.md document with:
  - A clear "Introduction" section that summarizes the entire product or new feature
  - A "Functional Requirements" section with minimum of 2 functional requirements 
  - A "Non-Functional Requirements" section with minium of 1 non-functional requirement
  - Both sections contain a hierarchical numbered list of requirements where each contains:
    - A user story in the format "As a [role], I want [feature], so that [benefit]"
    - A numbered list of acceptance criteria in EARS+ format
  - Each requirement must be identified by an unique identifier (e.g., FR1, FR2, NFR1)
- You MUST use EARS+ requirements syntax as described in the <ears_plus> section
- Use the following example format when creating the requirements.md document:
```md
# Requirements Document

## Introduction

[Introduction text here]

## Functional Requirements

### FR1

**User Story:** As a [role], I want [feature], so that [benefit]

#### Acceptance Criteria

1. WHEN [event] THEN [system] SHALL [response]
2. IF [pre-condition] THEN [system] SHALL [response]
  
### FR2

**User Story:** As a [role], I want [feature], so that [benefit]

#### Acceptance Criteria

1. WHEN [event] THEN [system] SHALL [response]
2. WHEN [event] AND [event-condition] THEN [system] SHALL [response]
3. WHILE [state-condition] THEN [system] SHALL [response]
4. IF [pre-condition] WHEN [event] AND [event-condition] THEN [system] SHALL [response]
5. WHILE [state-condition] WITH [pre-condition] WHEN [event] AND [event-condition] THEN [system] SHALL [response]

## Non-Functional Requirements

### NFR1

**User Story:** As a [role], I want [feature], so that [benefit]

#### Acceptance Criteria

1. WHEN [event] THEN [system] SHALL [response]
2. WHEN [event] THEN [system] SHALL [response]
3. IF [pre-condition] THEN [system] SHALL [response]
4. WHILE [state-condition] THEN [system] SHALL [response]
```

<ears_plus>

# The EARS+ Patterns

## Generic EARS Syntax
The clauses of a requirement written in EARS always appear in the same order. The basic structure of an EARS requirement is:

```
While <optional pre-condition>, when <optional trigger>, the <system name> shall <system response>
```

The EARS ruleset states that a requirement must have:  
- Zero or one state-condition
- Zero or many pre-conditions  
- Zero or one trigger
- Zero or many trigger-conditions  
- One system name  
- One or many system responses  

The application of the EARS notation produces requirements in a small number of patterns, depending on the clauses that are used. The patterns are illustrated below.

---

## Ubiquitous Requirements
Ubiquitous requirements are always active (so there is no EARS keyword):

```
The <system name> shall <system response>
```

**Example:**  
The mobile phone shall have a mass of less than XX grams.

---

## State Driven Requirements
State driven requirements are active as long as the specified state remains true and are denoted by the keyword **While**:

```
While <state-condition>, the <system name> shall <system response>
```

**Example:**  
While there is no card in the ATM, the ATM shall display “insert card to begin”.

---

## Event Driven Requirements
Event driven requirements specify how a system must respond when a triggering event occurs and are denoted by the keyword **When**:

```
When <trigger>, the <system name> shall <system response>
```

**Example:**  
When “mute” is selected, the laptop shall suppress all audio output.

---

## Optional Feature Requirements
Optional feature requirements apply in products or systems that include the specified feature and are denoted by the keyword **Where**:

```
Where <feature is included>, the <system name> shall <system response>
```

**Example:**  
Where the car has a sunroof, the car shall have a sunroof control panel on the driver door.

---

## Unwanted Behaviour Requirements
Unwanted behaviour requirements specify the required system response to undesired situations and are denoted by the keywords **If** and **Then**:

```
If <pre-condition>, then the <system name> shall <system response>
```

**Example:**  
If an invalid credit card number is entered, then the website shall display “please re-enter credit card details”.

---

## Complex Requirements
The simple building blocks of the EARS patterns can be combined to specify requirements for richer system behaviour. Requirements that include more than one EARS keyword are called **Complex requirements**:

```
While <state-condition> With <pre-condition>, When <trigger>, the <system name> shall <system response>
```

**Example:**  
While the aircraft is on ground With both engines are on, when reverse thrust is commanded, the engine control system shall enable reverse thrust.

Complex requirements for unwanted behaviour also include the **If-Then** keywords.

</ears_plus>