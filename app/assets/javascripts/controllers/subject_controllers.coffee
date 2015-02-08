subjectControllers = angular.module "subjectControllers", [
  "ui.router"
  "subjectServices"
]

subjectControllers.controller "SubjectListController", [
  "$rootScope"
  "$scope"
  "$state"
  "Subject"
  ($rootScope, $scope, $state, Subject) ->
    Subject.index {}, (data) ->
      $rootScope.subjects = data.subjects

    $scope.editSubject = (subject, event) ->
      event.preventDefault()
      if $rootScope.user.admin
        $state.go("root.addTheme", {subject_id: subject.id})
]

subjectControllers.controller "SubjectFormController", [
  "$rootScope"
  "$scope"
  "Subject"
  ($rootScope, $scope, Subject) ->
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
]

subjectControllers.controller "SubjectTableController", [
  "$rootScope"
  "$scope"
  "Subject"
  ($rootScope, $scope, Subject) ->
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
]
