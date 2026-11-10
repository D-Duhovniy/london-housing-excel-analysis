// chk_monthly
// Check table: number of London sales per month, category and record status.
// Small (~250 rows), loaded to the Checks sheet.
// Used to reconcile with Day 1 numbers and to see the registration lag
// at the end of the period.
// Load: Table on the Checks sheet

let
    Source = stg_sales,

    AddedMonth = Table.AddColumn(
        Source,
        "month",
        each Date.StartOfMonth([transfer_date]),
        type date
    ),

    Grouped = Table.Group(
        AddedMonth,
        {"month", "ppd_category", "record_status"},
        {{"sales", each Table.RowCount(_), Int64.Type}}
    ),

    Sorted = Table.Sort(
        Grouped,
        {{"month", Order.Ascending}, {"ppd_category", Order.Ascending}}
    )
in
    Sorted
