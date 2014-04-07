class Message < ActiveRecord::Base
	attr_accessible :sender_id, :recepient_id, :sender_deleted, :recepient_deleted, :subject
	
	
	belongs_to :sender,
  	:class_name => 'User',
  	:foreign_key => 'sender_id'
  belongs_to :recepient,
  	:class_name => 'User',
  	:foreign_key => 'reciever_id'
  
    def mark_deleted(id, user_id)
		self.delete_s = true if self.sender_id == user_id and self.id = id
		self.delete_r = true if self.reciever_id == user.id and self.id = id
		
	end
	
	
end
