$(function(){
  $listings = $("#listings");
  $("form#item_search").bind("ajax:success", function(a, html, err){
    if(err === "success"){ $listings.html(html); }
  });
});