# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  text       :string(255)
#  tag        :text
#  user_id    :integer
#  post_id    :integer
#  spamrate   :integer
#  created_at :datetime
#  updated_at :datetime
#

class Comment < ActiveRecord::Base
	belongs_to :post
	belongs_to :user
end
