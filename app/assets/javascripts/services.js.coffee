'use strict'

# Services

angular.module('mooffin.services', [])
.factory 'InstantIngredientsSearchFactory', ['$http', '$window', ($http, $window) ->

  getIngredients: ->
    $http.get("/ingredients.json").then (result) ->
      result.data

  getProposals: (idsIngredients) ->
    $http.get("/proposals.json", params: { "idsIngredients[]": idsIngredients }).then (result) ->
      result.data

  getLastRecipes: ->
      $http.get("/lastRecipes.json").then (result) ->
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

  getCategories: ->
    $http.get("/recetas.json").then (result) ->
      result.data

  getReasons: ->
    $http.get("/reasons.json").then (result) ->
      result.data

  setRecipe: (recipe, links, steps, userId) ->
    $http.post("/receta", recipe, links, steps).then ->
      $window.location.href = "/usuarios/#{ userId }"

  setOpinion: (recipe, opinion) ->
    $http.post("/receta/#{ recipe.id }/opinions", opinion).then ->

  deleteOpinion: (opinion) ->
    $http.delete("/opinions/#{ opinion }").then ->

  getUserRecipeLike: (recipeIdentifier) ->
    $http.get("/userRecipeLike.json", params: recipeIdentifier).then (result) ->
      result.data

  setLike: (recipe) ->
    $http.post("/receta/#{ recipe.id }/favoritas").then ->

  deleteLike: (like) ->
    $http.delete("/favoritas/#{ like }").then ->

  getRecipeOpinions: (recipeIdentifier) ->
    $http.get("/recipeopinions.json", params: recipeIdentifier).then (result) ->
      result.data

  getUserRecipes: (userIdentifier) ->
    $http.get("/userrecipes.json", params: userIdentifier).then (result) ->
      result.data

  getCategoryRecipes: (categoryIdentifier) ->
    $http.get("/categoryrecipes.json", params: categoryIdentifier).then (result) ->
      result.data

  updateRecipe: (recipe, links, steps) ->
    $http.put("/receta/#{ recipe.id }", recipe, links, steps).then ->
      $window.location.href = "/receta/#{ recipe.id }"

  deleteRecipe: (recipe, user) ->
    $http.delete("/receta/#{ recipe.id }").then ->
      $window.location.href = "/usuarios/#{ user.id }"

  setReport: (recipe, report) ->
    $http.post("/receta/#{ recipe.id }/reports", report).then ->
]
