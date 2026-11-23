Supply Chain & Inventory Performance Analysis
Project Overview
This project explores supply chain and inventory performance across different regions, suppliers, warehouses and product categories.
Using Python, PostgreSQL, SQL and Microsoft Power BI, the project investigates operational performance, inventory utilisation, supplier lead times, backorder patterns and transportation expenditure.
The objective is to transform raw operational data into meaningful insights that can help identify potential inefficiencies and support better supply chain and inventory management decisions.
Business Problem
Effective supply chain management requires organisations to monitor inventory levels, warehouse capacity, supplier performance, order activities and operational costs.
Without proper analysis, businesses may struggle to identify inventory imbalances, understand backorder patterns, compare supplier performance and monitor transportation expenditure across different regions.
This project addresses these analytical needs by examining the available supply chain dataset and developing a structured business intelligence report.
Project Objectives
The main objectives were to:
•	Evaluate supply chain performance across different regions.
•	Analyse inventory levels and warehouse capacity utilisation.
•	Compare supplier lead times and transportation costs.
•	Identify product categories with higher backorder rates.
•	Examine order status and recorded order accuracy flags.
•	Analyse transportation expenditure and Cost of Goods Sold (COGS).
•	Explore changes in operational metrics over time.
•	Develop an interactive Power BI dashboard for communicating findings.
Tools and Technologies
Tool	Purpose
Python	Dataset inspection and preparation
Pandas	Data manipulation and cleaning
NumPy	Numerical operations
PostgreSQL	Relational database storage
SQL	Business analysis and data querying
pgAdmin	PostgreSQL database management
Microsoft Power BI	Interactive dashboard development
Git & GitHub	Version control and project documentation
Dataset Description
The project uses a supply chain management dataset obtained from GitHub.
Dataset source:
Supply Chain Management Dataset — GitHub
The dataset contains 1,200 records and 15 original columns covering different aspects of supply chain and inventory operations.
Dataset Features
Column	Description
Date	Date associated with the record
Region	Operational region
Category	Product category
Supplier	Supplier associated with the record
Warehouse	Warehouse associated with the record
Order Status	Recorded order status
Units Sold	Number of units sold
Inventory Level	Recorded inventory level
Transportation Cost	Transportation expenditure
Order Accuracy	Boolean order accuracy flag
Lead Time (Days)	Recorded lead time
Backorder	Boolean backorder indicator
COGS	Cost of Goods Sold
Average Inventory	Average inventory value
Warehouse Capacity	Recorded warehouse capacity
An additional analytical column, Inventory Utilisation (%), was derived during preparation.
Project Workflow
The project followed a structured analytical workflow.
1. Business Understanding
Defined the business problem, analytical objectives, project scope and key business questions.
2. Data Acquisition and Exploration
Obtained the dataset and examined its structure, dimensions, data types, categorical distributions, numerical statistics and potential data quality issues.
3. Data Cleaning and Preparation
Standardised column names, reviewed data types, assessed missing values and duplicates, validated numerical fields, checked calculated variables and assessed potential outliers.
4. Database Management
Imported the prepared dataset into PostgreSQL to support structured storage and SQL-based analysis.
5. SQL Business Analysis
Used SQL queries to investigate regional performance, supplier performance, inventory utilisation, backorders, order status, transportation costs, COGS and time-based patterns.
6. Dashboard Development
Connected Power BI to the prepared dataset and developed a four-page interactive dashboard to communicate the analytical findings.
Key Business Questions
The analysis explored the following questions:
1.	Which regions recorded the highest transportation expenditure?
2.	Which suppliers had the longest average lead times?
3.	Which product categories recorded the highest backorder rates?
4.	How were order statuses distributed?
5.	How did inventory utilisation vary across warehouses?
6.	Which warehouses recorded the highest average inventory?
7.	How were units sold distributed across regions?
8.	How did transportation costs and COGS vary across product categories?
9.	How did selected operational metrics change over time?
Key Findings
1. Regional Performance
•	The North region recorded the highest total transportation expenditure, approximately 2.50 million.
•	The West region recorded approximately 168,452 units sold.
•	The North region recorded approximately 170,175 units sold, the highest among the four regions.
•	The East region recorded the highest average transportation cost per record, approximately 7,977.15.
2. Supplier Performance
Supplier	Average Lead Time
Supplier B	16.17 days
Supplier D	16.00 days
Supplier C	15.54 days
Supplier A	15.23 days
Supplier B recorded the highest average lead time, while Supplier A recorded the lowest.
The difference between the highest and lowest averages was relatively small, so these results should be interpreted comparatively rather than as definitive evidence of poor supplier performance.
3. Inventory and Warehouse Performance
Warehouse	Average Inventory Utilisation
Warehouse 2	36.66%
Warehouse 1	35.02%
Warehouse 3	34.80%
Warehouse 2 recorded the highest average inventory utilisation.
The overall average inventory utilisation was approximately 35.48%.
4. Backorder Analysis
Furniture recorded the highest backorder rate among the product categories.
Category	Backorders	Backorder Rate
Furniture	38	12.42%
Clothing	31	9.97%
Accessories	24	8.92%
Electronics	23	7.32%
This indicates that Furniture had the highest proportion of records marked as backorders.
5. Order Status Analysis
Order Status	Records	Percentage
Fulfilled	838	69.83%
Pending	248	20.67%
Canceled	114	9.50%
Fulfilled records represented the largest share of the recorded order statuses.
The percentages describe the distribution of dataset records and should not automatically be interpreted as confirmed order fulfilment rates.
6. Cost Analysis
The dataset recorded approximately:
•	Total transportation cost: 9.27 million.
•	Average transportation cost: 7,723.52.
•	Total COGS: 71.24 million.
•	Average COGS: 59,370.48.
Electronics recorded the highest total transportation expenditure and COGS among the four product categories.
Power BI Dashboard
The interactive Power BI report contains four analytical pages.
Page 1: Supply Chain Overview
Provides an overall view of operational performance, including:
•	Total units sold.
•	Total transportation cost.
•	Average transportation cost.
•	Average lead time.
•	Backorder rate.
•	Average inventory utilisation.
•	Units sold by region.
•	Transportation cost by region.
•	Order status distribution.
•	Monthly units sold trend.
Page 2: Inventory & Warehouse Performance
Focuses on inventory management and warehouse utilisation through:
•	Average inventory by warehouse.
•	Inventory utilisation by warehouse.
•	Backorders by product category.
•	Backorders by region.
•	Inventory utilisation distribution.
Page 3: Supplier & Order Performance
Examines supplier and order-related performance through:
•	Average lead time by supplier.
•	Average transportation cost by supplier.
•	Backorders by supplier.
•	Order status distribution by region.
•	Order accuracy flag distribution by region.
Page 4: Cost & Time Analysis
Provides a closer examination of operational expenditure and trends through:
•	Monthly transportation cost trend.
•	Monthly COGS trend.
•	Transportation cost by product category.
•	COGS by product category.
•	Monthly backorder rate trend.
Project Structure
Supply_Chain_Analysis/
│
├── data/
│   ├── raw/
│   │   └── Inventory_SupplyChain_Dataset.csv
│   │
│   └── processed/
│       └── cleaned_supply_chain_dataset.csv
│
├── notebooks/
│   └── 01_dataset_exploration.ipynb
│
├── sql/
│   └── supply_chain_analysis.sql
│
├── reports/
│   ├── Dataset_Exploration.md
│   ├── Data_Cleaning.md
│   └── SQL_Analysis_Findings.docx
│
├── dashboard/
│   └── Supply_Chain_Performance_Dashboard.pbix
│
└── README.md
Note: Adjust the filenames and folder names in this structure to match the actual files in your repository.
Data Quality and Project Limitations
The analysis was conducted within the limitations of the available dataset.
•	The dataset contains no dedicated transaction or order identifier, so transaction-level uniqueness could not be established.
•	The precise grain of each record is not documented.
•	The business definition of the Order Accuracy flag is unavailable.
•	The dataset does not contain promised delivery dates, so delivery punctuality cannot be evaluated.
•	No reorder points, safety stock levels or inventory forecasts are provided.
•	Revenue and selling prices are unavailable, preventing profit and profit-margin calculations.
•	The date coverage is uneven: 2020 is incomplete, and 2021 contains only one record.
•	Six potential statistical outliers were identified in one numerical column and retained because there was insufficient evidence to classify them as errors.
These limitations should be considered when interpreting the results and making operational recommendations.
Conclusion
This project demonstrates an end-to-end data analytics workflow, from dataset exploration and preparation to relational database management, SQL-based business analysis and interactive Power BI reporting.
The analysis identified differences in regional transportation expenditure, supplier lead times, warehouse utilisation, product-category backorder rates and operational costs.
By combining Python, PostgreSQL, SQL and Power BI, the project demonstrates how raw operational data can be transformed into structured information and presented through business-focused visualisations.
Skills Demonstrated
•	Data cleaning and preparation
•	Exploratory data analysis
•	Python and Pandas
•	Relational database management
•	PostgreSQL
•	SQL querying and aggregation
•	Business intelligence
•	Power BI dashboard development
•	Data visualisation
•	Analytical reporting
•	Business interpretation
Author
Bashir Lawan Isyaku
Software Engineering Graduate | Data Analytics
•	GitHub: lbash-bk
•	LinkedIn: [Bashir Lawan Isyaku](https://www.linkedin.com/in/bashir-lawan-isyaku-231a3b282/)
•	Portfolio: https://lbash-bk.github.io/bashir-lawan-isyaku-portfolio/
________________________________________
This project was developed as part of a practical data analytics portfolio, with an emphasis on SQL, PostgreSQL, business analysis and Power BI.

