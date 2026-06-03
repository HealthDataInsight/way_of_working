---
has_children: true
---
# Decision Records

We use [Markdown Any Decision Records (MADR)](https://adr.github.io/madr/) version 3.0.0.

In general, projects will follow the organisation's way of working and so decisions captured within individual projects will generally cover decisions that:

- are not already covered in the Way of Working
- are covered in the Way of Working, but have specific implementation details which need to be captured
- diverge from the guidance in the Way of Working

## Create a new decision record

### Manual approach

1. Copy `docs/decisions/adr-template.md` to `docs/decisions/NNNN-title-with-dashes.md`, where `NNNN` indicates the next number in sequence.
2. Edit `NNNN-title-with-dashes.md`.

Note you can also use [other patterns for the directory format](https://github.com/joelparkerhenderson/architecture_decision_record#adr-file-name-conventions).
As a consequence, some existing tooling might not be applicable.

The filenames are following the pattern `NNNN-title-with-dashes.md`, where

- `NNNN` is a consecutive number and we assume that there won't be more than 9,999 ADRs in one repository.
- the title is stored using dashes and lowercase, because [adr-tools] also does that.
- the suffix is `.md`, because it is a [Markdown](https://github.github.com/gfm/) file.

Decisions are placed in the subfolder `decisions/` to keep them close to the documentation but also separate the decisions from other documentation.

### Automatic approach

To create a new decision record, run:

```bash
way_of_working new decision_record [NAME]
```

Where `[NAME]` is the title of your decision record, for example:

```bash
way_of_working new decision_record "Use Markdown Any Decision Records"
```

## Project decision records

Decision records for this project are listed below.
