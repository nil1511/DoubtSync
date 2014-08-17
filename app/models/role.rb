# == Schema Information
#
# Table name: roles
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Role
	include Mongoid::Document
	has_many :users
	validates :name, presence: true
end
