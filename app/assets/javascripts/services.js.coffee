'use strict';

# Services

angular.module('mooffin.services', [])
.factory 'InstantIngredientsSearchFactory', ($http, $window) ->

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

  updateRecipe: (recipe, links, steps) ->
    $http.patch("/recipes/:id", recipe, links, steps).then ->
      true