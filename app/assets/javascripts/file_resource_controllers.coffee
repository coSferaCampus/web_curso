fileResourceControllers = angular.module "fileResourceControllers", [
  "ui.router"
  "fileResourceServices"
]

fileResourceControllers.controller "FileResourceFormController", [
  "$rootScope"
  "$scope"
  "$upload"
  "FileResource"
  ($rootScope, $scope, $upload, FileResource) ->
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
      $upload.upload(
        url: '/file_resources.json'
        method: 'POST'
        data: {name: $scope.fileResource.name}
        file: $scope.fileResource.file
        fileFormDataName: 'file_resource[file]'
        formDataAppender: (fd, key, val) ->
          fd.append "file_resource[#{key}]", val || ''
      )
      .success (data) ->
        $scope.fileResource = {}
        $scope.reportErrors = {}

        $rootScope.fileResources.push data.file_resource
      .error (data) ->
        $scope.reportErrors = data.errors
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
