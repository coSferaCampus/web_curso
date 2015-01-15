App = angular.module "App", [
  "ui.router"
  "templates"
  "ngSanitize"
  "angularFileUpload"
  "subjectControllers"
  "subjectServices"
  "themeControllers"
  "themeServices"
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
]

App.directive 'subjectsList', ->
  {
    restrict: 'E'
    templateUrl: 'subjects-list.html'
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
    restrict: 'E',
    templateUrl: 'themes-table.html'
    controller: 'ThemeTableController'
  }

App.filter 'byId', ->
  return (input, id) ->
    for element in input
      return element if element.id is id
    return null
