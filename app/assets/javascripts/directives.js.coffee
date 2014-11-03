'use strict';

# Directives

angular.module('mooffin.directives', [])
.directive 'ngConfirmClick', [() ->
    restrict: 'A'
    replace: false
    link: ($scope, $element, $attr) ->
      msg = $attr.ngConfirmClick || "Estás seguro?"
      clickAction = $attr.confirmedClickAction;
      $element.bind('click',(event) ->
        if window.confirm(msg)
          $scope.$eval(clickAction)
      )
]
