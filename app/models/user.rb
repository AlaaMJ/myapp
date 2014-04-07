class User < ActiveRecord::Base

	attr_accessor :password
	attr_accessible :username, :email, :first_name, :last_name, :password, :password_confirmation
	
	before_save :encrypt_password
    after_save :clear_password
  
	EMAIL_REGEX = /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.edu\z/i
    validates :username, :presence => true, :uniqueness => true, :length => { :in => 3..20 }
    validates :email, :presence => true, :uniqueness => true, :format => EMAIL_REGEX
    validates :password, :confirmation => true
    #Only on Create so other actions like update password attribute can be nil
    validates_length_of :password, :in => 6..20, :on => :create

	
	has_many :sent_messages,
  	:class_name => 'Message',
  	#:primary_key => 'user_id',
  	:foreign_key => 'sender_id',
  	:order => "messages.created_at DESC",
  	:conditions => ["messages.delete_s = ?", false]
    has_many :recieved_messages,
  	:class_name => 'Message',
  	#:primary_key => 'user_id',
  	:foreign_key => 'reciever_id',
  	:order => "messages.created_at DESC",
  	:conditions => ["messages.delete_r = ?", false]
  	
  
  def self.authenticate(username_or_email="", login_password="")

    if  EMAIL_REGEX.match(username_or_email)    
      user = User.find_by_email(username_or_email)
    else
      user = User.find_by_username(username_or_email)
    end

    if user && user.match_password(login_password)
      return user
    else
      return false
    end
  end   

  def match_password(login_password="")
    password == BCrypt::Engine.hash_secret(login_password, salt)
  end
  
  
  
  def encrypt_password
    unless password.blank?
      self.salt = BCrypt::Engine.generate_salt
      self.password = BCrypt::Engine.hash_secret(password, salt)
    end
  end
  
  
  def clear_password
    self.password = nil
  end
  	
end
