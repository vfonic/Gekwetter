# $(document).ready ->
#   $('.new_status').click ->
#     bootbox.dialog {
#       title: 'New status'
#       message: $('.new_status_box').html()
#     }


root = global ? window

angular.module("microposts", ["ngResource"]).factory "Micropost", ['$resource', ($resource) ->
  Micropost = $resource("/:username/:id/:action",
    id: "@id"
    action: "@action"
  ,
    update:
      method: "PUT"

    destroy:
      method: "DELETE"
  )
  Micropost::destroy = (cb) ->
    Micropost.remove
      id: @id
    , cb

  Micropost
]
root.angular = angular
