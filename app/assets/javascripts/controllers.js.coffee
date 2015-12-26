'use strict'

#Controllers

angular.module('mooffin.controllers', [])
.controller 'InstantIngredientsSearchController', ['$scope',
'InstantIngredientsSearchFactory', ($scope, InstantIngredientsSearchFactory) ->

  idsIngredients = []

  $scope.ingredients = []
  $scope.show_recipes = []

  # Dependendo do tamanho da ventana, carga en modo lista ou grid
  if $(window).width() < 658
    $scope.layout = 'list'
  else
    $scope.layout = 'grid'


  InstantIngredientsSearchFactory.getIngredients().then (ingredients) ->
    $scope.ingredients = ingredients

  $scope.ingredientsChange = ->
    idsIngredients = []
    angular.forEach $scope.ingredients.selected, (ingr, index) ->
      idsIngredients.push ingr.id

    if idsIngredients.length > 0
      angular.element("#home").fadeOut 100
      angular.element("#recipes").fadeIn 100
    else
      angular.element("#home").fadeIn 100
      angular.element("#recipes").fadeOut 100

    if idsIngredients.length > 0
      getProposals()
    else
      $scope.show_recipes = []


  getProposals = ->
    $scope.show_recipes = InstantIngredientsSearchFactory.getProposals(idsIngredients).then (prop) ->
      $scope.show_recipes = prop
]


.controller 'LastRecipesController', ['$scope',
'InstantIngredientsSearchFactory', ($scope, InstantIngredientsSearchFactory) ->

  $scope.lastRecipes = InstantIngredientsSearchFactory.getLastRecipes().then (last) ->
    $scope.lastRecipes = last
]

.controller 'AllCategoriesController', ['$scope',
'InstantIngredientsSearchFactory', ($scope, InstantIngredientsSearchFactory) ->

  $scope.categories = InstantIngredientsSearchFactory.getCategories().then (categories) ->
    $scope.categories = categories
]

.controller 'CategoryRecipesController', ['$scope',
'InstantIngredientsSearchFactory', ($scope, InstantIngredientsSearchFactory) ->

  # Dependendo do tamanho da ventana, carga en modo lista ou grid
  if $(window).width() < 658
    $scope.layout = 'list'
  else
    $scope.layout = 'grid'

  $scope.categoryId = angular.element("#idCatHidden").val()
  categoryIdentifier = { 'id' : $scope.categoryId }
  $scope.categoryRecipes = InstantIngredientsSearchFactory.getCategoryRecipes(categoryIdentifier).then (categoryRecipes) ->
    $scope.categoryRecipes = categoryRecipes
]

.controller 'UserRecipesController', ['$scope', '$timeout',
'InstantIngredientsSearchFactory', ($scope, $timeout, InstantIngredientsSearchFactory) ->
  $scope.userId = angular.element("#idUserHidden").val()
  userIdentifier = { 'id' : $scope.userId }
  $scope.userRecipes = InstantIngredientsSearchFactory.getUserRecipes(userIdentifier).then (likeRecipes) ->
    $scope.userRecipes = likeRecipes

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
    $scope.likeRecipe = InstantIngredientsSearchFactory.getUserRecipeLike(recipeIdentifier).then (likeRecipe) ->
      $scope.likeRecipe = likeRecipe

  $scope.removeLike = () ->
    InstantIngredientsSearchFactory.deleteLike $scope.likeRecipe.id
    angular.element(".nomegusta").hide 1
    angular.element(".megusta").fadeIn 500
]


.controller 'RecipeOpinionsController', ['$scope',
'InstantIngredientsSearchFactory', ($scope, InstantIngredientsSearchFactory) ->
  $scope.recipeId = angular.element("#idRecipeHidden").val()
  recipeIdentifier = { 'recipeId' : $scope.recipeId }
  $scope.recipeOpinions = InstantIngredientsSearchFactory.getRecipeOpinions(recipeIdentifier).then (recipeOpinions) ->
    $scope.recipeOpinions = recipeOpinions

  $scope.array = [{ "value": 1, "text": "1" }, { "value": 2, "text": "2" }, { "value": 3, "text": "3" },
    { "value": 4, "text": "4" }, { "value": 5, "text": "5" }, { "value": 6, "text": "6" }, { "value": 7, "text": "7" },
    { "value": 8, "text": "8" }, { "value": 9, "text": "9" }, { "value": 10, "text": "10" }];

  $scope.createOpinion = () ->
    opinion = { 'opinion': { 'opinion': $scope.op_opinion, 'rating': $scope.op_rating}}
    recipe = { 'id': $scope.recipeId }
    recipeIdentifier = { 'recipeId' : $scope.recipeId }
    InstantIngredientsSearchFactory.setOpinion recipe, opinion
    $scope.recipeOpinions = InstantIngredientsSearchFactory.getRecipeOpinions(recipeIdentifier).then (recipeOpinions) ->
      $scope.recipeOpinions = recipeOpinions
    angular.element("#nuevaOpinion").fadeOut 250

  $scope.removeOpinion = (index, idOpinion) ->
    $scope.recipeOpinions[index]._deleted = 1
    InstantIngredientsSearchFactory.deleteOpinion idOpinion
    angular.element("#nuevaOpinion").fadeIn 250

  $scope.isAuthor = (userId, currentUserId) ->
    angular.equals(userId, parseInt(currentUserId))

]


.controller 'RecipeReportsController', ['$scope',
'InstantIngredientsSearchFactory', ($scope, InstantIngredientsSearchFactory) ->
  $scope.recipeId = angular.element("#idRecipeHidden").val()
  $scope.formData = {}

  $scope.reasonsAll = InstantIngredientsSearchFactory.getReasons().then (reasons) ->
    $scope.reasonsAll = reasons

  $scope.createReport = () ->
    recipe = { 'id': $scope.recipeId }
    report = {'report': {'reason_id': $scope.formData.reason_id, 'description': $scope.report_desc}}
    InstantIngredientsSearchFactory.setReport recipe, report

    angular.element("#reportModal").foundation('reveal', 'close')
]


.controller 'InstantIngredientSearchForNewRecipeController', ['$scope',
'InstantIngredientsSearchFactory', ($scope, InstantIngredientsSearchFactory) ->

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
  courseH = []
  $scope.alerts = []

  $scope.ingredients = InstantIngredientsSearchFactory.getIngredients().then (ingredients) ->
    $scope.ingredients = ingredients

  $scope.importances = InstantIngredientsSearchFactory.getImportances().then (importances) ->
    $scope.importances = importances

  $scope.courses = InstantIngredientsSearchFactory.getCourses().then (courses) ->
    $scope.courses = courses

  $scope.categories = InstantIngredientsSearchFactory.getCategories().then (categories) ->
    $scope.categories = categories

  $scope.difficulties = InstantIngredientsSearchFactory.getDifficulties().then (difficulties) ->
    $scope.difficulties = difficulties
    lateEdit()


  $scope.addLink = () ->
    importance = null

    if $scope.importanceOfIng == undefined
      importance = 2
    else
      importance = $scope.importanceOfIng.id

    newLink = {'text_link': $scope.text_link, 'ing': $scope.ingredients.selected,
    'importance': $scope.importanceOfIng, 'ingredient_id': $scope.ingredients.selected.id,
    'importance_id': importance}

    if $scope.ingredients.selected.id != ''
      $scope.links.push newLink
      $scope.text_link = ''
      $scope.searchString = ''
      $scope.importanceOfIng = ''
      $scope.ingredients.selected = null
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
    userId = angular.element("#idUserHidden").val()
    angular.element(".btn_crearReceta")[0].textContent = "Guardando receta..."
    angular.element(".btn_crearReceta")[0].disabled = true
    recipe = { 'recipe': { 'title': $scope.recipeTitle, 'description': $scope.recipeDescription, 'time': $scope.recipeTime,
    'source': $scope.recipeSource, 'url_source': $scope.recipeUrlSource,
    'servings': $scope.recipeServings, 'difficulty_id': $scope.recipeDifficulty.id, 'course_id': $scope.recipeCourse.id,
    'photo': photo, 'steps_attributes': $scope.steps, 'links_attributes': $scope.links}}
    # ,
    # 'recipecats_attributes': $scope.recipeCategories }}
    links = $scope.links
    steps = $scope.steps
    # recipecats = $scope.recipeCategories
    InstantIngredientsSearchFactory.setRecipe(recipe, links, steps, userId).then (response) ->
      if(response)
        $scope.alerts.push
          type: "success"
          msg: "Receta guardada"
      else
        $scope.alerts.push
          type: "danger"
          msg: "Error al guardar receta"
        angular.element(".btn_crearReceta")[0].textContent = "Guardar"
        angular.element(".btn_crearReceta")[0].disabled = false

  $scope.updateRecipe = () ->
    angular.element(".btn_crearReceta")[0].textContent = "Editando receta..."
    angular.element(".btn_crearReceta")[0].disabled = true

    if photo == null #If the user did not change the photo, do not save it
      recipe = { 'id': $scope.recipeId, 'recipe': { 'title': $scope.recipeTitle,
      'description': $scope.recipeDescription, 'time': $scope.recipeTime,
      'source': $scope.recipeSource, 'url_source': $scope.recipeUrlSource,
      'servings': $scope.recipeServings, 'difficulty_id': $scope.recipeDifficulty.id,
      'course_id': $scope.recipeCourse.id,
      'steps_attributes': $scope.steps, 'links_attributes': $scope.links}}
      # ,
      # 'recipecats_attributes': $scope.recipeCategories }}
    else
      recipe = { 'id': $scope.recipeId, 'recipe': { 'title': $scope.recipeTitle,
      'description': $scope.recipeDescription, 'time': $scope.recipeTime,
      'source': $scope.recipeSource, 'url_source': $scope.recipeUrlSource,
      'servings': $scope.recipeServings, 'difficulty_id': $scope.recipeDifficulty.id,
      'photo': photo, 'course_id': $scope.recipeCourse.id,
      'steps_attributes': $scope.steps, 'links_attributes': $scope.links}}
      # ,
      # 'recipecats_attributes': $scope.recipeCategories }}

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
    $scope.recipeSource = angular.element("#recipe_source").val()
    $scope.recipeUrlSource = angular.element("#recipe_url_source").val()
    $scope.recipeTime = angular.element("#recipe_time").val()
    $scope.recipeServings = angular.element("#recipe_servings").val()
    linksH = JSON.parse(angular.element("#linksHidden").val())
    stepsH = JSON.parse(angular.element("#stepsHidden").val())
    diffH = JSON.parse(angular.element("#difficultyHidden").val())
    courseH = JSON.parse(angular.element("#courseHidden").val())


  lateEdit = () ->
    addingEditLinks linksH
    addingEditSteps stepsH
    $scope.recipeDifficulty = $scope.difficulties[diffH.id - 1]
    $scope.recipeCourse = $scope.courses[courseH.id - 1]


  addingEditLinks = (linkes) ->
    angular.forEach linkes, (link) ->
      newLink = {'id': link.id, 'text_link': link.text_link, 'ing': $scope.ingredients[link.ingredient_id - 1],
      'importance': $scope.importances[link.importance_id - 1], 'ingredient_id': link.ingredient_id,
      'importance_id': link.importance_id}
      $scope.links.push newLink
      newLink = {}


  addingEditSteps = (stepes) ->
    angular.forEach stepes, (step) ->
      newStep = { 'id': step.id, 'description': step.description, 'orden': step.orden }
      $scope.steps.push newStep
      newStep = {}
      numSteps = $scope.steps.length

  $scope.addAlert = (alert) ->
    $scope.alerts.push alert

  $scope.closeAlert = (index) ->
    $scope.alerts.splice index, 1

  $scope.$watch 'alerts', ((n = [], old = []) ->
    if $scope.delay and old.length < n.length
      item = $scope.alerts[$scope.alerts.length - 1]
      timeout = setTimeout((->
        $scope.alerts = $scope.alerts.filter((alert) ->
          alert != item
        )
        $scope.$apply()
        return
      ), $scope.delay)
    return
  ), true
]
