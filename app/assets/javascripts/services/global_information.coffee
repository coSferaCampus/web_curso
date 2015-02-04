globalInformationServices = angular.module 'globalInformationServices', ['ngResource']

globalInformationServices.factory 'GlobalInformation', ['$resource', ($resource) ->
  $resource("/global_informations/:id", {id: "@_id", format: 'json'},
    {
      show:    {method: 'GET', isArray: false}
      index:   {method: 'GET', isArray: false}
      create:  {method: 'POST'}
      update:  {method: 'PUT'}
      destroy: {method: 'DELETE'}
    }
  )
]
