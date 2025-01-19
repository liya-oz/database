CREATE DATABASE IF NOT EXISTS recipes_db;
USE recipes_db;

CREATE TABLE Diet_Types (
    DietTypeID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Category (
    CategoryId INT AUTO_INCREMENT PRIMARY KEY,
    CategoryName VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE SubCategory (
    SubCategoryId INT AUTO_INCREMENT PRIMARY KEY,
    SubCategoryName VARCHAR(255) NOT NULL UNIQUE,
    CategoryId INT NOT NULL,
    FOREIGN KEY (CategoryId) REFERENCES Category(CategoryId) ON DELETE CASCADE
);

CREATE TABLE IngredientGroup (
    IngredientGroupId INT AUTO_INCREMENT PRIMARY KEY,
    IngredientGroupName VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE Ingredient (
    IngredientId INT AUTO_INCREMENT PRIMARY KEY,
    IngredientName VARCHAR(255) NOT NULL UNIQUE,
    IngredientGroupId INT NOT NULL,
    FOREIGN KEY (IngredientGroupId) REFERENCES IngredientGroup(IngredientGroupId) ON DELETE CASCADE
);

CREATE TABLE Recipes (
    RecipeId INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL UNIQUE,
    Description TEXT,
    CookingTime_min INT,
    IsVegetarian BOOLEAN,
    IsVegan BOOLEAN,
    DietTypeID INT,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CategoryId INT NOT NULL,
    FOREIGN KEY (DietTypeID) REFERENCES Diet_Types(DietTypeID) ON DELETE SET NULL,
    FOREIGN KEY (CategoryId) REFERENCES Category(CategoryId) ON DELETE CASCADE
);

CREATE TABLE Recipe_Category (
    RecipeId INT NOT NULL,
    CategoryId INT NOT NULL,
    FOREIGN KEY (RecipeId) REFERENCES Recipes(RecipeId) ON DELETE CASCADE,
    FOREIGN KEY (CategoryId) REFERENCES Category(CategoryId) ON DELETE CASCADE,
    UNIQUE (RecipeId, CategoryId)
);

CREATE TABLE Recipe_Ingredient (
    RecipeId INT NOT NULL,
    IngredientId INT NOT NULL,
    NeededAmount VARCHAR(100),
    FOREIGN KEY (RecipeId) REFERENCES Recipes(RecipeId) ON DELETE CASCADE,
    FOREIGN KEY (IngredientId) REFERENCES Ingredient(IngredientId) ON DELETE CASCADE,
    UNIQUE (RecipeId, IngredientId)
);

CREATE TABLE CookingStep (
    CookingStepId INT AUTO_INCREMENT PRIMARY KEY,
    CookingStepName VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE Recipe_CookingStep (
    RecipeId INT NOT NULL,
    CookingStepId INT NOT NULL,
    StepOrder INT NOT NULL,
    FOREIGN KEY (RecipeId) REFERENCES Recipes(RecipeId) ON DELETE CASCADE,
    FOREIGN KEY (CookingStepId) REFERENCES CookingStep(CookingStepId) ON DELETE CASCADE,
    UNIQUE (RecipeId, CookingStepId, StepOrder)
);

CREATE INDEX idx_recipe_category ON Recipe_Category(CategoryId);
CREATE INDEX idx_recipe_ingredient ON Recipe_Ingredient(IngredientId);
CREATE INDEX idx_recipe_step ON Recipe_CookingStep(CookingStepId);
