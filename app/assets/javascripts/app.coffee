App = angular.module "App", [
  "ui.router"
  "templates"
  "ngSanitize"
  "angularFileUpload"
  "mainControllers"
  "subjectControllers"
  "themeControllers"
  "userControllers"
  "fileResourceControllers"
  "globalInformationControllers"
]

App.config [
  "$stateProvider"
  "$urlRouterProvider"
  "$httpProvider"
  ($stateProvider, $urlRouterProvider, $httpProvider) ->
    $httpProvider.defaults.headers.common['X-CSRF-Token'] =
      $('meta[name="csrf-token"]').attr('content')
    $urlRouterProvider.otherwise "/"
    $stateProvider.state("root",
      url: "/"
      templateUrl: "main.html"
      controller: 'MainMenuController'
    )
    .state("root.addSubject",
      url: "subjects/new"
      templateUrl: "add-subject.html"
    )
    .state("root.addTheme",
      url: "subjects/:subject_id/themes/new",
      templateUrl: "add-theme.html"
    )
    .state("root.theme",
      url: "themes/:theme_id"
      templateUrl: "theme.html"
      controller: "ThemeShowController"
    )
    .state("root.addUser",
      url: "users/new",
      templateUrl: "add-user.html"
    )
    .state("root.profile",
      url: "profile",
      templateUrl: "profile.html"
    )
    .state("root.addFile",
      url: "files",
      templateUrl: "add-file.html"
    )
    .state("root.addGlobalInformation",
      url: "global_informations",
      templateUrl: "add-global-information.html"
    )

]

App.directive 'subjectsList', ->
  {
    restrict: 'E'
    templateUrl: 'subjects-list.html'
    controller: 'SubjectListController'
  }

App.directive 'subjectsListResponsive', ->
  {
    restrict: 'E'
    templateUrl: 'subjects-list-responsive.html'
    controller: 'SubjectListController'
  }

App.directive 'subjectForm', ->
  {
    restrict: 'E'
    templateUrl: 'subject-form.html'
    controller: 'SubjectFormController'
  }

App.directive 'subjectsTable', ->
  {
    restrict: 'E'
    templateUrl: 'subjects-table.html'
    controller: 'SubjectTableController'
  }

App.directive 'themeForm', ->
  {
    restrict: 'E'
    templateUrl: 'theme-form.html'
    controller: 'ThemeFormController'
  }

App.directive 'themesTable', ->
  {
    restrict: 'E'
    templateUrl: 'themes-table.html'
    controller: 'ThemeTableController'
  }

App.directive 'userForm', ->
  {
    restrict: 'E'
    templateUrl: 'user-form.html'
    controller: 'UserFormController'
  }

App.directive 'usersTable', ->
  {
    restrict: 'E'
    templateUrl: 'users-table.html'
    controller: 'UserTableController'
  }

App.directive 'passwordForm', ->
  {
    restrict: 'E'
    templateUrl: 'password-form.html'
    controller: 'UserPasswordController'
  }

App.directive 'fileForm', ->
  {
    restrict: 'E'
    templateUrl: 'file-form.html'
    controller: 'FileResourceFormController'
  }

App.directive 'filesTable', ->
  {
    restrict: 'E'
    templateUrl: 'files-table.html'
    controller: 'FileResourceTableController'
  }

App.directive 'globalInformationForm', ->
  {
    restrict: 'E'
    templateUrl: 'global-information-form.html'
    controller: 'GlobalInformationFormController'
  }

App.directive 'globalInformationsTable', ->
  {
    restrict: 'E'
    templateUrl: 'global-informations-table.html'
    controller: 'GlobalInformationTableController'
  }

App.filter 'byId', ->
  return (input, id) ->
    for element in input
      return element if element.id is id
    return null
