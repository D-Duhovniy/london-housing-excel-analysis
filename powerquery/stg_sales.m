// stg_sales
// Staging table: all yearly files combined, London only, typed.
// No business filters yet (category, property type, period).
// Those are added on Day 3.
// Load: Connection only (will be added to the Data Model on Day 4)

let
    Source = Folder.Files(p_RawFolder),

    // Only pp-YYYY.csv files. Protects against other files
    // accidentally saved in the folder.
    PpFiles = Table.SelectRows(
        Source,
        each Text.Lower([Extension]) = ".csv" and Text.StartsWith([Name], "pp-")
    ),

    KeptFileColumns = Table.SelectColumns(PpFiles, {"Name", "Content"}),

    // Run the custom function on every file
    Loaded = Table.AddColumn(
        KeptFileColumns,
        "data",
        each fx_LoadPricePaidFile([Content])
    ),

    RemovedContent = Table.RemoveColumns(Loaded, {"Content"}),

    // Keep the file name for lineage: every row knows which file it came from
    RenamedFile = Table.RenameColumns(RemovedContent, {{"Name", "source_file"}}),

    Expanded = Table.ExpandTableColumn(
        RenamedFile,
        "data",
        {
            "transaction_id", "price", "transfer_date", "postcode",
            "property_type", "is_new_build", "tenure",
            "district", "ppd_category", "record_status"
        }
    ),

    // Dates come as text "2016-01-01 00:00".
    // Take the first 10 characters (ISO format yyyy-mm-dd) and convert explicitly.
    // ISO dates are read the same way on any PC, whatever the regional settings.
    DateParsed = Table.TransformColumns(
        Expanded,
        {{"transfer_date", each Date.FromText(Text.Start(_, 10)), type date}}
    ),

    Typed = Table.TransformColumnTypes(
        DateParsed,
        {
            {"source_file", type text},
            {"transaction_id", type text},
            {"price", Int64.Type},
            {"postcode", type text},
            {"property_type", type text},
            {"is_new_build", type text},
            {"tenure", type text},
            {"district", type text},
            {"ppd_category", type text},
            {"record_status", type text}
        }
    )
in
    Typed
