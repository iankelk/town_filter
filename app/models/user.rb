class User < ActiveRecord::Base

	rolify
	# Include default devise modules. Others available are:
	# :token_authenticatable, :confirmable,
	# :lockable, :timeoutable and :omniauthable
	devise :invitable, :database_authenticatable, :registerable, :confirmable,
	       :recoverable, :rememberable, :trackable, :validatable

	# Setup accessible (or protected) attributes for your model
	attr_accessible :role_ids, :as => :admin
	attr_accessible :username, :name, :email, :password, :password_confirmation, :remember_me

	validates_presence_of   :username
    validates_uniqueness_of :username, :scope => authentication_keys[1..-1], :case_sensitive => false, :allow_blank => true
  	validates 				:username, length: { minimum: 1, maximum: 15 }

	# Virtual attribute for authenticating by either username or email
	# This is in addition to a real persisted field like 'username'
	attr_accessor :login
	attr_accessible :login

	def self.find_first_by_auth_conditions(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
      else
        where(conditions).first
      end
    end

	### This is the correct method you override with the code above
	### def self.find_for_database_authentication(warden_conditions)
	### end 

end
