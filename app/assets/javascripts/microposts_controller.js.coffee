root = global ? window

MicropostsController = ($scope, Micropost) ->
  $scope.Microposts = Micropost.query()
  $scope.colors = [
    {name: 'Red', value: 'red'}
    {name: 'Yellow', value: 'yellow'}
    {name: 'Green', value: 'green'}
  ]
  $scope.Micropost = {"importance": "yellow"}

  $scope.save = ->
    Micropost.save @Micropost, (data) ->
      $scope.Microposts.push(new Micropost(data.Micropost))
      $scope.Micropost.title = ""
      $scope.Micropost.importance = "yellow"

  $scope.destroy = ->
    original = @Micropost
    bootbox.confirm("Are you sure?", (response) ->
      if response
        original.destroy ->
          $scope.Microposts = _.without($scope.Microposts, original)
    )

  $scope.complete = (complete) ->
    original = @Micropost
    @Micropost.complete complete, ->
      original.completed = complete

  # $scope.sortableOptions = {
  #   stop: (e, ui) ->
  #       from = ui.item.sortable.index
  #       to = ui.item.index()
  #       Micropost.reorder {
  #         source: from,
  #         destination: to
  #       }
  # }

MicropostsController.$inject = ['$scope', 'Micropost'];

# MicropostsCreateCtrl = ($scope, $location, Micropost) ->
#   $scope.save = ->
#     Micropost.save $scope.Micropost, (data) ->
#       $location.path "/Microposts"

# MicropostsCreateCtrl.$inject = ['$scope', '$location', 'Micropost'];

# MicropostsShowCtrl = ($scope, $location, $routeParams, Micropost) ->
#   Micropost.get
#     id: $routeParams.id
#   , (Micropost) ->
#     @original = Micropost
#     $scope.Micropost = new Micropost(@original)

#   $scope.destroy = ->
#     bootbox.confirm("Are you sure?", (response) ->
#       if response
#         $scope.Micropost.destroy ->
#           $location.path "/Microposts"
#     )

# MicropostsShowCtrl.$inject = ['$scope', '$location', '$routeParams', 'Micropost'];

# MicropostsEditCtrl = ($scope, $location, $routeParams, Micropost) ->
#   Micropost.get
#     id: $routeParams.id
#   , (Micropost) ->
#     @original = Micropost
#     $scope.Micropost = new Micropost(@original)

#   $scope.destroy = ->
#     bootbox.confirm("Are you sure?", (response) ->
#       if response
#         $scope.Micropost.destroy ->
#           $location.path "/Microposts"
#     )

#   $scope.save = ->
#     Micropost.update $scope.Micropost, (data) ->
#       $location.path "/Microposts"

# MicropostsEditCtrl.$inject = ['$scope', '$location', '$routeParams', 'Micropost'];

# exports
root.MicropostsController  = MicropostsController
# root.MicropostsCreateCtrl = MicropostsCreateCtrl
# root.MicropostsShowCtrl   = MicropostsShowCtrl
# root.MicropostsEditCtrl   = MicropostsEditCtrl 
