class FollowedTopic < ActiveRecord::Base
	belongs_to :user
	belongs_to :topic
end
