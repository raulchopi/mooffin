'use strict'

#Controllers

angular.module('mooffin.controllers', [])
.controller 'InstantIngredientsSearchController', ['$scope',
'InstantIngredientsSearchFactory', ($scope, InstantIngredientsSearchFactory) ->

  recipe = {}
  links = {}
  steps = {}
  idsIngredients = []
  paramIngredients = {}

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
]


.controller 'UserRecipesController', ['$scope', '$timeout',
'InstantIngredientsSearchFactory', ($scope, $timeout, InstantIngredientsSearchFactory) ->

  # Dependendo do tamanho da ventana, carga en modo lista ou grid
  if $(window).width() < 658
    $scope.layout = 'list'
  else
    $scope.layout = 'grid'

  $scope.show_avatar = false

  $timeout (->
    $scope.show_avatar = true
    return
  ), 1
]


.controller 'RecipeOpinionsController', ['$scope',
'InstantIngredientsSearchFactory', ($scope, InstantIngredientsSearchFactory) ->
  $scope.recipeId = angular.element("#idRecipeHidden").val()
  recipeIdentifier = { 'recipeId' : $scope.recipeId }
  $scope.recipeOpinions = InstantIngredientsSearchFactory.getRecipeOpinions(recipeIdentifier)

  $scope.createOpinion = () ->
    opinion = { 'opinion': { 'opinion': $scope.op_opinion, 'rating': $scope.op_rating}}
    recipe = { 'id': $scope.recipeId }
    recipeIdentifier = { 'recipeId' : $scope.recipeId }
    InstantIngredientsSearchFactory.setOpinion recipe, opinion
    $scope.recipeOpinions = InstantIngredientsSearchFactory.getRecipeOpinions(recipeIdentifier)
]


.controller 'InstantIngredientSearchForNewRecipeController', ['$scope',
'InstantIngredientsSearchFactory', ($scope, InstantIngredientsSearchFactory) ->

  $scope.selected_ingredient = ''
  newLink = {}
  newStep = {}
  $scope.links = []
  $scope.steps = []
  contador = 0
  edit = false
  $scope.editIndex = -1
  numSteps = 0
  photo = null
  fr = new FileReader()
  linksH = []
  stepsH = []
  diffH = []

  $scope.ingredients = InstantIngredientsSearchFactory.getIngredients().then (ingredients) ->
    $scope.ingredients = ingredients

  $scope.units = InstantIngredientsSearchFactory.getUnits().then (units) ->
    $scope.units = units

  $scope.importances = InstantIngredientsSearchFactory.getImportances().then (importances) ->
    $scope.importances = importances

  $scope.difficulties = InstantIngredientsSearchFactory.getDifficulties().then (difficulties) ->
    $scope.difficulties = difficulties
    lateEdit()

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
      newStep = { 'id': $scope.idStep, 'description': $scope.textStepRec,
      'orden': $scope.editIndex + 1}
      $scope.steps[$scope.editIndex] = newStep

    $scope.textStepRec = ''
    $scope.editIndex = -1
    edit = false
    newStep = {}

  $scope.removeLink = (index) ->
    if($scope.links[index].id)
      $scope.links[index]._destroy = 1
    else
      $scope.links.splice index, 1

  $scope.removeStep = () ->
    edit = false
    numSteps--

    if($scope.steps[$scope.editIndex].id)
      $scope.steps[$scope.editIndex]._destroy = 1

    else
      $scope.steps.splice $scope.editIndex, 1

    angular.forEach $scope.steps, (step) ->
      step.orden-- if step.orden > $scope.editIndex + 1

    $scope.textStepRec = ''
    $scope.editIndex = -1

  $scope.editStep = (index) ->
    $scope.idStep = $scope.steps[index].id
    $scope.textStepRec = $scope.steps[index].description
    $scope.ordenStep = index + 1
    edit = true
    $scope.editIndex = index

  $scope.createRecipe = () ->
    recipe = { 'recipe': { 'title': $scope.recipeTitle, 'description': $scope.recipeDescription, 'time': $scope.recipeTime,
    'servings': $scope.recipeServings, 'difficulty_id': $scope.recipeDifficulty.id,
    'photo': photo, 'steps_attributes': $scope.steps, 'links_attributes': $scope.links }}
    links = $scope.links
    steps = $scope.steps
    InstantIngredientsSearchFactory.setRecipe recipe, links, steps



  $scope.updateRecipe = () ->
    recipe = { 'id': $scope.recipeId, 'recipe': { 'title': $scope.recipeTitle,
    'description': $scope.recipeDescription, 'time': $scope.recipeTime,
    'servings': $scope.recipeServings, 'difficulty_id': $scope.recipeDifficulty.id,
    'photo': photo,
    'steps_attributes': $scope.steps, 'links_attributes': $scope.links }}
    links = $scope.links
    steps = $scope.steps
    InstantIngredientsSearchFactory.updateRecipe recipe, links, steps

  $scope.enterKeyStep = (ev) ->
    if(ev.which == 13)
      addStep()

  $scope.readFile = () ->
    photoElement = angular.element('#photoUpload')[0].files[0]
    fr.onloadend = (e) ->
      photo = e.target.result

    fr.readAsDataURL photoElement

  $scope.editInit = () ->
    $scope.recipeId = angular.element("#idRecipeHidden").val()
    $scope.recipeTitle = angular.element("#recipe_title").val()
    $scope.recipeDescription = angular.element("#recipe_description").val()
    $scope.recipeTime = angular.element("#recipe_time").val()
    $scope.recipeServings = angular.element("#recipe_servings").val()
    linksH = JSON.parse(angular.element("#linksHidden").val())
    stepsH = JSON.parse(angular.element("#stepsHidden").val())
    diffH = JSON.parse(angular.element("#difficultyHidden").val())
    foto = angular.element("#recipe_photo").val()

  lateEdit = () ->
    addingEditLinks linksH
    addingEditSteps stepsH
    $scope.recipeDifficulty = $scope.difficulties[diffH.id - 1]

  addingEditLinks = (linkes) ->
    angular.forEach linkes, (link) ->
      newLink = {'id': link.id, 'number': link.number, 'unit': $scope.units[link.unit_id  - 1], 'ing': $scope.ingredients[link.ingredient_id - 1],
      'importance': $scope.importances[link.importance_id - 1], 'ingredient_id': link.ingredient_id,
      'importance_id': link.importance_id, 'unit_id': link.unit_id}
      $scope.links.push newLink
      newLink = {}

  addingEditSteps = (stepes) ->
    angular.forEach stepes, (step) ->
      newStep = { 'id': step.id, 'description': step.description, 'orden': step.orden }
      $scope.steps.push newStep
      newStep = {}
]
