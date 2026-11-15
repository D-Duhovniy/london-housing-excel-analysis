// int_sales_flagged
// Intermediate step: every London row gets ONE data quality reason.
// Rows are not removed here. This makes it possible to count
// how many rows each rule removes (data quality log on the Checks sheet).
//
// The rules are checked in order, and a row gets the FIRST reason that applies.
// Example: a category B sale outside the period is counted as "Out of period" only.
// Load: Connection only

let
    Source = stg_sales,

    Flagged = Table.AddColumn(
        Source,
        "dq_reason",
        each
            if [transfer_date] < p_StartDate or [transfer_date] > p_EndDate then "1. Out of period"          // D-03
            else if [ppd_category] <> "A" then "2. Category B"                                               // D-04
            else if [property_type] = "O" then "3. Property type O"                                          // D-05
            else if [price] < p_MinPrice then "4. Price below minimum"                                       // D-14
            else "5. Included",
        type text
    )
in
    Flagged
