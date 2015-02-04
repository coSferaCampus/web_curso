globalInformationControllers = angular.module "globalInformationControllers", [
  "ui.router"
  "globalInformationServices"
]

globalInformationControllers.controller "GlobalInformationFormController", [
  "$rootScope"
  "$scope"
  "GlobalInformation"
  ($rootScope, $scope, GlobalInformation) ->
    GlobalInformation.index(
      {}
      (response) ->
        $rootScope.globalInformations = response.global_informations
      (response) ->
        console.log "Algo ha ido mal"
    )

    $scope.globalInformation = {}
    $scope.reportErrors = {}

    $scope.addGlobalInformation = ->
      GlobalInformation.create(
        {
          global_information: {name: $scope.globalInformation.name, value: $scope.globalInformation.value}
        }
        (response) ->
          $scope.globalInformation = {}
          $scope.reportErrors = {}

          $rootScope.globalInformations.push response.global_information
        (response) ->
          $scope.reportErrors = response.errors
      )
]

globalInformationControllers.controller "GlobalInformationTableController", [
  "$rootScope"
  "$scope"
  "GlobalInformation"
  ($rootScope, $scope, GlobalInformation) ->
    $scope.removeGlobalInformation = (globalInformation) ->
      if confirm "¿Seguro que quieres eliminar el fichero #{globalInformation.name}?"
        index = $rootScope.globalInformations.indexOf globalInformation
        GlobalInformation.destroy(
          {id: globalInformation.id}
          (response) ->
            $rootScope.globalInformations.splice index, 1
          (response) ->
            console.log "Ha ocurrido un error"
        )
]
