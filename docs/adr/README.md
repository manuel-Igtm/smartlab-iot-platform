# Architecture Decision Records (ADRs)

This directory contains Architecture Decision Records (ADRs) - documents that capture important architectural decisions made in this project, along with their context and consequences.

## What is an ADR?

An Architecture Decision Record (ADR) is a document that captures an important architectural decision made along with its context and consequences.

## Format

Each ADR follows this structure:

```markdown
# ADR-XXX: [Title]

**Status**: [Proposed | Accepted | Deprecated | Superseded]  
**Date**: YYYY-MM-DD  
**Deciders**: [Names]  
**Technical Story**: [Issue/Story Link]

## Context

What is the issue that we're seeing that is motivating this decision or change?

## Decision

What is the change that we're proposing and/or doing?

## Consequences

### Positive
- What becomes easier?
- What benefits do we get?

### Negative  
- What becomes more difficult?
- What are the risks?

### Neutral
- What remains the same?

## Alternatives Considered

1. **Option 1**: Description
   - Pros: ...
   - Cons: ...
   
2. **Option 2**: Description
   - Pros: ...
   - Cons: ...

## References

- Links to relevant documentation
- Related ADRs
```

## Index of ADRs

| ADR | Title | Status | Date |
|-----|-------|--------|------|
| [001](./001-use-django-rest-framework.md) | Use Django REST Framework for API | Accepted | 2025-11-21 |
| [002](./002-use-postgresql-timescaledb.md) | Use PostgreSQL with TimescaleDB | Accepted | 2025-11-21 |
| [003](./003-mqtt-for-device-communication.md) | Use MQTT for Device Communication | Accepted | 2025-11-21 |
| [004](./004-docker-compose-development.md) | Use Docker Compose for Development | Accepted | 2025-11-21 |

## When to Create an ADR

Create an ADR when you make a decision that:
- Affects the structure, functionality, or operation of the system
- Has significant impact on the codebase
- Is difficult or costly to change later
- Involves trade-offs between different approaches
- Requires explanation to future team members

## How to Create an ADR

1. Copy the template above
2. Number it sequentially (e.g., 005)
3. Fill in all sections thoughtfully
4. Discuss with team (if applicable)
5. Commit and link to relevant issues/PRs
6. Update this README index

## CTO Learning Notes

As I build this project, ADRs help me:
- **Think critically** about technical decisions
- **Document reasoning** for future reference
- **Compare alternatives** systematically
- **Learn from mistakes** by reviewing past decisions
- **Communicate clearly** with stakeholders
