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

    if $scope.selected_ingredients.length > 0
      angular.element("#home").fadeOut 100
      angular.element("#recipes").fadeIn 100


    # Gardamos os id's dos ingredentes nun array para enviar ao servidor
    if already_in_it == false
      idsIngredients.push i.id
      paramIngredients = { 'idsIngredients' : idsIngredients }

    $scope.show_recipes = InstantIngredientsSearchFactory.getProposals(paramIngredients) if already_in_it == false

  $scope.removeIngredient = (index) ->
    $scope.selected_ingredients.splice index, 1
    paramIngredients.idsIngredients.splice index, 1
    #$scope.show_recipes = InstantIngredientsSearchFactory.getRecipesRecommended()
    if $scope.selected_ingredients.length == 0
      $scope.show_recipes = []
      angular.element("#home").fadeIn 100
      angular.element("#recipes").fadeOut 100
    else
      $scope.show_recipes = InstantIngredientsSearchFactory.getProposals(paramIngredients)
]


.controller 'UserRecipesController', ['$scope', '$timeout',
'InstantIngredientsSearchFactory', ($scope, $timeout, InstantIngredientsSearchFactory) ->
  $scope.userId = angular.element("#idUserHidden").val()
  userIdentifier = { 'id' : $scope.userId }
  $scope.userRecipes = InstantIngredientsSearchFactory.getUserRecipes(userIdentifier)

  $scope.deleteRecipe = (recipeId) ->
    recipe = {'id': recipeId}
    InstantIngredientsSearchFactory.deleteRecipe recipe, userIdentifier

  $scope.isAuthor = (userId, currentUserId) ->
    angular.equals(userId, parseInt(currentUserId))

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


.controller 'RecipeLikesController', ['$scope',
'InstantIngredientsSearchFactory', ($scope, InstantIngredientsSearchFactory) ->
  $scope.recipeId = angular.element("#idRecipeHidden").val()
  recipe = { 'id': $scope.recipeId }
  recipeIdentifier = { 'recipeId' : $scope.recipeId }
  $scope.likeRecipe = InstantIngredientsSearchFactory.getUserRecipeLike(recipeIdentifier).then (likeRecipe) ->
    $scope.likeRecipe = likeRecipe

  $scope.createLike = () ->
    InstantIngredientsSearchFactory.setLike recipe
    angular.element(".megusta").hide 1
    angular.element(".nomegusta").fadeIn 500
    $scope.likeRecipe = InstantIngredientsSearchFactory.getUserRecipeLike(recipeIdentifier)

  $scope.removeLike = () ->
    InstantIngredientsSearchFactory.deleteLike $scope.likeRecipe.$$v.id
    angular.element(".nomegusta").hide 1
    angular.element(".megusta").fadeIn 500
]


.controller 'RecipeOpinionsController', ['$scope',
'InstantIngredientsSearchFactory', ($scope, InstantIngredientsSearchFactory) ->
  $scope.recipeId = angular.element("#idRecipeHidden").val()
  recipeIdentifier = { 'recipeId' : $scope.recipeId }
  $scope.recipeOpinions = InstantIngredientsSearchFactory.getRecipeOpinions(recipeIdentifier)

  $scope.array = [{ "value": 1, "text": "1" }, { "value": 2, "text": "2" }, { "value": 3, "text": "3" },
    { "value": 4, "text": "4" }, { "value": 5, "text": "5" }, { "value": 6, "text": "6" }, { "value": 7, "text": "7" },
    { "value": 8, "text": "8" }, { "value": 9, "text": "9" }, { "value": 10, "text": "10" }];

  $scope.createOpinion = () ->
    opinion = { 'opinion': { 'opinion': $scope.op_opinion, 'rating': $scope.op_rating}}
    recipe = { 'id': $scope.recipeId }
    recipeIdentifier = { 'recipeId' : $scope.recipeId }
    InstantIngredientsSearchFactory.setOpinion recipe, opinion
    $scope.recipeOpinions = InstantIngredientsSearchFactory.getRecipeOpinions(recipeIdentifier)
    angular.element("#nuevaOpinion").fadeOut 250

  $scope.removeOpinion = (index, idOpinion) ->
    $scope.recipeOpinions.$$v[index]._deleted = 1
    InstantIngredientsSearchFactory.deleteOpinion idOpinion
    angular.element("#nuevaOpinion").fadeIn 250

  $scope.isAuthor = (userId, currentUserId) ->
    angular.equals(userId, parseInt(currentUserId))

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
    importance = null
    unit = null

    if $scope.importanceOfIng == undefined
      importance = 2
    else
      importance = $scope.importanceOfIng.id

    unit = $scope.selected_unit.id if $scope.selected_unit != undefined

    newLink = {'number': $scope.numberOfIng, 'unit': $scope.selected_unit, 'ing': $scope.selected_ingredient,
    'importance': $scope.importanceOfIng, 'ingredient_id': $scope.selected_ingredient.id,
    'importance_id': importance, 'unit_id': unit}

    if $scope.selected_ingredient != ''
      $scope.links.push newLink
      $scope.numberOfIng = ''
      $scope.selected_unit = ''
      $scope.searchString = ''
      $scope.importanceOfIng = ''
      $scope.selected_ingredient = null
      newLink = {}
      angular.element(".desc").fadeOut 500


  $scope.removeLink = (index) ->
    if($scope.links[index].id)
      $scope.links[index]._destroy = 1
    else
      $scope.links.splice index, 1

    if($scope.links.length == 0)
      angular.element(".desc").fadeIn 500


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
    angular.element(".btn_crearReceta")[0].textContent = "Guardando receta..."
    angular.element(".btn_crearReceta")[0].disabled = true
    recipe = { 'recipe': { 'title': $scope.recipeTitle, 'description': $scope.recipeDescription, 'time': $scope.recipeTime,
    'servings': $scope.recipeServings, 'difficulty_id': $scope.recipeDifficulty.id,
    'photo': photo, 'steps_attributes': $scope.steps, 'links_attributes': $scope.links }}
    links = $scope.links
    steps = $scope.steps
    InstantIngredientsSearchFactory.setRecipe recipe, links, steps


  $scope.updateRecipe = () ->
    angular.element(".btn_crearReceta")[0].textContent = "Editando receta..."
    angular.element(".btn_crearReceta")[0].disabled = true

    if photo == null #If the user did not change the photo, do not save it
      recipe = { 'id': $scope.recipeId, 'recipe': { 'title': $scope.recipeTitle,
      'description': $scope.recipeDescription, 'time': $scope.recipeTime,
      'servings': $scope.recipeServings, 'difficulty_id': $scope.recipeDifficulty.id,
      'steps_attributes': $scope.steps, 'links_attributes': $scope.links }}
    else
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
      numSteps = $scope.steps.length
]
