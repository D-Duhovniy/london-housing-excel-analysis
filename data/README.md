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

## 3. Point Power Query at the folder

The folder path is stored in one parameter (`p_RawFolder`) on the `Settings` sheet of the workbook. Change it to your own path and click **Data > Refresh All**.

## Notes

- Data used in this project was downloaded on: _to fill in on Day 2_
- Latest release at that time: 28 October 2026 (data to September 2026)
- Licence: Open Government Licence v3.0. Contains HM Land Registry data © Crown copyright and database right 2026.
