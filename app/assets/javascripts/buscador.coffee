# Define a new module for our app. The array holds the names of dependencies if any.
app = angular.module("instantIngredientsSearch", [])

recipe = {}
links = {}
steps = {}
idsIngredients = []
paramIngredients = {}
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

  # Dependendo do tamanho da ventana, carga en modo lista ou grid
  if $(window).width() < 658
    $scope.layout = 'list'
  else
    $scope.layout = 'grid'


  $scope.ingredients = InstantIngredientsSearchFactory.getIngredients().then (ingredients) ->
    $scope.ingredients = ingredients

  $scope.setValue = (i) ->
    already_in_it = false
    if $scope.selected_ingredients.length > 0
      angular.forEach $scope.selected_ingredients, (ingr, index) ->
        already_in_it = true if ingr == i

    $scope.selected_ingredients.push i if already_in_it == false
    # Gardamos os id's dos ingredentes nun array para enviar ao servidor
    if already_in_it == false
      idsIngredients.push i.id
      paramIngredients = { 'idsIngredients' : idsIngredients }

    $scope.show_recipes = InstantIngredientsSearchFactory.getProposals(paramIngredients) if already_in_it == false

  $scope.removeIngredient = (index) ->
    $scope.selected_ingredients.splice index, 1
    #$scope.show_recipes = InstantIngredientsSearchFactory.getRecipesRecommended()
    $scope.show_recipes = [] if $scope.selected_ingredients.length == 0


# Controlador to select an ingredient for a new recipe
angular.module('instantIngredientsSearch').controller 'InstantIngredientSearchForNewRecipeController', ($scope, InstantIngredientsSearchFactory) ->

  $scope.selected_ingredient = ''
  newLink = {}
  newStep = {}
  $scope.links = []
  $scope.steps = []
  contador = 0
  edit = false
  editIndex = 0
  numSteps = 0;
  photo = null
  fr = new FileReader();


  $scope.ingredients = InstantIngredientsSearchFactory.getIngredients().then (ingredients) ->
    $scope.ingredients = ingredients

  $scope.units = InstantIngredientsSearchFactory.getUnits().then (units) ->
    $scope.units = units

  $scope.importances = InstantIngredientsSearchFactory.getImportances().then (importances) ->
    $scope.importances = importances

  $scope.difficulties = InstantIngredientsSearchFactory.getDifficulties().then (difficulties) ->
    $scope.difficulties = difficulties  

  $scope.setValue = (i) ->
    $scope.selected_ingredient = i
    $scope.searchString = i.name

  $scope.addLink = () ->
    newLink = {'number': $scope.numberOfIng, 'unit': $scope.selected_unit, 'ing': $scope.selected_ingredient, 
    'importance': $scope.importanceOfIng, 'ingredient_id': $scope.selected_ingredient.id, 
    'importance_id': $scope.importanceOfIng.id, 'unit_id': $scope.selected_unit.id}
    $scope.links.push newLink
    $scope.numberOfIng = ''
    $scope.selected_unit = ''
    $scope.searchString = ''
    $scope.importanceOfIng = ''
    newLink = {}

  $scope.addStep = () ->
    if !edit
      newStep = {'description': $scope.textStepRec, 'orden': ++numSteps}
      $scope.steps.push newStep       
    else
      newStep = {'description': $scope.textStepRec, 'orden': editIndex + 1}
      $scope.steps[editIndex] = newStep 
    
    $scope.textStepRec = ''
    editIndex = 0
    edit = false
    newStep = {}

  $scope.removeLink = (index) ->
    $scope.links.splice index, 1

  $scope.removeStep = (index) ->
    numSteps--

    angular.forEach $scope.steps, (step) ->
      step.orden-- if step.orden > index + 1

    $scope.steps.splice index, 1

  $scope.editStep = (index) ->
    $scope.textStepRec = $scope.steps[index].description
    $scope.ordenStep = index + 1
    edit = true
    editIndex = index

  $scope.createRecipe = () ->
    recipe = { 'recipe': { 'title': $scope.recipeTitle, 'time': $scope.recipeTime, 
    'servings': $scope.recipeServings, 'difficulty_id': $scope.recipeDifficulty.id,
    'photo': photo, 
    'steps_attributes': $scope.steps, 'links_attributes': $scope.links }}
    links = $scope.links
    steps = $scope.steps
    InstantIngredientsSearchFactory.setRecipe recipe, links, steps

  $scope.enterKeyStep = (ev) ->
    if(ev.which == 13)
      addStep()

  $scope.readFile = () ->
    photo = document.getElementById('photoUpload').files[0]
    fr.onloadend = (e) ->
      data = e.target.result
      #send you binary data via $http or $resource or do anything else with it
    
    fr.readAsArrayBuffer photo

# The factory
angular.module('instantIngredientsSearch').factory 'InstantIngredientsSearchFactory', ($http) ->
  
  getIngredients: ->
    #return the promise directly.
    $http.get("/ingredients.json").then (result) ->
      #resolve the promise as the data
      result.data

  getProposals: ->
    $http.get("/proposals.json", params: paramIngredients).then (result) ->
      result.data

  getUnits: ->
    #return the promise directly.
    $http.get("/units.json").then (result) ->
      #resolve the promise as the data
      result.data

  getImportances: ->
    #return the promise directly.
    $http.get("/importances.json").then (result) ->
      #resolve the promise as the data
      result.data    

  getDifficulties: ->
    #return the promise directly.
    $http.get("/difficulties.json").then (result) ->
      #resolve the promise as the data
      result.data

  setRecipe: ->
    $http.post("/recipes", recipe, links, steps).then ->
      true
