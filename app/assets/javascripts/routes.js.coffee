gekwetter.config(['$routeProvider', '$locationProvider' , 
($routeProvider, $locationProvider) ->
  $locationProvider.html5Mode true
  $routeProvider
    .when('/register',
      controller: UsersCtrl
      templateUrl: "registrations/new.html"
    ).when('/login',
      controller: UsersCtrl
      templateUrl: "sessions/new.html"
    ).when("/users",
      controller: UsersCtrl
      templateUrl: "Microposts/index.html"
    ).when("/:username/following",
      controller: MicropostsCtrl
      templateUrl: "Microposts/new.html"
    ).when("/:username/followers",
      controller: MicropostsCtrl
      templateUrl: "Microposts/show.html"
    ).when("/users",
      controller: MicropostsCtrl
      templateUrl: "index.html"
    ).when("/username",
      controller: MicropostsCtrl
      templateUrl: "index.html"
    ).otherwise redirectTo: "/users"
])
