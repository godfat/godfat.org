var code  = ['#d18', '#f18', '#rbx-jruby']

var news  = ['#news-2007-08-23', '#news-2008-12-12',
             '#news-2008-12-17', '#news-2009-06-09',
             '#news-2009-09-05', '#news-2009-10-08']

var items = ['#links', '#projects', '#slides',
             '#programming-languages', '#time-graphs',
             '#favors', '#games', '#comic',
             '#composers', '#singers', '#albums',
             '#books', '#misc', '#headphone']

jQuery.each(
  code.concat(news).concat(items),
  function(i, v){
    $(v).hide();
    $(v + '-toggle').click( function(){ $(v).toggle(); } );
  });

function fold_all(){
  jQuery.each( items, function(i, v){ $(v).hide() });
}

function collapse_all(){
  jQuery.each( items, function(i, v){ $(v).show() });
}
