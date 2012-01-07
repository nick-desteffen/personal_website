// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require syntaxhighlighter_3.0.83/scripts/shCore
//= require syntaxhighlighter_3.0.83/scripts/shBrushRuby
//= require syntaxhighlighter_3.0.83/scripts/shBrushJScript
//= require syntaxhighlighter_3.0.83/scripts/shBrushCss
//= require syntaxhighlighter_3.0.83/scripts/shBrushXml
//= require_tree .

function remove_fields(link) {
  if(confirm("Are you sure?")){
    $(link).prev("input[type=hidden]").val("1");
    $(link).closest(".fields").hide();    
  }
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).parent().before(content.replace(regexp, new_id));
}

$(function(){
  $("#markdown_link").click(function(){
    $("#markdown_examples").slideToggle();
  });
});
