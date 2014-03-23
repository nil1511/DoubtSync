$(function(){
	$('textarea.postarea').textntags({
  onDataRequest: function (mode, query, triggerChar, callback) {
    var data = [
      { id:1, name:'Daniel Zahariev',  'img':'http://example.com/img1.jpg', 'type':'contact' },
      { id:2, name:'Daniel Radcliffe', 'img':'http://example.com/img2.jpg', 'type':'contact' },
      { id:3, name:'Daniel Nathans',   'img':'http://example.com/img3.jpg', 'type':'contact' }
    ];

    query = query.toLowerCase();
    var found = _.filter(data, function(item) { return item.name.toLowerCase().indexOf(query) > -1; });

   callback.call(this, found);
  	}
	});

	$('textarea.postarea').hashtags();
})