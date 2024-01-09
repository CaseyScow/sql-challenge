-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/VBrlJh
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

CREATE TABLE "Department" (
    "dept_no" Varchar(30)   NOT NULL,
    "dept_name" Varchar(30)   NOT NULL,
    CONSTRAINT "pk_Department" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "Dept_emp" (
    "emp_no" Integer   NOT NULL,
    "dept_no" Varchar(30)   NOT NULL
);

CREATE TABLE "Dept_manager" (
    "dept_no" Varchar(30)   NOT NULL,
    "emp_no" Integer   NOT NULL
);

CREATE TABLE "Employees" (
    "emp_no" Integer   NOT NULL,
    "emp_title_id" Varchar(30)   NOT NULL,
    "birth_date" Date   NOT NULL,
    "first_name" Varchar(30)   NOT NULL,
    "last_name" Varchar(30)   NOT NULL,
    "sex" Varchar(30)   NOT NULL,
    "hire_date" Date   NOT NULL,
    CONSTRAINT "pk_Employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "Salaries" (
    "emp_no" Integer   NOT NULL,
    "salary" Integer   NOT NULL,
    CONSTRAINT "pk_Salaries" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "Titles" (
    "title_id" Varchar(30)   NOT NULL,
    "title" Varchar(30)   NOT NULL,
    CONSTRAINT "pk_Titles" PRIMARY KEY (
        "title_id"
     )
);

ALTER TABLE "Dept_emp" ADD CONSTRAINT "fk_Dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Dept_emp" ADD CONSTRAINT "fk_Dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Department" ("dept_no");

ALTER TABLE "Dept_manager" ADD CONSTRAINT "fk_Dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Department" ("dept_no");

ALTER TABLE "Dept_manager" ADD CONSTRAINT "fk_Dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Employees" ADD CONSTRAINT "fk_Employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "Titles" ("title_id");

ALTER TABLE "Salaries" ADD CONSTRAINT "fk_Salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

SELECT * FROM "Department"

SELECT * FROM "Dept_emp"

SELECT * FROM "Dept_manager"

SELECT * FROM "Employees"

SELECT * FROM "Salaries"

SELECT * FROM "Titles"

--Data Analysis Question 1:
SELECT "Employees".emp_no, "Employees".last_name, "Employees".first_name, "Employees".sex, "Salaries".salary
FROM "Employees"
INNER JOIN "Salaries" ON
"Salaries".emp_no = "Employees".emp_no;

--Question 2:
SELECT "Employees".first_name, "Employees".last_name, "Employees".hire_date
FROM "Employees"
WHERE "Employees".hire_date BETWEEN '01/01/1986' AND '12/31/1986';

--Question 3:
SELECT "Department".dept_no, "Department".dept_name, "Dept_manager".emp_no, "Employees".first_name, "Employees".last_name
FROM "Department"
INNER JOIN "Dept_manager"
ON "Department".dept_no = "Dept_manager".dept_no
INNER JOIN "Employees"
ON "Employees".emp_no = "Dept_manager".emp_no;

--Question 4:
SELECT "Department".dept_no, "Department".dept_name, "Employees".emp_no, "Employees".first_name, "Employees".last_name
FROM "Department"
INNER JOIN "Dept_emp"
ON "Department".dept_no = "Dept_emp".dept_no
INNER JOIN "Employees"
ON "Dept_emp".emp_no = "Employees".emp_no;

--Question 5:
SELECT "Employees".first_name, "Employees".last_name, "Employees".sex
FROM "Employees"
WHERE "Employees".first_name = 'Hercules' AND
"Employees".last_name LIKE 'B%';


--Question 6:
SELECT "Department".dept_name, "Employees".emp_no, "Employees".first_name, "Employees".last_name
FROM "Department"
INNER JOIN "Dept_emp"
ON "Department".dept_no = "Dept_emp".dept_no
INNER JOIN "Employees"
ON "Dept_emp".emp_no = "Employees".emp_no
WHERE "Department".dept_name = 'Sales';

--Question 7:
SELECT "Department".dept_name, "Employees".emp_no, "Employees".first_name, "Employees".last_name
FROM "Department"
INNER JOIN "Dept_emp"
ON "Department".dept_no = "Dept_emp".dept_no
INNER JOIN "Employees"
ON "Dept_emp".emp_no = "Employees".emp_no
WHERE "Department".dept_name IN ('Sales', 'Development');

--Question 8:
SELECT "Employees".last_name, COUNT("Employees".last_name)
FROM "Employees"
GROUP BY "Employees".last_name 
ORDER BY COUNT("Employees".last_name) DESC;