# Data quality log

How many London rows each cleaning rule removes.
Numbers come from `tbl_chk_monthly` on the `Checks` sheet (Power Query `chk_monthly`), refreshed on: _date_

Rules are applied in this order, and each row is counted under the **first** rule it breaks (see D-15).

## Summary (all London rows, Jan 2016 to Sep 2026)

| Step | Rule | Decision | Rows | % of London rows |
|---|---|---|---:|---:|
| | All London rows in the source files | | _ | 100.0% |
| 1 | Transfer date outside Jan 2016 to Jul 2026 | D-03 | _ | _ |
| 2 | PPD category B | D-04 | _ | _ |
| 3 | Property type O (Other) | D-05 | _ | _ |
| 4 | Price below £10,000 | D-14 | _ | _ |
| | **Included in analysis** | | **_** | **_** |

![Data quality waterfall](../images/day03_dq_waterfall.png)

## Profile of `stg_sales` (Power Query column profiling, entire dataset)

| Column | Check | Result |
|---|---|---|
| `price` | Min / max | _ / _ |
| `postcode` | Empty values | _ |
| `property_type` | Distinct values | _ |
| `district` | Distinct values | _ |
| `transfer_date` | Min / max | _ / _ |

## Observations

- _what stood out, filled in after the refresh_

## Not checked yet

- Duplicate `transaction_id`: planned in the Data Model on Day 4 (D-17).
