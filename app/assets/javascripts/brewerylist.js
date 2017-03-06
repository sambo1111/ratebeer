var BREWERIES = {};

BREWERIES.show = function(){
    $("#brewerytable tr:gt(0)").remove();

    var table = $("#brewerytable");

    $.each(BREWERIES.list, function (index, brewery) {
        table.append('<tr>'
            +'<td>'+brewery['name']+'</td>'
            +'<td>'+brewery['year']+'</td>'
            +'<td>'+brewery['beers'].length+'</td>'
            +'<td>'+brewery['active']+'</td>'
            +'</tr>');
    });
};

BREWERIES.sort_by_name = function(){
    BREWERIES.list.sort( function(a,b){
        return a.name.toUpperCase().localeCompare(b.name.toUpperCase());
    });
};

BREWERIES.sort_by_year = function(){
    BREWERIES.list.sort( function(a,b){
      if (parseInt(b.year) > parseInt(a.year)) return 1;
      else if (parseInt(b.year) < parseInt(a.year)) return -1;
      else return 0;
    });
};

BREWERIES.sort_by_beer_count = function(){
    BREWERIES.list.sort( function(a,b){
      if (parseInt(b.beers.length) > parseInt(a.beers.length)) return 1;
      else if (parseInt(b.beers.length) < parseInt(a.beers.length)) return -1;
      else return 0;
    });
};

$(document).ready(function () {
    if ( $("#brewerytable").length>0 ) {

      $("#name").click(function (e) {
          BREWERIES.sort_by_name();
          BREWERIES.show();
          e.preventDefault();
      });

      $("#year").click(function (e) {
          BREWERIES.sort_by_year();
          BREWERIES.show();
          e.preventDefault();
      });

      $("#beers").click(function (e) {
          BREWERIES.sort_by_beer_count();
          BREWERIES.show();
          e.preventDefault();
      });

      $("#active").click(function (e) {
          BREWERIES.show();
          e.preventDefault();
      });

      $.getJSON('breweries.json', function (breweries) {
        BREWERIES.list = breweries;
        BREWERIES.show();
      });

    }
});
