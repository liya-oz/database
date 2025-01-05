import { createConnection } from 'mysql2/promise';
import fs from 'fs';

async function main() {
  // Create MySQL connection
  const connection = await createConnection({
    host: 'localhost',
    user: 'hyfuser',
    password: 'hyfpassword',
  });

  // Read the JSON data from the file
  const recipesData = fs.readFileSync('./recipes.json');
  const data = JSON.parse(recipesData);

  // Create database and tables if not exists
  const queries = [
    `CREATE DATABASE IF NOT EXISTS recipes_db`,
    `USE recipes_db`,
    `CREATE TABLE IF NOT EXISTS Diet_Types (
      DietTypeID INT AUTO_INCREMENT PRIMARY KEY,
      Name VARCHAR(100) NOT NULL UNIQUE
    )`,
    `CREATE TABLE IF NOT EXISTS Categories (
      CategoryID INT AUTO_INCREMENT PRIMARY KEY,
      Name VARCHAR(100) NOT NULL UNIQUE
    )`,
    `CREATE TABLE IF NOT EXISTS Ingredients (
      IngredientID INT AUTO_INCREMENT PRIMARY KEY,
      Name VARCHAR(100) NOT NULL UNIQUE
    )`,
    `CREATE TABLE IF NOT EXISTS Recipes (
      RecipeID INT AUTO_INCREMENT PRIMARY KEY,
      Name VARCHAR(200) NOT NULL UNIQUE,
      Steps TEXT NOT NULL,
      DietTypeID INT,
      FOREIGN KEY (DietTypeID) REFERENCES Diet_Types(DietTypeID) ON DELETE SET NULL
    )`,
    `CREATE TABLE IF NOT EXISTS Recipe_Categories (
      RecipeID INT,
      CategoryID INT,
      FOREIGN KEY (RecipeID) REFERENCES Recipes(RecipeID),
      FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
    )`,
    `CREATE TABLE IF NOT EXISTS Recipe_Ingredients (
      RecipeID INT,
      IngredientID INT,
      Quantity VARCHAR(100),
      FOREIGN KEY (RecipeID) REFERENCES Recipes(RecipeID),
      FOREIGN KEY (IngredientID) REFERENCES Ingredients(IngredientID)
    )`,
  ];

  for (const query of queries) {
    await connection.query(query);
  }

  // Insert data into tables
  const insertData = async (table, column, values) => {
    for (const value of values) {
      await connection.query(
        `INSERT IGNORE INTO ${table} (${column}) VALUES (?)`,
        [value],
      );
    }
  };

  await insertData('Diet_Types', 'Name', data.dietTypes);
  await insertData('Categories', 'Name', data.categories);
  await insertData('Ingredients', 'Name', data.ingredients);

  for (const recipe of data.recipes) {
    const [recipeResult] = await connection.query(
      `INSERT IGNORE INTO Recipes (Name, Steps, DietTypeID) VALUES (?, ?, (SELECT DietTypeID FROM Diet_Types WHERE Name = ?))`,
      [recipe.name, recipe.steps.join(' '), recipe.dietType],
    );

    if (recipeResult.insertId) {
      for (const category of recipe.categories) {
        const [categoryResult] = await connection.query(
          `SELECT CategoryID FROM Categories WHERE Name = ?`,
          [category],
        );
        if (categoryResult.length > 0) {
          await connection.query(
            `INSERT INTO Recipe_Categories (RecipeID, CategoryID) VALUES (?, ?)`,
            [recipeResult.insertId, categoryResult[0].CategoryID],
          );
        }
      }

      for (const ingredient of recipe.ingredients) {
        const [ingredientResult] = await connection.query(
          `SELECT IngredientID FROM Ingredients WHERE Name = ?`,
          [ingredient],
        );
        if (ingredientResult.length > 0) {
          await connection.query(
            `INSERT INTO Recipe_Ingredients (RecipeID, IngredientID, Quantity) VALUES (?, ?, ?)`,
            [recipeResult.insertId, ingredientResult[0].IngredientID, ''],
          );
        }
      }
    } else {
      console.log(`Failed to insert recipe: ${recipe.name}`);
    }
  }

  // Queries to get specific recipes
  const queriesToGetRecipes = [
    `SELECT r.Name FROM Recipes r
     JOIN Recipe_Ingredients ri ON r.RecipeID = ri.RecipeID
     JOIN Ingredients i ON ri.IngredientID = i.IngredientID
     JOIN Diet_Types dt ON r.DietTypeID = dt.DietTypeID
     WHERE dt.Name = 'Vegetarian' AND i.Name = 'Potatoes'`,

    `SELECT r.Name FROM Recipes r
     JOIN Recipe_Categories rc ON r.RecipeID = rc.RecipeID
     JOIN Categories c ON rc.CategoryID = c.CategoryID
     WHERE c.Name = 'Cake' AND c.Name = 'No-Bake'`,

    `SELECT r.Name FROM Recipes r
     JOIN Diet_Types dt ON r.DietTypeID = dt.DietTypeID
     JOIN Recipe_Categories rc ON r.RecipeID = rc.RecipeID
     JOIN Categories c ON rc.CategoryID = c.CategoryID
     WHERE dt.Name = 'Vegan' AND c.Name = 'Japanese'`,
  ];

  for (const query of queriesToGetRecipes) {
    const [rows] = await connection.query(query);
    console.log(rows);
  }

  // Close the connection
  connection.end();
}

main().catch(console.error);
