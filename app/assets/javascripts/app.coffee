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
    .state("root.addTheme",
      url: "subjects/:subject_id/themes/new",
      templateUrl: "add-theme.html"
    )
    .state("root.theme",
      url: "themes/:theme_id"
      templateUrl: "theme.html"
      controller: ($scope, $state, Theme) ->
        Theme.show {id: $state.params.theme_id, template: 'html'},
          (data) ->
            $scope.theme = data.theme

    )
]

App.directive 'subjectsList', ->
  {
    restrict: 'E'
    templateUrl: 'subjects-list.html'
    controller: ($rootScope, Subject) ->
      Subject.index {}, (data) ->
        $rootScope.subjects = data.subjects
  }

App.directive 'subjectForm', ->
  {
    restrict: 'E'
    templateUrl: 'subject-form.html'
    controller: ($rootScope, $scope, Subject) ->
      $scope.subject = {name: ''}
      $scope.reportErrors = {}

      $scope.addSubject = ->
        Subject.create(
          {
            subject: {name: $scope.subject.name}
          }
          (response) ->
            $rootScope.subjects.push response.subject
            $scope.subject = {name: ''}
            $scope.reportErrors = {}
          (response) ->
            $scope.reportErrors = response.data.errors
        )
  }

App.directive 'subjectsTable', ->
  {
    restrict: 'E'
    templateUrl: 'subjects-table.html'
    controller: ($rootScope, $scope, Subject) ->
      $scope.removeSubject = (subject) ->
        if confirm "¿Seguro que quieres eliminar la asignatura #{subject.name}?"
          index = $rootScope.subjects.indexOf subject
          Subject.destroy(
            {id: subject.id}
            (response) ->
              $rootScope.subjects.splice index, 1
            (response) ->
              console.log 'Ha ocurrido un error'
          )
  }

App.directive 'themeForm', ->
  {
    restrict: 'E'
    templateUrl: 'theme-form.html'
    controller: ($rootScope, $scope, $state, $filter, $upload, Subject, Theme) ->
      if $rootScope.subjects
        $rootScope.subject = $filter('byId')($rootScope.subjects, $state.params.subject_id)
      else
        Subject.get(
          {id: $state.params.subject_id}
          (response) ->
            $rootScope.subject = response.subject
          (response) ->
            console.log "Algo ha ido mal"
        )
      $scope.theme = {}
      $scope.reportErrors = {}

      $scope.addTheme = ->
        $upload.upload(
          url: '/themes.json'
          method: 'POST'
          data: {number: $scope.theme.number, subject_id: $state.params.subject_id}
          file: $scope.theme.file
          fileFormDataName: 'theme[file]'
          formDataAppender: (fd, key, val) ->
            if key isnt 'subject_id'
              fd.append "theme[#{key}]", val || ''
            else
              fd.append key, val
        )
        .success (data) ->
          theme = data.theme
          $rootScope.subject = $filter('byId')($rootScope.subjects, theme.subject_id)
          $scope.theme = {}
          $scope.reportErrors = {}

          $rootScope.subject.themes.push theme
        .error (data) ->
          $scope.reportErrors = data.errors
  }

App.directive 'themesTable', ->
  {
    restrict: 'E',
    templateUrl: 'themes-table.html'
  }

App.filter 'byId', ->
  return (input, id) ->
    for element in input
      return element if element.id is id
    return null
