$(function(){

  var ajax_request = false;
  $('textarea.postarea').textntags({
      onDataRequest:function (mode, query, triggerChar, callback) {
          // fix for overlapping requests
          if(ajax_request) ajax_request.abort();
          ajax_request = $.getJSON('user?search=tes', function(responseData) {
              query = query.toLowerCase();
              responseData = _.filter(responseData, function(item) { return item.first_name.toLowerCase().indexOf(query) > -1; });
              callback.call(this, responseData);
              ajax_request = false;
          });
      }
  });

	// $('textarea.postarea').textntags({
 //  onDataRequest: function (mode, query, triggerChar, callback) {
 //    console.log(arguments); 
 //    var data = [
 //      { id:1, name:'Daniel Zahariev',  'img':'http://example.com/img1.jpg', 'type':'contact' },
 //      { id:2, name:'Daniel Radcliffe', 'img':'http://example.com/img2.jpg', 'type':'contact' },
 //      { id:3, name:'Daniel Nathans',   'img':'http://example.com/img3.jpg', 'type':'contact' }
 //    ];

 //    query = query.toLowerCase();
 //    var found = _.filter(data, function(item) { return item.name.toLowerCase().indexOf(query) > -1; });

 //   callback.call(this, found);
 //  	}
	// });

	// $('textarea.postarea').hashtags();

  postbutton = $('button.post');

  postbutton.click(function(e) {
    var postarea = $('textarea.postarea');
    if(!postarea.val().trim()){
      console.log('fill something to post');
        return;
    }
    var data ={};
    
    data.text = postarea.val();
    data.htags = $('.hashtag').text().split('#').slice(1).toString();
    data.visibility_to_prof = false;
    data.tags = "";
    
    $.post('/posts',{ post: JSON.stringify(data)},function(e){
      console.log(e);
    },"json");

    e.preventDefault();
    $(this).toggleClass('active');
  });

  $(window).resize(function(e) {
    postbutton.removeClass('active');
  });

})