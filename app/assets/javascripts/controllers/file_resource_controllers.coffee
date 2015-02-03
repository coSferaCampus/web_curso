fileResourceControllers = angular.module "fileResourceControllers", [
  "ui.router"
  "fileResourceServices"
]

fileResourceControllers.controller "FileResourceFormController", [
  "$rootScope"
  "$scope"
  "FileResource"
  ($rootScope, $scope, FileResource) ->
    FileResource.index(
      {}
      (response) ->
        $rootScope.fileResources = response.file_resources
      (response) ->
        console.log "Algo ha ido mal"
    )

    $scope.fileResource = {}
    $scope.reportErrors = {}

    $scope.addFileResource = ->
      FileResource.create(
        {
          file_resource: {name: $scope.fileResource.name, url: $scope.fileResource.url}
        }
        (response) ->
          $scope.fileResource = {}
          $scope.reportErrors = {}

          $rootScope.fileResources.push response.file_resource
        (response) ->
          $scope.reportErrors = response.errors
      )
]

fileResourceControllers.controller "FileResourceTableController", [
  "$rootScope"
  "$scope"
  "FileResource"
  ($rootScope, $scope, FileResource) ->
    $scope.removeFileResource = (fileResource) ->
      if confirm "¿Seguro que quieres eliminar el fichero #{fileResource.name}?"
        index = $rootScope.fileResources.indexOf fileResource
        FileResource.destroy(
          {id: fileResource.id}
          (response) ->
            $rootScope.fileResources.splice index, 1
          (response) ->
            console.log "Ha ocurrido un error"
        )
]
