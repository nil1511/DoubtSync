$(function(){

  var ajax_request = false;
  $('textarea.postarea').textntags({
      onDataRequest:function (mode, query, triggerChar, callback) {
          // fix for overlapping requests
          if(ajax_request) ajax_request.abort();
          ajax_request = $.getJSON('user?search='+query, function(responseData) {
              query = query.toLowerCase();
              responseData = _.filter(responseData, function(item) {item.type ='contact'; 
                return item.first_name.toLowerCase().indexOf(query) > -1; });
              callback.call(this, responseData);
              ajax_request = false;
          });

      }
  });


  postbutton = $('button.post');

  postbutton.click(function(e) {
    var postarea = $('textarea.postarea');
    if(!postarea.val().trim()){
      console.log('fill something to post');
        return;
    }
    var data ={};
    data.text = postarea.val();
    // data.htags = $('.hashtag').text().split('#').slice(1).toString();
    data.visibility_to_prof = false;
    data.tags = "";
      postarea.textntags('getTags', function(tags) {
        // data.tags = tags.id;
        
        for(a in tags){
          console.log(tags[a].id);  
          data.tags += tags[a].id+','
        }
        if(data.tags.length>0)
        data.tags=data.tags.substring(0,data.tags.length-1);
        // console.log(data.tags);
        $.post('/posts',{ post: JSON.stringify(data)},function(e){
          console.log(JSON.stringify(data));
          console.log(e);
        },"json");
    });
    

    e.preventDefault();
    $(this).toggleClass('active');
  });

  $(window).resize(function(e) {
    postbutton.removeClass('active');
  });

})