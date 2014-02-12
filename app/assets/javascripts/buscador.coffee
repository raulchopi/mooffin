# Define a new module for our app. The array holds the names of dependencies if any.
app = angular.module("instantIngredientsSearch", [])

# Create the instant search filter
app.filter "searchFor", ->
  
  # All filters must return a function. The first parameter
  # is the data that is to be filtered, and the second is an
  # argument that may be passed with a colon (searchFor:searchString)
  (arr, searchString) ->
    return arr unless searchString
    
    result = []
    searchString = searchString.toLowerCase()
    
    # Using the forEach helper method to loop through the array
    angular.forEach arr, (ingredient) ->
      result.push ingredient  if ingredient.name.toLowerCase().indexOf(searchString) isnt -1

    result


# The controller
angular.module('instantIngredientsSearch').controller 'InstantIngredientsSearchController', ($scope, InstantIngredientsSearchFactory) ->
  
  $scope.selected_ingredients = []
  $scope.show_recipes = []

  $scope.ingredients = InstantIngredientsSearchFactory.getIngredients().then (ingredients) ->
    $scope.ingredients = ingredients

  $scope.setValue = (i) ->
    already_in_it = false
    if $scope.selected_ingredients.length > 0
      angular.forEach $scope.selected_ingredients, (ingr, index) ->
        already_in_it = true if ingr == i

    $scope.selected_ingredients.push i if already_in_it == false
    $scope.show_recipes = InstantIngredientsSearchFactory.getRecipesRecommended() if already_in_it == false

  $scope.removeIngredient = (index) ->
    $scope.selected_ingredients.splice index, 1
    #$scope.show_recipes = InstantIngredientsSearchFactory.getRecipesRecommended()
    $scope.show_recipes = [] if $scope.selected_ingredients.length == 0


# Controlador to select an ingredient for a new recipe
angular.module('instantIngredientsSearch').controller 'InstantIngredientSearchForNewRecipeController', ($scope, InstantIngredientsSearchFactory) ->

  $scope.selected_ingredient = ''
  selected_unit = ''
  newLink = {}
  newStep = {}
  recipe = {}
  $scope.links = []
  $scope.steps = []
  contador = 0
  edit = false
  editIndex = 0


  $scope.ingredients = InstantIngredientsSearchFactory.getIngredients().then (ingredients) ->
    $scope.ingredients = ingredients

  $scope.units = InstantIngredientsSearchFactory.getUnits().then (units) ->
    $scope.units = units

  $scope.setValue = (i) ->
    $scope.selected_ingredient = i
    $scope.searchString = i.name

  $scope.prueba = (u) ->
    $scope.selected_unit = u

  $scope.addLink = () ->
    newLink = {'number': $scope.numberOfIng, 'unit': $scope.selected_unit, 'ing': $scope.selected_ingredient, 'importance': $scope.importanceOfIng}
    $scope.links.push newLink
    $scope.numberOfIng = ''
    $scope.selected_unit = ''
    $scope.searchString = ''
    $scope.importanceOfIng = ''
    newLink = {}

  $scope.addStep = () ->
    newStep = {'desc': $scope.textStepRec}
    
    if !edit
      $scope.steps.push newStep       
    else      
      $scope.steps[editIndex] = newStep 
    
    $scope.textStepRec = ''
    newStep = {}

  $scope.removeLink = (index) ->
    $scope.links.splice index, 1

  $scope.removeStep = (index) ->
    steps.splice index, 1

  $scope.editStep = (index) ->
    $scope.textStepRec = steps[index]
    edit = true
    editIndex = index

  $scope.createRecipe = () ->
    recipe = {'title': $scope.recipeTitle, 'time': $scope.recipeTime, 'servings': $scope.recipeServings, 'difficulty': $scope.recipeDifficulty, 'links': $scope.links, 'steps': $scope.steps}    
    recipe

# The factory
angular.module('instantIngredientsSearch').factory 'InstantIngredientsSearchFactory', ($http) ->
  
  getIngredients: ->
    #return the promise directly.
    $http.get("/ingredients.json").then (result) ->
      #resolve the promise as the data
      result.data

  getRecipesRecommended: ->
    $http.get("/recipes.json").then (result) ->
      result.data

  getUnits: ->
    #return the promise directly.
    $http.get("/units.json").then (result) ->
      #resolve the promise as the data
      result.data