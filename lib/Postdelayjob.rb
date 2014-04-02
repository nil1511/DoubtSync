class NotifyPostaddTopic < Struct.new(:post_id,:tag,:htag)
	def perform
		post = Post.find_by_id(post_id)
		puts "Started job"
		puts post_id;
		tagged_users = post.tagged_users.split(',');
		htags = post.htags.split(',');		
		name = post.user.profile.first_name << ' '<< post.user.profile.last_name;

		tagged_users.each do |userid|
			text = name +' tagged you in a Post'
			if userid.to_i != 0
				Notification.create(text: text,user_id: userid.to_i);
			end
		end
		puts "Added Notification";
		htags.each do |topic_id|
			if topic_id.to_i != 0
				TopicPost.create(topic_id: topic_id,post_id: post_id);
			end
		end
		puts "Added Topics";
	end
end