# Decision log

Every decision that changes the data or the scope, with the reason.
If someone asks "why is your number different from X?", the answer should be here.

| ID | Day | Decision | Reason | Impact |
|---|---|---|---|---|
| D-01 | 1 | Use HM Land Registry Price Paid Data, yearly files | Official, free, updated monthly, every sale in England and Wales. Better than Kaggle datasets that are old or synthetic | |
| D-02 | 1 | Limit to Greater London (`county = "GREATER LONDON"`) | Business question is about London. Keeps the model at around 1M rows instead of 10M+ | Filter applied in Power Query |
| D-03 | 1 | Period Jan 2016 to **Jul 2026**, not Sep 2026 | Latest release (28 Oct 2026) includes data to Sep 2026, but sales take up to 2 months to be registered. Aug and Sep 2026 would look like a drop in sales that didn't really happen | Aug to Sep 2026 excluded |
| D-04 | 1 | Use only PPD category `A` | Category B mixes repossessions, company purchases and buy-to-let with a mortgage, and HMLR doesn't say which is which. Category A gives like-for-like market sales. Category B row count will be reported in the data quality log | Planned for Day 3 |
| D-05 | 1 | Exclude property type `O` (Other) | Not a normal home (e.g. several parcels of land), prices are not comparable | Planned for Day 3 |
| D-06 | 1 | Use median, not mean, as the main price KPI | London prices are heavily right-skewed. A few very expensive sales in Westminster or Kensington move the mean a lot | |
| D-07 | 1 | Do not store raw data in the repo | Files are large (100+ MB each). Download steps are in `data/README.md` so anyone can rebuild the workbook | |

## Open questions (to check on Day 2)

- Do yearly files have 16 columns (with `record_status`) or 15?
- `pp-2026.csv` on the download page is listed as only 9.3 MB, which looks too small for 9 months of data. Check row count after download. If it is incomplete, use the monthly files or the report builder for 2026.
- Exact spelling of London district names in the data (for joining with ONS data on Day 7).
