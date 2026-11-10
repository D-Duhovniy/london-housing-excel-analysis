// fx_LoadPricePaidFile
// Custom function. Takes the content of ONE Price Paid CSV file
// and returns London rows only, with proper column names.
// Called once per file by stg_sales.
// Load: Connection only

(fileContent as binary) as table =>
let
    // The files have no header row, so names are assigned here.
    // Order follows the HMLR documentation (16 columns).
    ColumnNames = {
        "transaction_id", "price", "transfer_date", "postcode",
        "property_type", "is_new_build", "tenure",
        "paon", "saon", "street", "locality", "town_city",
        "district", "county", "ppd_category", "record_status"
    },

    // QuoteStyle.Csv: every field is in double quotes and some
    // addresses contain commas, so quotes must be respected.
    // Encoding 65001 = UTF-8.
    Source = Csv.Document(
        fileContent,
        [Delimiter = ",", Columns = 16, Encoding = 65001, QuoteStyle = QuoteStyle.Csv]
    ),

    // Column1..Column16 -> real names
    Renamed = Table.RenameColumns(
        Source,
        List.Zip({Table.ColumnNames(Source), ColumnNames})
    ),

    // Filter as early as possible: about 88% of rows are outside London,
    // so everything after this step works on ~12% of the data.
    LondonOnly = Table.SelectRows(Renamed, each [county] = "GREATER LONDON"),

    // Address columns are not needed for borough-level analysis
    // and county has one value after the filter.
    KeptColumns = Table.SelectColumns(
        LondonOnly,
        {
            "transaction_id", "price", "transfer_date", "postcode",
            "property_type", "is_new_build", "tenure",
            "district", "ppd_category", "record_status"
        }
    )
in
    KeptColumns
