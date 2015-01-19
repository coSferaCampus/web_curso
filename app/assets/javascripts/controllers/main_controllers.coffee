mainControllers = angular.module 'mainControllers', []

mainControllers.controller 'MainMenuController', [
  '$rootScope'
  ($rootScope) ->
    $rootScope.user = gon.currentUser
]
