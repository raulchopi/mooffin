'use strict'

# Services

angular.module('mooffin.services', [])
.factory 'InstantIngredientsSearchFactory', ['$http', '$window', ($http, $window) ->

  getIngredients: ->
    $http.get("/ingredients.json").then (result) ->
      result.data

  getProposals: (paramIngredients) ->
    $http.get("/proposals.json", params: paramIngredients).then (result) ->
      result.data

  getUnits: ->
    $http.get("/units.json").then (result) ->
      result.data

  getImportances: ->
    $http.get("/importances.json").then (result) ->
      result.data

  getDifficulties: ->
    $http.get("/difficulties.json").then (result) ->
      result.data

  getCourses: ->
    $http.get("/courses.json").then (result) ->
      result.data

  getReasons: ->
    $http.get("/reasons.json").then (result) ->
      result.data

  setRecipe: (recipe, links, steps, userId) ->
    $http.post("/recipes", recipe, links, steps).then ->
      $window.location.href = "/users/#{ userId }"

  setOpinion: (recipe, opinion) ->
    $http.post("/recipes/#{ recipe.id }/opinions", opinion).then ->

  deleteOpinion: (opinion) ->
    $http.delete("/opinions/#{ opinion }").then ->

  getUserRecipeLike: (recipeIdentifier) ->
    $http.get("/userRecipeLike.json", params: recipeIdentifier).then (result) ->
      result.data

  setLike: (recipe) ->
    $http.post("/recipes/#{ recipe.id }/likes").then ->

  deleteLike: (like) ->
    $http.delete("/likes/#{ like }").then ->

  getRecipeOpinions: (recipeIdentifier) ->
    $http.get("/recipeopinions.json", params: recipeIdentifier).then (result) ->
      result.data

  getUserRecipes: (userIdentifier) ->
    $http.get("/userrecipes.json", params: userIdentifier).then (result) ->
      result.data

  updateRecipe: (recipe, links, steps) ->
    $http.put("/recipes/#{ recipe.id }", recipe, links, steps).then ->
      $window.location.href = "/recipes/#{ recipe.id }"

  deleteRecipe: (recipe, user) ->
    $http.delete("/recipes/#{ recipe.id }").then ->
      $window.location.href = "/users/#{ user.id }"

  setReport: (recipe, report) ->
    $http.post("/recipes/#{ recipe.id }/reports", report).then ->
]
