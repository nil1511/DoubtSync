# == Schema Information
#
# Table name: messages
#
#  id                    :integer          not null, primary key
#  sender_id             :integer
#  receiver_id           :integer
#  text                  :text
#  document_file_name    :string(255)
#  document_content_type :string(255)
#  document_file_size    :integer
#  document_updated_at   :datetime
#  read                  :boolean
#  created_at            :datetime
#  updated_at            :datetime
#

class Message < ActiveRecord::Base
  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"
  validates :sender_id, presence: true	
  validates :receiver_id, presence: true

end
