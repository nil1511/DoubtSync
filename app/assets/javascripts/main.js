$(function(){
  $('.comments').hide();
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

    data.visibility_to_prof = !$('#anoncheckbox').prop('checked');
    data.tags = "";
      postarea.textntags('getTags', function(tags) {
        // data.tags = tags.id;
        
        for(a in tags){
          console.log(tags[a].user_id);  
          data.tags += tags[a].user_id+','
        }
        if(data.tags.length>0)
        data.tags=data.tags.substring(0,data.tags.length-1);
        console.log(data.tags);
        $.post('/posts',{ post: JSON.stringify(data)},function(e){
          if(e != 'invalid request'){
            var anon='';
            if(data.visibility_to_prof){
              anon = '<img alt="me" class="profilepic img-responsive" src="/images/original/missing.png" title="Anonymous">\
        <span>me</span>';
            }else{
              anon = '<img alt="Anonymous" class="profilepic img-responsive" src="/images/original/anonymous.png" title="Anonymous">\
        <span>Anonymous</span>';
            }
            var p ='<div class="col-md-7 singlepost" data-pid="'+e+'">\
        <div class="imagecontainer">'+
        anon
        +'</div>\
        <div class="posttext">\
          <div>\
          <span class="view glyphicon glyphicon-plus-sign"></span>\
          <span class="delete glyphicon glyphicon-remove-circle"></span>\
          </div>\
          <p class="ptext">'+data.text+'</p>\
        </div>\
        <div class="comments" style="display: none;">\
          <div class="insertcomment">\
            <textarea class="writecomment"></textarea>\
            <button class="commentpost">Post</button>\
          </div>\
        </div>\
      </div>';
       $('#posts').prepend(p);
          }
          console.log(e);
        },"json");
        postarea.val('');
        $('#anoncheckbox').prop('checked',false);
    });
    
    e.preventDefault();
    $(this).toggleClass('active');
  });

  $(window).resize(function(e) {
    postbutton.removeClass('active');
  });

  $('.view.glyphicon-plus-sign').on('click',function (e) {
    var post = $(this).parent('div').parent('div.posttext').parent('div.singlepost'); 
    c = post.children('.comments');

    if($(e.target).hasClass('glyphicon-minus-sign')){
      c.slideUp('fast',function () {
        
          $(e.target).removeClass('glyphicon-minus-sign');
          $(e.target).addClass('glyphicon-plus-sign');
        
      });
    }else
    {
      c.slideDown('fast',function () {
        
        if($(e.target).hasClass('glyphicon')){
          $(e.target).removeClass('glyphicon-plus-sign');
          $(e.target).addClass('glyphicon-minus-sign');
        }
      });
        
    }
  });

  $('.delete').on('click',function (e) {
    
    c=confirm('Do you want to delete this query?');
    if(c){
      var post = $(this).parent('div').parent('div.posttext').parent('div.singlepost');  
      $.ajax({
      url: '/posts/'+post.data('pid'),
      type: 'DELETE',
      success: function(result) {
        if(result)
          post.remove();
        }
      });
    }
  });

  $('.commentpost').on('click',function(e){    
    var post = $(this).parent('div.insertcomment').parent('div.comments').parent('div.singlepost'); 
    if($(this).prev().val()==''){
      return false;
    }
    console.log(post.data('pid'),$(this).prev().val());
    var data = {};
    var textarea = $(this).prev();
    data.text = textarea.val();
    data.post_id = post.data('pid');
    $.post('/comments',{ comment: JSON.stringify(data)},function(e){
      if(e==1){ 
          var c = 
          '<div class="singlecomment">\
          <div class="commentimage">\
          <img alt="Anonymous" class="profilepic img-responsive" src="/images/original/missing.png">\
          <span>me</span>\
          </div>\
          <div class="commenttext">\
          <div>\
          <span class="up glyphicon glyphicon-circle-arrow-up"></span>\
          <span class="number">0</span>\
          <span class="down glyphicon glyphicon-circle-arrow-down"></span>\
          </div>\
          <p class="ctext">'+data.text+'</p>\
          </div>\
          </div>';
          var comment = post.children('.comments');

          console.log(comment)
          if(comment.children('.singlecomment').length == 1)
          comment.children('.singlecomment').last().after(c);
          else
          comment.children('.insertcomment').before(c);
          textarea.val('');
      }
    },"json");
  });

  $('.up').on('click',function (e) {
    var comment = $(this).parent('div').parent('.commenttext').parent('.singlecomment');
    var cid = comment.data('cid');
    $.post('/comments/'+cid+'/up',function (argument) {
      console.log(argument)
    })
  })

  $('.down').on('click',function (e) {
    var comment = $(this).parent('div').parent('.commenttext').parent('.singlecomment');
    var cid = comment.data('cid');
    $.post('/comments/'+cid+'/down',function (argument) {
      console.log(argument)
    })
  })



});