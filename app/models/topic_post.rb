# == Schema Information
#
# Table name: topic_posts
#
#  id         :integer          not null, primary key
#  post_id    :integer
#  topic_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

class TopicPost < ActiveRecord::Base
	belongs_to :post
	belongs_to :topic
end
