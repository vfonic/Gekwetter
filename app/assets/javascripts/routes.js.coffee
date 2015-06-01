gekwetter.config(['$routeProvider', '$locationProvider' , 
($routeProvider, $locationProvider) ->
  # $locationProvider.html5Mode true
  $routeProvider
    .when("/",
      controller: MicropostsController
      templateUrl: "index.html"
    ).otherwise redirectTo: "/"
])
