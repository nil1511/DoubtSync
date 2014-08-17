# == Schema Information
#
# Table name: followed_topics
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  topic_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

class FollowedTopic
	include Mongoid::Document
	belongs_to :user
	belongs_to :topic

	validates :user_id,  presence: true
	validates :topic_id,  presence: true

end
