---
layout: page
status: REQUIRED
enforcement: manual
---
# Decision Records

## Purpose

We use [Markdown Any Decision Records (MADR)][madr] v3.0.0 to capture project decisions that:

- aren't covered in the [Way of Working][wow]
- need project-specific implementation details
- diverge from Way of Working guidance

{: .note }
Proposing and reviewing decisions requires familiarity with [GitHub pull requests][gh-pr].

## Scope

Applies to decisions about:

- **Architecture**: System design, technology stack, frameworks
- **Process**: Development workflows, deployment, testing
- **Code standards**: Patterns, conventions, library usage
- **Dependencies**: Adding/removing major libraries or services
- **Data**: Schema changes, migration strategies

**Create ADR when:**

- Impact spans multiple components or teams
- Long-term consequences or significant cost/risk
- Multiple viable alternatives exist

**Don't create ADR for:**

- Already covered by Way of Working
- Tactical implementation details (use code comments)
- Temporary workarounds or clear-cut choices

## Requirements

**File naming:** `NNNN-title-with-dashes.md`

- `NNNN` = consecutive four-digit number (0001, 0002, etc.)
- Lowercase title with dashes
- Located in `docs/decisions/`

**Required content:**

1. Status (proposed, accepted, rejected, deprecated, superseded)
2. Context and problem statement
3. Considered options (minimum 2)
4. Decision outcome with justification
5. Positive and negative consequences

**Status lifecycle:**

- **proposed** - Under discussion
- **accepted** - Approved for implementation
- **rejected** - Decided against
- **deprecated** - No longer relevant
- **superseded** - Replaced by newer ADR (link required)

## Setup

```bash
way_of_working init decision_record
```

## Usage

### Create a new decision record

```bash
way_of_working new decision_record "Use Markdown Any Decision Records"
```

**Propose decision:**

1. Create ADR with status "proposed"
2. Open PR, tag stakeholders
3. Discuss in PR comments
4. Update to "accepted" once consensus reached
5. Merge PR

**Supersede existing ADR:**

1. Create new ADR
2. Update old ADR status to "superseded by [0XXX-new-title.md](0XXX-new-title.md)"
3. Explain what changed in new ADR

## Enforcement

**PR Review:**

- All ADRs submitted via PR
- Maintainer approval required
- Verify MADR template structure, file naming, location
- Check minimum 2 options with justification

**Quality checklist:**

- ✅ Multiple alternatives with pros/cons
- ✅ Clear context and constraints
- ✅ Explicit trade-offs
- ❌ Only one option presented
- ❌ Missing justification or context

**Maintenance:**

- Quarterly review for relevance
- Update deprecated/superseded status as needed

## Examples

**Database choice:**

```markdown
# Use PostgreSQL for Primary Database

**Status:** accepted
**Date:** 2025-10-15

## Context and Problem Statement

Need relational database for user data with complex relationships.
Constraints: ACID compliance, 100K users/1M records, prefer open-source.

## Considered Options

1. PostgreSQL (self-hosted)
2. MySQL
3. RDS PostgreSQL

## Decision Outcome

**Chosen:** PostgreSQL (self-hosted)

**Pros:** Open-source, advanced features (JSON, full-text search), ACID, team experience
**Cons:** DevOps overhead, manual backup, manual scaling

**Why:** Meets requirements within budget. Cloud-managed exceeds budget by 40%.
Team expertise mitigates complexity.

**Alternatives rejected:**
- MySQL: No advantage over PostgreSQL
- RDS: Cost $200-500/month exceeds budget
```

**Superseded ADR:**

```markdown
# Use Jest for Frontend Testing

**Status:** superseded by [0015-use-vitest.md](0015-use-vitest.md)
**Date:** 2025-01-10 (original), 2025-09-15 (superseded)

**Why superseded:** Vitest now standard for Vite projects,
better integration and performance.
```

**Rejected decision:**

```markdown
# Use GraphQL for API Layer

**Status:** rejected
**Date:** 2025-03-20

## Decision Outcome

**Chosen:** Continue with REST API

**Why rejected:**
- Current REST meets all requirements
- Team lacks GraphQL expertise (4-6 week learning curve)
- Migration cost: 8 engineer-weeks
- No client needs GraphQL features

**Reconsider when:** Multiple clients need flexible fetching
or over-fetching impacts performance.
```

## Resources

- [MADR Documentation][madr]
- [GDS Architecture Decisions][gds-way]
- [Way of Working CLI][wow-cli]

[madr]: https://adr.github.io/madr/
[wow]: https://github.com/HealthDataInsight/way_of_working
[gds-way]: https://gds-way.digital.cabinet-office.gov.uk/standards/architecture-decisions.html
[gh-pr]: https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/about-pull-requests
[wow-cli]: ../cli.md
