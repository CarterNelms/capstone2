$(function(){
  $titles = $("#titles");
  $("form.titles").bind("ajax:success", function(a, html, err){
    if(err === "success"){ $titles.html(html); }
  });
});