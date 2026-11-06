# Business framing

## Stakeholder

**Head of Strategy** at a mid-size London estate agency (fictional company).
The agency has branches in a few boroughs and plans to open 2 or 3 new ones in 2027.

## Decision this analysis supports

> Which London boroughs should the agency prioritise for new branches and marketing spend in 2027?

An estate agency earns a commission on each sale, so for this decision two things matter most:
- **how many sales** happen in a borough (volume = number of potential deals)
- **how much each sale is worth** (price = size of the commission)

Growth trend and affordability show whether that volume is likely to hold up.

## Business questions

| # | Question | Why it matters for the decision |
|---|---|---|
| Q1 | How did prices and volumes change in London 2016 to 2026? What did the Brexit vote, the stamp duty holiday and the 2022 rate rise do to the market? | Sets the context. Shows how sensitive the market is to shocks. |
| Q2 | Which boroughs grew the most and which fell behind (price and volume)? | Direct input for the shortlist. |
| Q3 | Do flats and houses move differently? | The agency may need to specialise by property type in some boroughs. |
| Q4 | How big is the new-build premium and where is it highest? | New-build developers are a separate client segment. |
| Q5 | Is there seasonality in sales volume? | Staffing and timing of marketing campaigns. |
| Q6 | How affordable is each borough for a buyer on the local median salary? | Low affordability = higher risk that volume drops. |

## KPIs

| KPI | Definition | Note |
|---|---|---|
| Sales volume | Count of transactions | Main demand indicator |
| Median price | Median of `price` | Median, not mean: a few £10m+ sales push the mean up a lot |
| Total value | Sum of `price` | Proxy for the commission pool |
| YoY change | Change vs same period last year, % | For both price and volume |
| New-build premium | Median new-build price / median established price - 1 | Same borough, same property type |
| Price-to-earnings ratio | Median price / median annual earnings in the borough | Standard affordability measure |

## Scope

**In scope**
- Greater London, 33 local authority districts (32 boroughs plus the City of London)
- Residential sales, Jan 2016 to Jul 2026
- Standard market-value sales (PPD category A), see decision D-04

**Out of scope**
- Rental market
- Commercial property
- Price forecasting (only descriptive and diagnostic analysis)
- Inflation-adjusted prices (may be added later as an extension)

## Deliverables

1. Excel workbook with the full pipeline (Power Query, Data Model, analysis sheets, dashboard)
2. One-page PDF summary with the dashboard and key recommendations
3. This repository with documentation
