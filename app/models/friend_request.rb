class FriendRequest < ActiveRecord::Base
  belongs_to :requester, :class_name => 'User', :foreign_key => :requesting_id
  belongs_to :friend, :class_name => 'User', :foreign_key => :target_id
end
