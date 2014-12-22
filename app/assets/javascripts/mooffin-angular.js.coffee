'use strict'


# Declare app level module which depends on filters, and services
app = angular.module('mooffin', [
  'ngSanitize',
  'ngAnimate',
  'ui.select',
  'mooffin.services',
  'mooffin.directives',
  'mooffin.controllers',
  'mooffin.filters'
])
