themeServices = angular.module 'themeServices', ['ngResource']

themeServices.factory 'Theme', ['$resource', ($resource) ->
  $resource("/themes/:id", {id: "@_id", format: 'json'},
    {
      show:   {method: 'GET', isArray: false}
    }
  )
]
