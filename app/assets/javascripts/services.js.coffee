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

  setRecipe: (recipe, links, steps) ->
    $http.post("/recipes", recipe, links, steps).then ->
      $window.location.href = '/'

  setOpinion: (recipe, opinion) ->
    $http.post("/recipes/#{ recipe.id }/opinions", opinion).then ->

  deleteOpinion: (opinion) ->
    $http.delete("/opinions/#{ opinion }").then ->


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
]
