# == Schema Information
#
# Table name: sregistrations
#
#  id         :integer          not null, primary key
#  role_id    :integer
#  name       :string(255)
#  email      :string(255)
#  authcode   :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Sregistration < ActiveRecord::Base
end
