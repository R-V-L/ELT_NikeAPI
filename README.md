## About

ETL Process using Python, Snowflake, AirFlow and Looker for sales insights. This process retrieves data directly from the [Nike Rest API](https://developer.nike.com/documentation/api-docs.html)

## Pre-Requisites

1. Run the Docker container with the necessary dependencies:
```
docker-compose up -d
```

2. The necessary Python dependencies will need to be installed. 


## Solutions

1. Run the "dag_nike" on Airflow to run the data scrapper, this is the "Extract" part

2. Run the "dag_snowflake" on Airflow, this contains 2 tasks that are run sequentially: the "Load" and "Transform" part.

3. Optionally, employ a Business Intelligence (BI) tool. I opted for Lookerstudio since it met my requirements and was both cost-effective and compatible with Snowflake.

## Challenges

When i was working on this i faced multiple issues, which i had to face along the way:

1. When i was on the data load and data cleaning phase i found duplicates were being uploaded. This seemed to be due to parallel tasks being executed on Airflow. In order to fix this i had to set the "max_active_tasks_for_worker" parameter to 1.

2. Some columns in the CSV files contained the "," character, which was an issue considering that's the same character issued as a CSV separator. The solution was to modify both, the "nikescrapi.py" and "sales_generator.py" files in order to set a different character as a separator (i chose "|").

## Reporting

[https://lookerstudio.google.com/reporting/fe8dfce7-b468-4f0d-9e42-38346dede680](https://lookerstudio.google.com/reporting/fe8dfce7-b468-4f0d-9e42-38346dede680)
