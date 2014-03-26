# == Schema Information
#
# Table name: ambassador_registrations
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  email        :string(255)
#  authcode     :string(255)
#  college_name :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

class AmbassadorRegistration < ActiveRecord::Base
end
