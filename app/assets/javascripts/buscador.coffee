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
  
  $scope.ingredients = InstantIngredientsSearchFactory.getIngredients().then((ingredients) ->
    $scope.ingredients = ingredients
  )


# The factory
angular.module('instantIngredientsSearch').factory 'InstantIngredientsSearchFactory', ($http) ->
  
  getIngredients: ->
    
    #return the promise directly.
    $http.get("/ingredients.json").then (result) ->
      
      #resolve the promise as the data
      result.data