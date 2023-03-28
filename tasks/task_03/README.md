# Task 3

## Instructions

Use the `Solution` section below to add notes about your implementation.


### Question
Given a table of brand orders with columns id, brand_id, transaction_value, and created_at representing the date and time for each transaction, write a query to get the last order for each brand for each day.

The output should include the id of the transaction, datetime of the transaction, and the transaction amount. Order the transactions by datetime.

**Example**:

Input:

orders table

| Column            | Type     |
|:-------------------|----------|
| id                | INTEGER  |
| brand_id          | INTEGER  |
| transaction_value | FLOAT    |
| created_at        | DATETIME |


Output:

| Column            | Type     |
|:-------------------|----------|
| id                | INTEGER  |
| transaction_value | FLOAT    |
| created_at        | DATETIME |

### Solution

query that retrieves the last value of the day for each brand

- in the first CTE we're calculating the day of the order derived from the created_at field

- in the second CTE we use the window function last_value to retrieve the last value partitioning by brand and day

- the last select make a comparison between the id and the last value and retrieves only the rows that are equal

in this way we can retrieve the requested rows

I assumed the underlying database is Snowflake I used the date_part and last_value functions