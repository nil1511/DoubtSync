# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  username               :string(255)
#  profile_id             :integer
#  role_id                :integer
#  college_id             :integer
#  avatar_file_size       :integer
#  avatar_file_name       :string(255)
#  avatar_content_type    :string(255)
#  avatar_updated_at      :datetime
#  created_at             :datetime
#  updated_at             :datetime
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
#   validates :username, presence: true
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  validates :username,
  presence: true,
  :uniqueness => {:case_sensitive => false}

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :books, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :events
  has_many :followed_topics
  has_many :topics, through: :followed_topics

  belongs_to :college
  belongs_to :role

  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed

  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  
  has_many :followers, through: :reverse_relationships, source: :follower



  has_many :sent, foreign_key: "sender_id",class_name:  "Message", dependent: :destroy

  has_many :inbox, foreign_key: "receiver_id",
                                   class_name:  "Message",
                                   dependent:   :destroy
  


  before_create :set_default_role

  after_create :link_profile
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  
  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end
  
  def following_topic?(topic)
    topics.find_by(id: topic.id)
  end
  
  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy
  end

  def send_message!(other_user, message)
    Message.create!(sender_id: self.id, receiver_id: other_user.id,text: message)
  end

  def unread_message
    self.inbox.where(read: nil)
  end

  def profile
    if self.role.name=='student' or self.role.name=='ambassador'
      Student.find_by(user_id: self.id)
    elsif self.role.name=='professor'
      Professor.find_by(user_id: self.id)
    end
  end

  def name
    return self.profile.first_name.to_s + ' ' + self.profile.last_name.to_s
    
  end
  def set_role(new_role)
    self.role ||= Role.find_by_name(new_role)
  end

  private
  def set_default_role
    self.role ||= Role.find_by_name('student')
  end

  def link_profile
    if self.role.name=='student' or self.role.name=='ambassador'
      student = Student.new(:user_id => self.id)
      student.save
      self.profile_id = student.id
      self.save

    elsif self.role.name=='professor'
      professor = Professor.new(:user_id => self.id)
      professor.save
    end
  end
end
