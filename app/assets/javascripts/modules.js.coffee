# register all modules
angular.module 'mooffin.services', ['ngResource', 'rails', 'ng-rails-csrf']
angular.module('mooffin', ['mooffin.services'])