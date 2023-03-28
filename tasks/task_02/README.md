# Task 2

## Instructions
Implementation: Input data is a jsonl file, for the assignment purpose the desired ouput should be a csv file. Feel free to use any programming language you prefer.

Evaluation: Your work will be evaluated based on the completeness of the ETL process, the accuracy of the data transformation, the efficiency of the ETL code, and the quality of the documentation and test results.

You can use the `Solution` section to add notes about your implementation, add files containing the solution inside the current folder along instructions about the ETL execution.

### Question

Given the dataset inside the folder `data` implement an ETL that clean and flatten data removing duplicates and add the following columns:

year (YYYY)
year-month (YYYYMM) zero filled
year-quarter (YYYYQ#)
year-week (YYYYWXX) ISO week zero filled
weekday (1:mon-7:sun)

### Solution

the python code i developed leverages the pandas and json libraries, here are the steps i followed:
- I read the json file and transformed it into a dataframe
- then i used the json_normalize to unpack the nested json but it needed to be a dict so I had to transform the df into a dictionary first
- because i found myself in renaming, dropping and lowering the case of column values I created three functions that are reused later in the code
- I didn't find any duplicates in the data but I left the drop_duplicates() function anyway for the purpose of the exercise
- I dropped three columns, shipping address, order total and shipping address county because all the data was null
  and in particular the first two columns were a result of the json normalize so i had all the remaining details
- i renamed the resulting columns created by the split with more meaningful names, then made lower case City and State or Region
  because for example Milano and milano can be seen as different values. Finally i created the requested calculated column, i used 
  the LastUpdatedDate field as a base for all the date calculations.

P.S. I've used python only for 6 months so bear with me :-)