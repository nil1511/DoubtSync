# == Schema Information
#
# Table name: messages
#
#  id          :integer          not null, primary key
#  sender_id   :integer
#  receiver_id :integer
#  text        :text
#  read        :boolean
#  created_at  :datetime
#  updated_at  :datetime
#

class Message < ActiveRecord::Base
  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"
  validates :sender_id, presence: true	
  validates :receiver_id, presence: true

  before_save :set_defaults

end
