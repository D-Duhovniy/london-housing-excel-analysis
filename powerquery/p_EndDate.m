// p_EndDate
// Last day of the analysis period (inclusive). Read from the named cell p_EndDate on Settings.
// Set to 31 Jul 2026 because Aug and Sep 2026 are incomplete (see D-03).
// Load: Connection only

let
    Source = Date.From(Excel.CurrentWorkbook(){[Name = "p_EndDate"]}[Content]{0}[Column1])
in
    Source
