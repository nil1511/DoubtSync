class NotifyPostaddTopic < Struct.new(:post_id)

	#FIXME New Topic is not adapted by post
	def perform
		post = Post.find_by_id(post_id)
		puts "Started job"
		tagged_users = post.tagged_users.split(',');
		
		name = post.user.profile.first_name << ' '<< post.user.profile.last_name;

		tagged_users.each do |userid|
			text = name +' tagged you in a Post'
			if userid.to_i != 0
				Notification.create(text: text,user_id: userid.to_i);
			end
		end
		puts "Added Notification";


		post.text.split('#').each_with_index do |item,index|
			if index == 0
				next
			end
			n = item.split(' ')[0]
			topic = Topic.create(name: n);
			post.htags = post.htags.to_s + topic.id.to_s+',';
			post.save
			puts topic.id.to_s
		end
		
		htags = post.htags.split(',');
		puts htags.to_s;
		htags.each do |topic_id|
			if topic_id.to_i != 0
				TopicPost.create(topic_id: topic_id,post_id: post_id);
			end
		end
		puts "Added Topics";
	end
end