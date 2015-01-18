subjectServices = angular.module 'subjectServices', ['ngResource']

subjectServices.factory 'Subject', ['$resource', ($resource) ->
  $resource("/subjects/:id", {id: "@_id", format: 'json'},
    {
      index:   {method: 'GET', isArray: false}
      create:  {method: 'POST'}
      destroy: {method: 'DELETE'}
    }
  )
]
