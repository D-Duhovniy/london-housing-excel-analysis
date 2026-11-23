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
| `price` | Min / max |£10,000 / £90,000,000|
| `postcode` | Empty values | 4,574 (0.4%) |
| `property_type` | Distinct values | 5 in stg_sales, 4 in fact_sales |
| `district` | Distinct values | 33 |
| `transfer_date` 

## Observations

- About 20% of London rows were excluded. Almost all of them are category B (19.9% of all London rows, compared with 15.7% in 2016, so the share of category B grew over time).
- Extreme prices (from £1 up to £793m) exist in the source, but they are almost all category B (company and bulk purchases). After cleaning, prices range from £10,000 to £90m.
- The property type O step removes 0 rows: all type O sales are category B, so they are excluded one step earlier.
- The £10,000 threshold removes only 8 rows.
- Aug and Sep 2026 (6,558 rows) were excluded because of the registration lag (D-03).

## Not checked yet

- Duplicate `transaction_id`: planned in the Data Model on Day 4 (D-17).
