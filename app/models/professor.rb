# == Schema Information
#
# Table name: professors
#
#  id         :integer          not null, primary key
#  first_name :string(255)
#  last_name  :string(255)
#  mobile     :integer
#  gender     :boolean
#  dob        :date
#  spamrate   :integer
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Professor < ActiveRecord::Base
	belongs_to :user
end
