# waferpie-sample

## App kitchen-coffee

### Ingredients

- `GET /ingredients` - Return all ingredients
- `GET /ingredients/:id` - Return an ingredient by id
- `POST /ingredients` - Create a new ingredient (the data must be sent in the payload)
- `PUT /ingredients/:id` - Update an ingredient by id (the data must be sent in the payload)
- `DELETE /ingredients/:id` - Remove an ingredient by id
- `DELETE /ingredients/all` -  Remove all ingredients

### Recipes

- `GET /recipes` - Return all ingredients
- `GET /recipes/:id` - Return an ingredient by id
- `POST /recipes` - Create a new ingredient (the data must be sent in the payload)
- `PUT /recipes/:id` - Update an ingredient by id (the data must be sent in the payload)
- `PUT /recipes/:id/:ingredientId` - Add an ingredient to the recipe (the quantity must be sent in the payload)
- `DELETE /recipes/:id` - Remove a recipe by id
- `DELETE /recipes/all` - Remove all recipes
