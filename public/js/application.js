$(document).ready(function() {
  
  $.getJSON('/fetch', function(data) {
    $.each(data, function(key, value) {
      $('#incoming ul').prepend('<table><tr><td>' + value['body'] + '</td><td><a href="/tasks/' + value['id'] + '/accept">YES</a></td><td><a href ="/tasks/' + value['id'] + '/reject">NO</a></td></tr></table>')
    }); 
  });

});

