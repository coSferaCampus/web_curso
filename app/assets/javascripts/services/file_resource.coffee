fileResourceServices = angular.module 'fileResourceServices', ['ngResource']

fileResourceServices.factory 'FileResource', ['$resource', ($resource) ->
  $resource("/file_resources/:id", {id: "@_id", format: 'json'},
    {
      show:    {method: 'GET', isArray: false}
      index:   {method: 'GET', isArray: false}
      create:  {method: 'POST'}
      destroy: {method: 'DELETE'}
    }
  )
]
