# == Schema Information
#
# Table name: students
#
#  id            :integer          not null, primary key
#  first_name    :string(255)
#  last_name     :string(255)
#  mobile        :integer
#  gender        :boolean
#  dob           :date
#  degree        :string(255)
#  graduate_year :integer
#  spamrate      :integer
#  user_id       :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class Student < ActiveRecord::Base
	#validates :name, presence: true

	belongs_to :user
end
