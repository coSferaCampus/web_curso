themeControllers = angular.module "themeControllers", [
  "ui.router"
  "themeServices"
]

themeControllers.controller "ThemeFormController", [
  "$rootScope"
  "$scope"
  "$state"
  "$filter"
  "$upload"
  "Subject"
  "Theme"
  ($rootScope, $scope, $state, $filter, $upload, Subject, Theme) ->
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
]

themeControllers.controller "ThemeShowController", [
  "$scope"
  "$state"
  "Theme"
  ($scope, $state, Theme) ->
    Theme.show {id: $state.params.theme_id, template: 'html'},
      (data) ->
        $scope.theme = data.theme
]

themeControllers.controller "ThemeTableController", [
  "$rootScope"
  "$scope"
  "$filter"
  "$state"
  "Subject"
  "Theme"
  ($rootScope, $scope, $filter, $state, Subject, Theme) ->
    $scope.removeTheme = (theme_id) ->
      subject = $filter('byId')($rootScope.subjects, $state.params.subject_id)
      theme = $filter('byId')(subject.themes, theme_id)
      if confirm "¿Seguro que quieres eliminar el tema #{theme.title}?"
        $rootScope.subject = subject # Just if user refresh
        index = subject.themes.indexOf theme
        Theme.destroy(
          {id: theme_id}
          (response) ->
            subject.themes.splice index, 1
          (response) ->
            console.log 'Ha ocurrido un error'
        )
]
