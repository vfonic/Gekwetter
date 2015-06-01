root = global ? window

gekwetter.controller('UsersCtrl', ['$scope', '$http', '$location', '$rootScope', ($scope, $http, $location, $rootScope) ->
  # $rootScope.current_user = JSON.parse($("meta[name='current_user']").attr('content'))

  $rootScope.authorized = ->
    false
    # $rootScope.current_user? and $rootScope.current_user.id?

  # $scope.login = ->
  #   authData = {user: {email: $scope.email, password: $scope.password}}

  #   $http(
  #     method: "POST"
  #     url: "/login"
  #     data: authData
  #   )
  #   .success (data) ->
  #     $rootScope.current_user = data.current_user
  #     $("meta[name='current_user']").attr('content', JSON.stringify(data))
  #     $location.path "/"
  #     # FlashService.show(data.message)
  #   .error (data, status) ->

  # $scope.logout = ->
  #   $http(
  #     method: "DELETE"
  #     url: "/logout"
  #   )
  #   .success (data) ->
  #     $rootScope.current_user = null
  #     $("meta[name='current_user']").attr('content', "null")
  #     # explicitly redirect to /register in order to skip calling microposts#index for guest user
  #     $location.path "/login"
  #     # FlashService.clear()
  #   .error (data, status) ->

  # $scope.register = ->
  #   registerData = {user: {name: $scope.name, email: $scope.email, password: $scope.password, password_confirmation: $scope.password}}

  #   $http.post("/register"
  #     registerData
  #   )
  #   .success (data) ->
  #     $rootScope.current_user = data
  #     $("meta[name='current_user']").attr('content', JSON.stringify(data))
  #     $location.path "/"
  #   .error (data) ->
])

#exports
# root.UsersCtrl  = UsersCtrl
