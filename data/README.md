# Getting the data

Raw files are not in the repo (see decision D-07). To rebuild the workbook:

## 1. Download the yearly files

From [Price Paid Data: yearly file](https://www.gov.uk/government/statistical-data-sets/price-paid-data-yearly-file).
Direct links follow this pattern:

```
https://price-paid-data.publicdata.landregistry.gov.uk/pp-2016.csv
https://price-paid-data.publicdata.landregistry.gov.uk/pp-2017.csv
...
https://price-paid-data.publicdata.landregistry.gov.uk/pp-2026.csv
```

11 files in total (2016 to 2026). Each is around 100 to 200 MB.
For some years (2018 to 2023) the site also offers `-part1` / `-part2` files. Use the full file, the parts are only for slow connections.

## 2. Put them in one folder

```
data/raw/
├── pp-2016.csv
├── pp-2017.csv
├── ...
└── pp-2026.csv
```

Power Query loads **every CSV in this folder** (Day 2), so:
- don't rename the files
- don't put any other files in this folder

## 3. Refresh the workbook

Open `excel/london_housing_analysis.xlsx` and click **Data > Refresh All**.

The folder path is built automatically from the workbook location (`<repo>\data\raw\`) on the `Settings` sheet.
If the raw files are somewhere else, type the path into the yellow **override** cell on `Settings`.

A full refresh reads about 1.7 GB of CSV and takes several minutes.

## Notes

- Data used in this project was downloaded on: 08 November 2026
- Latest release at that time: 28 October 2026 (data to September 2026)
- Licence: Open Government Licence v3.0. Contains HM Land Registry data © Crown copyright and database right 2026.
