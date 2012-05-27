class User < ActiveRecord::Base
  include ApplicationHelper
  
  has_many :checkins
  has_many :location_updates
  has_many :friend_requests, :foreign_key => :requesting_id
  has_many :friends, :through => :friend_requests , :conditions => 'friend_requests.approved = 1'

  authenticates_with_sorcery!
  
  def set_random_password
    password = password_confirmation = random_code(5)
  end
  
  def public_name
    team.present? ? "#{username} (of #{team})" : username
  end
  
  attr_accessible :email, :username, :password, :password_confirmation, :team
  
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email
  validates_uniqueness_of :username
end
