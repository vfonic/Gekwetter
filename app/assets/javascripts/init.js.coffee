root = global ? window
# angular = root.angular
gekwetter = angular.module('gekwetter', ['templates', 'ngRoute', 'ngResource', 'microposts'])

# gekwetter.run(($rootScope, $location) ->
#   $rootScope.$on('$routeChangeStart', (event, next, current) ->
#     if (!$rootScope.authorized() && $location.path() != '/login' && $location.path() != '/register')
#       $location.path('/register')
#       # FlashService.error("You need to register or login before continuing.")
#     else if (($location.path() == '/login' || $location.path() == '/register') && $rootScope.authorized())
#       $location.path('/')

#     # if ($location.path() != '/login' && $location.path() != '/register')
#     #   FlashService.clear()
#   )
# )

# exports
root.gekwetter = gekwetter
