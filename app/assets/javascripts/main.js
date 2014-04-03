$(function(){
  $('.comments').hide();
  var ajax_request = false;
  $('textarea.postarea').textntags({
     triggers: {
      '#': {
            uniqueTags   : false,
            syntax       : _.template('#[<%= id %>:<%= type %>:<%= title %>]'),
            parser       : /(#)\[(\d+):([\w\s\.\-]+):([\w\s@\.,-\/#!$%\^&\*;:{}=\-_`~()]+)\]/gi,
            parserGroups : {id: 2, type: 3, title: 4},
        }},
      onDataRequest:function (mode, query, triggerChar, callback) {
          // fix for overlapping requests
          if(ajax_request) ajax_request.abort();

          if(triggerChar == '@')
          ajax_request = $.getJSON('user?search='+query, function(responseData) {
              query = query.toLowerCase();
              responseData = _.filter(responseData, function(item) {
                item.type ='user';
                item.name = item.first_name;
                item.id = item.user_id;
                return item.name.toLowerCase().indexOf(query) > -1; });
              callback.call(this, responseData);
              ajax_request = false;
          });
          else
          ajax_request = $.getJSON('topic?search='+query, function(responseData) {
              query = query.toLowerCase();
              responseData = _.filter(responseData, function(item) {
                item.type ='topic';
                return item.name.toLowerCase().indexOf(query) > -1; 
              });
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
    data.htags = "";
      postarea.textntags('getTags', function(tags) {
        // data.tags = tags.id;
        // console.log(tags)
        for(a in tags){
          if (tags[a].type == 'user')
          data.tags += tags[a].user_id+','
        else if (tags[a].type == 'topic')
          data.htags += tags[a].id+','
        }

        if(data.tags.length>0)
        data.tags=data.tags.substring(0,data.tags.length-1);
        data.htags=data.htags.substring(0,data.htags.length-1);
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
        $('.textntags-beautifier').children('div').html('')
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
    var post = $(this).parent('.media-body').parent('.media');
    var inputarea = $(this).parent('.media-body').children('input');
    var img = post.children('a').children('img.profilepic');
    if(inputarea.val().trim()==''){
      return false;
    }
    var data = {};
    data.text = inputarea.val();
    data.post_id = post.data('pid');
    $.post('/comments',{ comment: JSON.stringify(data)},function(e){
      if(e==1){ 
          var c = 
          '<div class="panel-footer" style="background-color:#F9F9F9">\
  <li class="media">\
    <a class="pull-left" href="#">\
    <img alt="'+img.prop("alt")+'" class="commentimg img-responsive" src="'+img.prop("src")+'" title="'+img.prop("title")+'">\
    </a>\
    <div class="media-body">\
   <ul class="nav nav-pills nav-stacked" style="float:right" data-cid="7">\
     <li>\
     <button type="button" class="btn btn-success btn-sm">\
     <span class="up glyphicon glyphicon-thumbs-up" <="" span="">\
     </span></button>\
     </li>\
     <li>\
          0\
     </li>\
     <li>\
     <button type="button" class="btn btn-danger btn-sm">\
      <span class="dowm glyphicon glyphicon-thumbs-down"></span>\
     </button>\
     </li>\
  </ul>\
  <button type="button" class="btn btn-default btn-xs" style="float:right; margin-right:10px">Mark as spam</button>\
      <h5 class="media-heading" style="color:#00557D">'+img.prop("title")+'</h5>\
    <p>'+data.text+'</p>\
    </div>\
  </li>\
  </div>';
          var comment = post.parent('.panel-footer').siblings('.media-list');
          comment.append(c);
          inputarea.val('');
      }
    },"json");
  });

  $('.up').on('click',function (e) {
    var comment = $(this).parent('li').parent('ul')
    var number = $(this).parent('li').siblings('li.number');
    var cid = comment.data('cid');
    $.post('/comments/'+cid+'/up',function (argument) {
      console.log(argument)
      if(argument == 'up'){
        a=parseInt(number.html(),10);
        if((a+1) > 0)
        number.html('+'+(a+1));
        else if((a+1) < 0)
          number.html((a+1));
        else
          number.html('0');
      }
    })
  })

  $('.down').on('click',function (e) {  
    var comment = $(this).parent('li').parent('ul');
    var number = $(this).parent('li').siblings('li.number');
    var cid = comment.data('cid');
    $.post('/comments/'+cid+'/down',function (argument) {
      console.log(argument)
      if(argument == 'down'){
       a=parseInt(number.html(),10);
        if((a-1) > 0)
        number.html('+'+(a-1));
        else if((a-1) < 0)
          number.html((a-1));
        else
          number.html('0'); 
      }
    })
  })



});