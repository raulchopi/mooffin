'use strict'


# Declare app level module which depends on filters, and services
app = angular.module('mooffin', [
  'ngSanitize',
  'ui.bootstrap',
  'mooffin.services',
  'mooffin.directives',
  'mooffin.controllers',
  'mooffin.filters',
  'ng-rails-csrf'
])
