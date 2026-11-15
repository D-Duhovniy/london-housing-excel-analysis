// chk_monthly
// Check table: number of London sales per month, category, record status
// and data quality reason. Small, loaded to the Checks sheet.
// Day 2: reconciliation with Day 1 numbers, registration lag.
// Day 3: dq_reason added for the data quality log.
// Load: Table on the Checks sheet (tbl_chk_monthly)

let
    Source = int_sales_flagged,

    AddedMonth = Table.AddColumn(
        Source,
        "month",
        each Date.StartOfMonth([transfer_date]),
        type date
    ),

    Grouped = Table.Group(
        AddedMonth,
        {"month", "ppd_category", "record_status", "dq_reason"},
        {{"sales", each Table.RowCount(_), Int64.Type}}
    ),

    Sorted = Table.Sort(
        Grouped,
        {{"month", Order.Ascending}, {"ppd_category", Order.Ascending}, {"dq_reason", Order.Ascending}}
    )
in
    Sorted
