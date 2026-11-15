// p_MinPrice
// Sales below this price are treated as non-market (see D-14).
// Read from the named cell p_MinPrice on Settings.
// Load: Connection only

let
    Source = Number.From(Excel.CurrentWorkbook(){[Name = "p_MinPrice"]}[Content]{0}[Column1])
in
    Source
