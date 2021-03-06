//= require jquery2
//= require jquery_ujs
//= require syntaxhighlighter_3.0.83/scripts/shCore
//= require syntaxhighlighter_3.0.83/scripts/shBrushRuby
//= require syntaxhighlighter_3.0.83/scripts/shBrushJScript
//= require syntaxhighlighter_3.0.83/scripts/shBrushCss
//= require syntaxhighlighter_3.0.83/scripts/shBrushXml
//= require owl.carousel.min
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
  $("#markdown_link").on("click", function(){
    $("#markdown_examples").slideToggle();
  });

  $("a.close").on("click", function(){
    $(this).parents('.flash-messages').fadeOut();
    return false;
  });

  $("body").on("click", "a[data-destroy='true']", function(link){
    remove_fields(link.currentTarget);
    return false;
  });

  SyntaxHighlighter.defaults['gutter'] = true;
  SyntaxHighlighter.all();

});
