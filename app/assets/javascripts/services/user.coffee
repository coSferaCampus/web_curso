userServices = angular.module 'userServices', ['ngResource']

userServices.factory 'User', ['$resource', ($resource) ->
  $resource("/users/:id", {id: "@_id", format: 'json'},
    {
      index:   {method: 'GET', isArray: false}
      create:  {method: 'POST'}
      destroy: {method: 'DELETE'}
    }
  )
]

userServices.factory 'Profile', ['$resource', ($resource) ->
  $resource("/profile", {format: 'json'},
    {
      update:  {method: 'PUT'}
    }
  )
]
