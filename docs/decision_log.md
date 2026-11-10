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
| D-08 | 1 | Build for Excel 2021 compatibility: no LAMBDA, VSTACK, TEXTSPLIT, GROUPBY | This is the version I have. A workbook built for 2021 also opens and works in Microsoft 365, the reverse is not true | Reusable logic done with LET and named ranges instead of LAMBDA |
| D-09 | 2 | Load data with Power Query into the Data Model, not onto worksheets | One yearly file (2016) has 1,046,796 rows, close to the sheet limit of 1,048,576. The 2021 file is bigger and would be cut silently. Ten years of data is around 10M rows | All loading in Power Query |
| D-10 | 2 | Parse `transfer_date` explicitly from ISO text (`yyyy-mm-dd`) | When the CSV was opened in Excel directly, dates came in as text and depended on regional settings. ISO parsing gives the same result on any PC | `Date.FromText(Text.Start(...))` in `stg_sales` |
| D-11 | 2 | Filter to London and drop address columns inside the per-file function, before combining files | About 88% of rows are outside London. Dropping them first makes refresh faster and uses less memory | `fx_LoadPricePaidFile` |
| D-12 | 2 | Keep the source file name on every row (`source_file`) | Lineage: any row can be traced back to its file | Column in `stg_sales` |
| D-13 | 2 | Read Power Query parameters from named cells on the `Settings` sheet. Raw folder path is built from the workbook location | Anyone who clones the repo can refresh without editing queries | `p_RawFolder` |

## Resolved questions (Day 1 checks)

| Question | Answer |
|---|---|
| 15 or 16 columns in yearly files? | 16, `record_status` is included |
| Is `pp-2026.csv` complete? | Yes. 75.9 MB, not 9.3 MB as listed on the download page |
| How are London districts spelled? | Upper case. 33 values. Westminster is `CITY OF WESTMINSTER`, so joins with ONS data must use codes, not names (Day 4) |
| Category B share in London | 15.7% in 2016. A with/without B sensitivity check is planned for Day 5 |
| `record_status` values | Only `A` in 2016. Checked on all years on Day 2 |
