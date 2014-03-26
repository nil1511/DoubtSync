# == Schema Information
#
# Table name: comments
#
#  id           :integer          not null, primary key
#  text         :string(255)
#  tagged_users :text
#  htags        :text
#  user_id      :integer
#  post_id      :integer
#  spamrate     :integer
#  upvotes      :string(255)
#  downvotes    :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

class Comment < ActiveRecord::Base
	belongs_to :post
	belongs_to :user
end
