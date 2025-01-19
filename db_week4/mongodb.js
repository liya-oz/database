import mongoose from 'mongoose';

mongoose.connect('mongodb://localhost:27017/recipeDB', {
  useNewUrlParser: true,
  useUnifiedTopology: true,
});

const db = mongoose.connection;

db.once('open', () => {
  console.log('Connected to MongoDB');
});

// Schema Definitions
const dietTypeSchema = new mongoose.Schema({
  name: String,
});

const categorySchema = new mongoose.Schema({
  categoryName: String,
});

const recipeSchema = new mongoose.Schema({
  name: String,
  description: String,
  cookingTimeMin: Number,
  isVegetarian: Boolean,
  isVegan: Boolean,
  dietTypeId: { type: mongoose.Schema.Types.ObjectId, ref: 'DietType' },
  categoryId: { type: mongoose.Schema.Types.ObjectId, ref: 'Category' },
  createdAt: { type: Date, default: Date.now },
  updatedAt: { type: Date, default: Date.now },
});

const ingredientGroupSchema = new mongoose.Schema({
  ingredientGroupName: String,
});

const ingredientSchema = new mongoose.Schema({
  ingredientName: String,
  ingredientGroupId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'IngredientGroup',
  },
});

const recipeIngredientSchema = new mongoose.Schema({
  recipeId: { type: mongoose.Schema.Types.ObjectId, ref: 'Recipe' },
  ingredientId: { type: mongoose.Schema.Types.ObjectId, ref: 'Ingredient' },
  neededAmount: String,
});

const subCategorySchema = new mongoose.Schema({
  subCategoryName: String,
  categoryId: { type: mongoose.Schema.Types.ObjectId, ref: 'Category' },
});

const recipeCategorySchema = new mongoose.Schema({
  recipeId: { type: mongoose.Schema.Types.ObjectId, ref: 'Recipe' },
  categoryId: { type: mongoose.Schema.Types.ObjectId, ref: 'Category' },
});

const cookingStepSchema = new mongoose.Schema({
  cookingStepName: String,
});

const recipeCookingStepSchema = new mongoose.Schema({
  recipeId: { type: mongoose.Schema.Types.ObjectId, ref: 'Recipe' },
  cookingStepId: { type: mongoose.Schema.Types.ObjectId, ref: 'CookingStep' },
  stepOrder: Number,
});

// Model Definitions
const DietType = mongoose.model('DietType', dietTypeSchema);
const Category = mongoose.model('Category', categorySchema);
const Recipe = mongoose.model('Recipe', recipeSchema);
const IngredientGroup = mongoose.model(
  'IngredientGroup',
  ingredientGroupSchema,
);
const Ingredient = mongoose.model('Ingredient', ingredientSchema);
const RecipeIngredient = mongoose.model(
  'RecipeIngredient',
  recipeIngredientSchema,
);
const SubCategory = mongoose.model('SubCategory', subCategorySchema);
const RecipeCategory = mongoose.model('RecipeCategory', recipeCategorySchema);
const CookingStep = mongoose.model('CookingStep', cookingStepSchema);
const RecipeCookingStep = mongoose.model(
  'RecipeCookingStep',
  recipeCookingStepSchema,
);

// Inserting Data
async function insertData() {
  const vegetarian = new DietType({ name: 'Vegetarian' });
  const vegan = new DietType({ name: 'Vegan' });
  const keto = new DietType({ name: 'Keto' });
  await vegetarian.save();
  await vegan.save();
  await keto.save();

  const bakery = new Category({ categoryName: 'Bakery' });
  const mainCourse = new Category({ categoryName: 'Main Course' });
  const beverages = new Category({ categoryName: 'Beverages' });
  await bakery.save();
  await mainCourse.save();
  await beverages.save();

  const vegetableSoup = new Recipe({
    name: 'Vegetable Soup',
    description: 'A healthy vegetarian soup.',
    cookingTimeMin: 30,
    isVegetarian: true,
    isVegan: true,
    dietTypeId: vegetarian._id,
    categoryId: mainCourse._id,
  });
  const ketoSalad = new Recipe({
    name: 'Keto Salad',
    description: 'A delicious keto-friendly salad.',
    cookingTimeMin: 15,
    isVegetarian: true,
    isVegan: false,
    dietTypeId: keto._id,
    categoryId: mainCourse._id,
  });
  const fruitJuice = new Recipe({
    name: 'Fruit Juice',
    description: 'Refreshing fruit juice.',
    cookingTimeMin: 10,
    isVegetarian: true,
    isVegan: true,
    dietTypeId: vegan._id,
    categoryId: beverages._id,
  });
  await vegetableSoup.save();
  await ketoSalad.save();
  await fruitJuice.save();

  const vegetables = new IngredientGroup({ ingredientGroupName: 'Vegetables' });
  const fruits = new IngredientGroup({ ingredientGroupName: 'Fruits' });
  const meats = new IngredientGroup({ ingredientGroupName: 'Meats' });
  await vegetables.save();
  await fruits.save();
  await meats.save();

  const carrot = new Ingredient({
    ingredientName: 'Carrot',
    ingredientGroupId: vegetables._id,
  });
  const tomato = new Ingredient({
    ingredientName: 'Tomato',
    ingredientGroupId: vegetables._id,
  });
  const lettuce = new Ingredient({
    ingredientName: 'Lettuce',
    ingredientGroupId: vegetables._id,
  });
  const apple = new Ingredient({
    ingredientName: 'Apple',
    ingredientGroupId: fruits._id,
  });
  const chicken = new Ingredient({
    ingredientName: 'Chicken',
    ingredientGroupId: meats._id,
  });
  await carrot.save();
  await tomato.save();
  await lettuce.save();
  await apple.save();
  await chicken.save();

  const recipeIngredient1 = new RecipeIngredient({
    recipeId: vegetableSoup._id,
    ingredientId: carrot._id,
    neededAmount: '2 Carrots',
  });
  const recipeIngredient2 = new RecipeIngredient({
    recipeId: vegetableSoup._id,
    ingredientId: tomato._id,
    neededAmount: '3 Tomatoes',
  });
  await recipeIngredient1.save();
  await recipeIngredient2.save();

  const bread = new SubCategory({
    subCategoryName: 'Bread',
    categoryId: bakery._id,
  });
  const cakes = new SubCategory({
    subCategoryName: 'Cakes',
    categoryId: bakery._id,
  });
  await bread.save();
  await cakes.save();

  const recipeCategory1 = new RecipeCategory({
    recipeId: vegetableSoup._id,
    categoryId: bakery._id,
  });
  const recipeCategory2 = new RecipeCategory({
    recipeId: ketoSalad._id,
    categoryId: mainCourse._id,
  });
  await recipeCategory1.save();
  await recipeCategory2.save();

  const chopVegetables = new CookingStep({
    cookingStepName: 'Chop the vegetables',
  });
  const boilWater = new CookingStep({ cookingStepName: 'Boil the water' });
  await chopVegetables.save();
  await boilWater.save();

  const recipeCookingStep1 = new RecipeCookingStep({
    recipeId: vegetableSoup._id,
    cookingStepId: chopVegetables._id,
    stepOrder: 1,
  });
  await recipeCookingStep1.save();
}

insertData().then(() => {
  console.log('Data inserted successfully');
  mongoose.connection.close();
});
