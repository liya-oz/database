# Prep exercise week 3

As a preparation step for the upcoming Q&A, you need to work on the following exercise, which is based on the prep
exercise of the previous week.

## Exercise

Last week you created an ERD for the database for storing food recipes.
How can you normalize your database based on what you learned this week?
In particular, try answering following questions and provide table definitions from the last week
and this week to explain the changes.

- Was your database already in 2NF / 3 NF?
    - the database is 1NF compliant: 
        - all attributes are atomic
        - no duplicate data groups
        - each table has a primary key
    - the database is 2NF compliant: 
        - 1NF database
        - tables use composite keys and all their non-key attributes depend on the complete key
        - tables with simple keys have only attributes that depend on that key.
    - the database is 3NF compliant:
        - 2NF database
        - all attributes in each table directly depend only on its primary key
        - no transitive dependencies
    So my DB was already in 3NF.

- What changes did you have to do to normalize your database?
    - Need to add indexes to category_id, step_id, and ingredient_id to improve query       performance

## Discussion

- If you want to add thousands of recipes to your database, what challenges do you foresee?
- Try to write answers to these questions in text, provide queries and commands when necessary.

I added indexes and partitioning for recipes:
- Indexes improve search and query execution related to frequent filter conditions (WHERE, JOIN).
- Partitioning speeds up read and write operations for large amounts of data

CREATE INDEX idx_recipe_category ON Recipe_Category(category_id);
CREATE INDEX idx_recipe_ingredient ON Recipe_Ingredient(ingredient_id);
CREATE INDEX idx_recipe_step ON Recipe_Step(step_id);

CREATE TABLE Recipes_Partitioned (
    recipe_id INT PRIMARY KEY,
    recipe_name VARCHAR(255),
    description TEXT
)
PARTITION BY LIST (category_id) (
    PARTITION bakery VALUES IN (1, 2),
    PARTITION main_course VALUES IN (3, 4),
    PARTITION beverages VALUES IN (5) 
);