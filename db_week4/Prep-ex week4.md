
### Prep-Ex Week 4

#### 1. What are the collections?

Collections in MongoDB are equivalent to tables in a SQL database, but they don’t require a predefined schema, offering greater flexibility.

#### 2. What information will you embed in a document and which will you store normalized?

I would embed small, related data that is frequently used alongside the main document.

### Discussion

#### 1. What made you decide when to embed information? What assumptions did you make?

I choose to embed data when it's small, infrequently updated, or is often used together with the main element. For example, in the recipe database, embedding references to `dietType` and `category` within the `Recipe` document is more efficient than storing them as separate documents. This approach is suitable for data that is closely associated with the main document and doesn't require frequent updates.

#### 2. If you were given MySQL and MongoDB as choices to build the recipe's database at the beginning, which one would you choose and why?

I would choose MySQL because I believe recipes have a consistent structure with fixed attributes that rarely change. MySQL would be ideal for managing recipes efficiently, especially when dealing with large datasets that have a consistent schema. For data that follows a predefined structure, SQL databases offer better performance and reliability.
