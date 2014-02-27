# == Schema Information
#
# Table name: professors
#
#  id           :integer          not null, primary key
#  first_name   :string(255)
#  last_name    :string(255)
#  mobile       :integer
#  college_name :string(255)
#  gender       :boolean
#  dob          :date
#  spamrate     :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class Professor < ActiveRecord::Base
end
