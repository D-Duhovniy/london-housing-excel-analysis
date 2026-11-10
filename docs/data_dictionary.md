# Data dictionary

Source: [HM Land Registry, About the Price Paid Data](https://www.gov.uk/guidance/about-the-price-paid-data)

The CSV files come **without a header row** and have **16 columns** (checked on the 2016 file), so column names are assigned in Power Query (`fx_LoadPricePaidFile`).
The `Name in model` column shows the names I use in the workbook.

## Columns (in file order)

| # | Original name | Name in model | Type | Description | Values / codes | Used? |
|---|---|---|---|---|---|---|
| 1 | Transaction unique identifier | `transaction_id` | Text | Unique reference for each sale, in `{GUID}` format | | Yes, key / duplicate check |
| 2 | Price | `price` | Whole number | Sale price stated on the transfer deed, £ | | Yes |
| 3 | Date of Transfer | `transfer_date` | Date | Date the sale was completed | Text like `2016-01-01 00:00`. Parsed explicitly in PQ (see D-10) | Yes |
| 4 | Postcode | `postcode` | Text | Postcode at the time of the sale | Can be blank | Partly (postcode district only) |
| 5 | Property Type | `property_type` | Text (1 char) | Type of property | `D` Detached, `S` Semi-detached, `T` Terraced (incl. end-of-terrace), `F` Flat/Maisonette, `O` Other | Yes |
| 6 | Old/New | `is_new_build` | Text (1 char) | New build or established | `Y` new build, `N` established | Yes |
| 7 | Duration | `tenure` | Text (1 char) | Tenure | `F` Freehold, `L` Leasehold | Yes |
| 8 | PAON | `paon` | Text | House number or name | | No, removed |
| 9 | SAON | `saon` | Text | Flat / unit number | | No, removed |
| 10 | Street | `street` | Text | | | No, removed |
| 11 | Locality | `locality` | Text | | | No, removed |
| 12 | Town/City | `town_city` | Text | | | No |
| 13 | District | `district` | Text | Local authority (in London = borough) | Upper case. 33 values in London (32 boroughs + City of London). Westminster is `CITY OF WESTMINSTER` | Yes, main geography |
| 14 | County | `county` | Text | | `GREATER LONDON` for London | Yes, filter only |
| 15 | PPD Category Type | `ppd_category` | Text (1 char) | Type of entry | `A` standard sale at full market value, `B` additional entry (repossessions, buy-to-let with mortgage, sales to companies, property type `O`) | Yes, filter (see D-04) |
| 16 | Record Status | `record_status` | Text (1 char) | Change flag | `A` added, `C` changed, `D` deleted. Present in yearly files too. In the 2016 file every row is `A` | Checked on all years on Day 2, then dropped |

## Why some columns are removed

Address columns (PAON, SAON, Street, Locality) are not needed for borough-level analysis.
Removing them early makes the model much smaller and faster to refresh, and keeps personal address data out of the workbook.

## Known limitations of the source

- **Not every sale is included.** Excluded: sales not for value, Right to Buy discounts, transfers of a share (e.g. on divorce), gifts, compulsory purchase, court orders, sales inclusive of VAT, and some others.
- **Registration lag.** Sales are registered 2 weeks to 2 months after completion, so the two most recent months are incomplete in every release.
- **No size information.** No floor area or number of bedrooms, so price per square metre can't be calculated. Property type is the only proxy for size.
- **Bungalows** are not identified separately. **End-of-terrace** is inside `T`.
- **Postcodes** are as at the time of sale and are not updated if Royal Mail changes them.
- **Category B** is available only from October 2013 (not a problem for a 2016+ period).

## Additional data (added on Day 7)

ONS earnings data by borough. Documented when added.

## Profile of the 2016 file (Day 1 checks)

| Check | Value |
|---|---|
| Columns | 16 |
| Total rows (England and Wales) | 1,046,796 |
| London rows | 122,634 (11.7%) |
| Date range | 01/01/2016 to 31/12/2016 |
| London districts | 33 |
| Category B share in London | 15.7% |
| `record_status` values | `A` only |
