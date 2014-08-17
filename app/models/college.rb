# == Schema Information
#
# Table name: colleges
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class College
	include Mongoid::Document
	has_many :users
	has_many :events
	validates :name, presence: true

	default_scope -> { order('name ASC') }
end
