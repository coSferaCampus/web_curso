userControllers = angular.module "userControllers", [
  "userServices"
]

userControllers.controller "UserFormController", [
  "$rootScope"
  "$scope"
  "User"
  ($rootScope, $scope, User) ->
    $scope.user = {email: ''}
    $scope.reportErrors = {}

    $scope.addUser = ->
      User.create(
        {
          user: $scope.user
        }
        (response) ->
          $rootScope.users.push response.user
          $scope.user = {email: ''}
          $scope.reportErrors = {}
        (response) ->
          $scope.reportErrors = response.data.errors
      )
]

userControllers.controller "UserTableController", [
  "$rootScope"
  "$scope"
  "User"
  ($rootScope, $scope, User) ->
    User.index {}, (data) ->
      $rootScope.users = data.users

    $scope.removeUser = (user) ->
      if confirm "¿Seguro que quieres eliminar el usuario #{user.email}?"
        index = $rootScope.users.indexOf user
        User.destroy(
          {id: user.id}
          (response) ->
            $rootScope.users.splice index, 1
          (response) ->
            console.log 'Ha ocurrido un error'
        )
]

userControllers.controller 'UserPasswordController', [
  "$scope"
  "Profile"
  ($scope, Profile) ->
    $scope.password_changed = gon.currentUser.password_changed

    if $scope.password_changed
      $scope.user = {current_password: '', password: '', password_confirmation: ''}
    else
      $scope.user = {password: '', password_confirmation: ''}

    $scope.reportErrors = {}

    $scope.updatePassword = ->
      Profile.update(
        {
          user: $scope.user
        }
        (response) ->
          $scope.password_changed = true
          gon.currentUser.password_changed = true
          $scope.user = {current_password: '', password: '', password_confirmation: ''}
          $scope.reportErrors = {}
        (response) ->
          $scope.reportErrors = response.data.errors
      )
]
