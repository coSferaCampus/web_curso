App = angular.module "App", [
  "ui.router"
  "templates"
  "ngSanitize"
  "angularFileUpload"
  "subjectServices"
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
    .state("root.theme",
      url: "themes/:theme_id"
      templateUrl: "theme.html"
      controller: ($scope, $state, Theme) ->
        Theme.show {id: $state.params.theme_id},
          (data) ->
            $scope.theme = data.theme

    )
]

App.controller 'SubjectsController', [
  '$rootScope'
  '$scope'
  'Subject'
  ($rootScope, $scope, Subject) ->
    $scope.subject = {name: ''}
    $scope.reportErrors = {}

    Subject.index {}, (data) ->
      $rootScope.subjects = data.subjects

    $scope.addSubject = ->
      Subject.create(
        {
          subject: {name: $scope.subject.name}
        }
        (response) ->
          $rootScope.subjects.push response.subject
          $scope.reportErrors = {}
        (response) ->
          $scope.reportErrors = response.data.errors
      )
]

App.controller 'ThemesController', [
  '$rootScope'
  '$scope'
  '$state'
  '$filter'
  '$upload'
  'Theme'
  ($rootScope, $scope, $state, $filter, $upload, Theme) ->
    $scope.theme = {}
    $scope.reportErrors = {}

    $scope.addTheme = ->
      if $scope.theme.subject_id
        $upload.upload(
          url: '/themes.json'
          method: 'POST'
          data: {number: $scope.theme.number, subject_id: $scope.theme.subject_id}
          file: $scope.theme.file
          fileFormDataName: 'theme[file]'
          formDataAppender: (fd, key, val) ->
            if key isnt 'subject_id'
              fd.append "theme[#{key}]", val
            else
              fd.append key, val
        )
        .success (data) ->
          theme = data.theme
          subject = $filter('byId')($rootScope.subjects, theme.subject_id)
          $scope.reportErrors = {}

          subject.themes.push theme
        .error (data) ->
          $scope.reportErrors = data.errors
      else
        $scope.reportErrors.subject_id = 'es obligatoria'
]

App.directive 'subjectsList', ->
  {
    restrict: 'E'
    templateUrl: 'subjects-list.html'
    controller: 'SubjectsController'
  }

App.directive 'subjectForm', ->
  {
    restrict: 'E'
    templateUrl: 'subject-form.html'
    controller: 'SubjectsController'
  }

App.directive 'themeForm', ->
  {
    restrict: 'E'
    templateUrl: 'theme-form.html'
    controller: 'ThemesController'
  }

App.filter 'byId', ->
  return (input, id) ->
    for element in input
      return element if element.id is id
    return null
