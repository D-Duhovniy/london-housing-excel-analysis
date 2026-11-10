# Excel conventions used in this workbook

Rules I follow so the workbook is easy to read, check and change.

## Structure

Sheets go from summary to detail, left to right:

```
Cover → Dashboard → Analysis sheets → Settings → Checks → Notes
```

Raw data is not stored on sheets. It lives in the Data Model (loaded by Power Query).

## Inputs, calculations, outputs

- No hardcoded numbers inside formulas. Every assumption (dates, thresholds, rates) is a named cell on the `Settings` sheet.
- Power Query reads its parameters from the same sheet, so nobody has to open the query editor to change a path or a date.

## Colour code

| Style | Meaning |
|---|---|
| Blue font, light yellow fill | Input, typed by hand, can be changed |
| Black font | Formula, do not overwrite |
| Green font | Link to another sheet |

## Sheet layout

- Column A is a narrow margin.
- `B1`: sheet title. `B2`: one line about what the sheet shows.
- Table headers: bold, bottom border, units in the header (`Median price (£)`, `Share (%)`).
- Numbers right-aligned, text left-aligned.
- No merged cells. `Center Across Selection` is used instead.
- Gridlines hidden on presentation sheets.

## Number formats

| Type | Format | Example |
|---|---|---|
| Counts | `#,##0` | 122,634 |
| Money | `£#,##0` | £520,000 |
| Percent | `0.0%` | 15.7% |
| Date | `dd/mm/yyyy` or `mmm yyyy` | 31/07/2026, Jul 2026 |

## Formulas

- Structured references to tables (`tbl_sales[price]`), not fixed ranges.
- Same formula across a whole column.
- No `INDIRECT` or `OFFSET` (volatile, slow on large workbooks).
- `LET` for long formulas, so each part has a name.

## Naming

| Object | Rule | Example |
|---|---|---|
| Workbook | lower case, underscores | `london_housing_analysis.xlsx` |
| Sheets | short, English, Title Case | `Dashboard`, `Boroughs` |
| Tables | `tbl_` prefix | `tbl_chk_monthly` |
| Named cells (parameters) | `p_` prefix | `p_RawFolder` |
| Power Query | `p_`, `fx_`, `stg_`, `fact_`, `dim_`, `chk_` | see [powerquery/README.md](../powerquery/README.md) |

## Checks

The `Checks` sheet has one row per check with Expected, Actual, Difference and OK? (`TRUE`/`FALSE`).
A summary cell at the top shows whether **all** checks pass.
