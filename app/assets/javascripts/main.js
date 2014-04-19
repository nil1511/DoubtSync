$(function() {
    $('#profselect').select2({
            placeholder: "Ask to Professors"
    });
    $('.dropdown-toggle').dropdown();
    $('.comments').hide();
    var ajax_request = false;
    
    $('textarea.postarea').textntags({
        triggers: {
            '#': {
                uniqueTags: false,
                syntax: _.template('#[<%= id %>:<%= type %>:<%= title %>]'),
                parser: /(#)\[(\d+):([\w\s\.\-]+):([\w\s@\.,-\/#!$%\^&\*;:{}=\-_`~()]+)\]/gi,
                parserGroups: {
                    id: 2,
                    type: 3,
                    title: 4
                },
            }
        },
        onDataRequest: function(mode, query, triggerChar, callback) {
            // fix for overlapping requests
            if (ajax_request) ajax_request.abort();

            if (triggerChar == '@')
                ajax_request = $.getJSON('user?search=' + query, function(responseData) {
                    query = query.toLowerCase();
                    responseData = _.filter(responseData, function(item) {
                        item.type = 'user';
                        return item.name.toLowerCase().indexOf(query) > -1;
                    });
                    callback.call(this, responseData);
                    ajax_request = false;
                });
            else
                ajax_request = $.getJSON('topic?search=' + query, function(responseData) {
                    query = query.toLowerCase();
                    responseData = _.filter(responseData, function(item) {
                        item.type = 'topic';
                        return item.name.toLowerCase().indexOf(query) > -1;
                    });
                    callback.call(this, responseData);
                    ajax_request = false;
                });
        }
    });


    if($('#notification span').hasClass('new')){
        $.get('/main/notificationlist',function(e){
            var d= '<ul style=" list-style: none; width: 250px;padding:0; ">';
            for(a in e){
                d+='<a href="'+e[a].url+'"><li class="notfication" data-nid='+e[a].id+'>'+e[a].text+'</li></a>';
            }
            d+='</ul>';
            $('#notification').popover({
                content: d,
                html: true
            })
        })

    }

    if($('#messegebtn span').hasClass('new')){
        $.get('/main/unreadmsg',function(e){
            var d= '<ul class="media-list" style=" list-style: none; width: 250px;padding:0; ">';
            for(a in e){
                // '<li class="umsg" data-nid='+e[a].id+'>'+e[a].text+'</li>';
                d+= '<li class="media" style="background-color:#FFFFFF" data-mid='+e[a].id+'>\
  <a class="pull-left" href="#">\
    <img class="media-object" src="'+e[a].pic+'" alt=" " style="width:50px; height:50px;">\
  </a>\
  <div class="media-body">\
    <h4 class="media-heading">'+e[a].name+'</h4>\
    <h5 class="media-heading">'+e[a].text+'</h5>\
  </div>\
  </li>';
            }
            d+='</ul><div style="text-align:center">\
<button type="submit" class="btn btn-primary">See all messages</button>\
</div>';
            $('#messegebtn').popover({
                content: d,
                html: true
            })
        })

    }

    postbutton = $('button.post');

    postbutton.click(function(e) {
        var postarea = $('textarea.postarea');
        if (!postarea.val().trim()) {
            console.log('fill something to post');

            return;
        }
        var data = {};
        data.text = postarea.val();
        // data.htags = $('.hashtag').text().split('#').slice(1).toString();

        data.visibility_to_prof = !$('#anoncheckbox').prop('checked');
        data.tags = "";
        data.htags = "";
        postarea.textntags('getTags', function(tags) {
            for (a in tags) {
                if (tags[a].type == 'user')
                    data.tags += tags[a].id + ','
                else if (tags[a].type == 'topic')
                    data.htags += tags[a].id + ','
            }

            if (data.tags.length > 0)
                data.tags = data.tags.substring(0, data.tags.length - 1);
            data.htags = data.htags.substring(0, data.htags.length - 1);
            $.post('/posts', {
                post: JSON.stringify(data)
            }, function(e) {
                if (e != 'invalid request') {
                    var img = '';
                    if (data.visibility_to_prof) {
                        img = '<img alt="me" class="profilepic img-responsive media-object" src="/images/original/missing.png" title="me">';
                    } else {
                        img = '<img alt="Anonymous" class="profilepic img-responsive media-object" src="/images/original/anonymous.png" title="Anonymous">';
                    }
                    var p = '<div class="col-md-8 singlepost well" data-pid="' + e + '">\
            <div class="media"><a class="pull-left" href="#">\
            ' + img + '</a><div class="media-body"><button type="button" class="btn btn-warning btn-sm" style="float:right">Spam</button>\
            <h4 class="media-heading" style="color:#00557D">' + name + '</h4><p>' + data.text + '</p></div></div>\
            <div class="panel-footer" style="background-color:#FFFFFF"><div class="media" data-pid="' + e + '">\
            <a class="pull-left" href="#">' + img + '</a><div class="media-body">\
            <input type="text" class="form-control" id="info" placeholder="Enter Comment"><button type="submit" class="btn btn-info commentpost" style="float:right;margin-top:10px">Submit</button><div class="form-group">\
            <label for="exampleInputFile" style="margin-top:5px">File input</label><input type="file" id="exampleInputFile"></div></div></div></div><ul class="media-list"><br></ul></div>';

                    console.log($('#posts'))
                    $('#posts').prepend(p);
                }
                console.log(e);
            }, "json");
            postarea.val('');
            $('.textntags-beautifier').children('div').html('')
            $('#anoncheckbox').prop('checked', false);
        });

        e.preventDefault();
        $(this).toggleClass('active');
    });

    $(window).resize(function(e) {
        postbutton.removeClass('active');
    });

    $(document).on('click','.view.glyphicon-plus-sign', function(e) {
        var post = $(this).parent('div').parent('div.posttext').parent('div.singlepost');
        c = post.children('.comments');

        if ($(e.target).hasClass('glyphicon-minus-sign')) {
            c.slideUp('fast', function() {

                $(e.target).removeClass('glyphicon-minus-sign');
                $(e.target).addClass('glyphicon-plus-sign');

            });
        } else {
            c.slideDown('fast', function() {

                if ($(e.target).hasClass('glyphicon')) {
                    $(e.target).removeClass('glyphicon-plus-sign');
                    $(e.target).addClass('glyphicon-minus-sign');
                }
            });

        }
    });

    $(document).on('click','.delete', function(e) {

        c = confirm('Do you want to delete this query?');
        if (c) {
            var post = $(this).parent('div').parent('div.posttext').parent('div.singlepost');
            $.ajax({
                url: '/posts/' + post.data('pid'),
                type: 'DELETE',
                success: function(result) {
                    if (result)
                        post.remove();
                }
            });
        }
    });

    $(document).on('click','.commentpost', function(e) {
        console.log('click', this)
        var post = $(this).parent('.media-body').parent('.media');
        var inputarea = $(this).parent('.media-body').children('input');
        var img = post.children('a').children('img.profilepic');
        if (inputarea.val().trim() == '') {
            return false;
        }
        var data = {};
        data.text = inputarea.val();
        data.post_id = post.data('pid');
        $.post('/comments', {
            comment: JSON.stringify(data)
        }, function(e) {
            console.log(e)
            if (e == 1) {
                var c =
                    '<div class="panel-footer" style="background-color:#F9F9F9">\
  <li class="media">\
    <a class="pull-left" href="#">\
    <img alt="' + img.prop("alt") + '" class="commentimg img-responsive" src="' + img.prop("src") + '" title="' + img.prop("title") + '">\
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
      <h5 class="media-heading" style="color:#00557D">' + img.prop("title") + '</h5>\
    <p>' + data.text + '</p>\
    </div>\
  </li>\
  </div>';
                var comment = post.parent('.panel-footer').siblings('.media-list');
                comment.append(c);
                inputarea.val('');
            }
        }, "json");
    });

    $(document).on('click','.up', function(e) {
        var comment = $(this).parent('li').parent('ul')
        var number = $(this).parent('li').siblings('li.number');
        var cid = comment.data('cid');
        $.post('/comments/' + cid + '/up', function(argument) {
            console.log(argument)
            if (argument == 'up') {
                a = parseInt(number.html(), 10);
                if ((a + 1) > 0)
                    number.html('+' + (a + 1));
                else if ((a + 1) < 0)
                    number.html((a + 1));
                else
                    number.html('0');
            }
        })
    })

    $(document).on('click','.down', function(e) {
        var comment = $(this).parent('li').parent('ul');
        var number = $(this).parent('li').siblings('li.number');
        var cid = comment.data('cid');
        $.post('/comments/' + cid + '/down', function(argument) {
            console.log(argument)
            if (argument == 'down') {
                a = parseInt(number.html(), 10);
                if ((a - 1) > 0)
                    number.html('+' + (a - 1));
                else if ((a - 1) < 0)
                    number.html((a - 1));
                else
                    number.html('0');
            }
        })
    })

    $(document).on('click','.spam', function(e) {
        var button = $(this)
        if ($(this).prev('ul').length == 0) {
            //Post
            var pid = $(this).parent('.media-body').parent('.media').parent('.singlepost').data('pid');
            $.post('/posts/' + pid + '/spam', function(data) {
                if (data) {
                    button.addClass('disabled');
                }
            })
        } else {
            //Comment
            var cid = $(this).prev('ul').data('cid');
            $.post('/comments/' + cid + '/spam', function(data) {
                if (data) {
                    button.addClass('disabled');
                }
            })
        }
    });

    $('#InputFile').fileupload({
       dataType: 'json',
        add: function (e, data) {
            console.log('Added File to upload');
            data.context = $('<button/>').text('Upload')
                .appendTo(document.body)
                .click(function () {
                    console.log('Sending file to upload')
                    data.context = $('<p/>').text('Uploading...').replaceAll($(this));
                    data.submit();
                });
        },
        done: function (e, data) {
            data.context.text('Upload finished.');
        }
    });

});
