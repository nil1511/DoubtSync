# == Schema Information
#
# Table name: block_users
#
#  id         :integer          not null, primary key
#  blocker_id :integer
#  blocked_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class BlockUsers < ActiveRecord::Base
end
