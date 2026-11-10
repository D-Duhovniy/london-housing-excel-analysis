// p_RawFolder
// Path to the folder with raw HM Land Registry CSV files.
// Read from the named cell p_RawFolder on the Settings sheet,
// so the path can be changed without opening Power Query.
// Load: Connection only

let
    Source = Excel.CurrentWorkbook(){[Name = "p_RawFolder"]}[Content]{0}[Column1]
in
    Source
