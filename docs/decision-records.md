# Decision Records

We use Markdown Any Decision Records (MADR) version 3.0.0.

In general we will follow the [HDI Way of Working](https://github.com/HealthDataInsight/way_of_working), so these records will generally cover decisions that:

- are not already covered in the HDI Way of Working
- are covered in the HDI Way of Working, but have specific implementation details which need to be captured
- diverge from the guidance in the HDI Way of Working

You can read about the general approach on the [GDS Way page on Architecture Decisions](https://gds-way.cloudapps.digital/standards/architecture-decisions.html) and specifics about MADR is available at <https://adr.github.io/madr/>.

Proposing and reviewing decisions requires an understanding of GitHub and [pull requests](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/about-pull-requests).

## Create a new ADR

### Manual approach

1. Copy `docs/decisions/adr-template.md` to `docs/decisions/NNNN-title-with-dashes.md`, where `NNNN` indicates the next number in sequence.
2. Edit `NNNN-title-with-dashes.md`.

Note you can also use [other patterns for the directory format](https://github.com/joelparkerhenderson/architecture_decision_record#adr-file-name-conventions).
As a consequence, some existing tooling might not be applicable.

The filenames are following the pattern `NNNN-title-with-dashes.md`, where

* `NNNN` is a consecutive number and we assume that there won't be more than 9,999 ADRs in one repository.
* the title is stored using dashes and lowercase, because [adr-tools] also does that.
* the suffix is `.md`, because it is a [Markdown](https://github.github.com/gfm/) file.

Decisions are placed in the subfolder `decisions/` to keep them close to the documentation but also separate the decisions from other documentation.

### Automatic approach

There is currently no tooling supporting MADR 3.0.0.
