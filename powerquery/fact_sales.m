// fact_sales
// Final sales table for analysis: one row per included sale.
// Load: Connection only on Day 3, added to the Data Model on Day 4

let
    Source = int_sales_flagged,

    Included = Table.SelectRows(Source, each [dq_reason] = "5. Included"),

    // Postcode district = the part before the space ("SW1A 1AA" -> "SW1A").
    // Full postcodes are almost unique per row, which makes the Data Model
    // much bigger. The district is enough for local analysis (see D-16).
    AddedPostcodeDistrict = Table.AddColumn(
        Included,
        "postcode_district",
        each
            if [postcode] <> null and Text.Contains([postcode], " ")
            then Text.BeforeDelimiter([postcode], " ")
            else null,
        type text
    ),

    // Columns that are not needed after cleaning:
    // postcode -> replaced by postcode_district
    // ppd_category, dq_reason -> always "A" / "5. Included" after the filter
    // record_status -> only "A" in all files (checked on Day 2)
    RemovedColumns = Table.RemoveColumns(
        AddedPostcodeDistrict,
        {"postcode", "ppd_category", "record_status", "dq_reason"}
    )
in
    RemovedColumns
