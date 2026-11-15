// p_StartDate
// First day of the analysis period. Read from the named cell p_StartDate on Settings.
// Load: Connection only

let
    Source = Date.From(Excel.CurrentWorkbook(){[Name = "p_StartDate"]}[Content]{0}[Column1])
in
    Source
