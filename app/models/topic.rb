# == Schema Information
#
# Table name: topics
#
#  id         :integer          not null, primary key
#  name       :text
#  group      :text
#  created_at :datetime
#  updated_at :datetime
#

class Topic < ActiveRecord::Base
	belongs_to :user
	validates :name, presence: true
end
