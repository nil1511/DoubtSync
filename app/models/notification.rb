# == Schema Information
#
# Table name: notifications
#
#  id         :integer          not null, primary key
#  text       :string(255)
#  user_id    :integer
#  read       :integer
#  url        :text
#  created_at :datetime
#  updated_at :datetime
#

class Notification
	include Mongoid::Document
	belongs_to :user
  	default_scope -> { order('created_at DESC') }

  	validates :text, presence: true
	validates :user_id, presence: true

end
