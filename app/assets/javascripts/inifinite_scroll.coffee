$(document).ready ->
  $(".users .page").infinitescroll
    navSelector: ".pagination"
    nextSelector: ".pagination a[rel=next]"
    itemSelector: ".user"
    loading:
      msgText: ""

  $(".timeline .page").infinitescroll
    navSelector: ".pagination"
    nextSelector: ".pagination a[rel=next]"
    itemSelector: ".micropost"
    loading:
      msgText: ""
