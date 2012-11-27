class User < ActiveRecord::Base

	rolify
	# Include default devise modules. Others available are:
	# :token_authenticatable, :confirmable,
	# :lockable, :timeoutable and :omniauthable
	devise :invitable, :database_authenticatable, :registerable, :confirmable,
	       :recoverable, :rememberable, :trackable, :validatable, :omniauthable

	# Setup accessible (or protected) attributes for your model
	attr_accessible :role_ids, :as => :admin
	attr_accessible :username, :name, :email, :password, :password_confirmation, :remember_me

	validates_presence_of   :username
    validates_uniqueness_of :username, :scope => authentication_keys[1..-1], :case_sensitive => false, :allow_blank => true
  	validates 				:username, length: { minimum: 1, maximum: 15 }

  	validates_presence_of   :name
  	validates 				:name, length: { minimum: 1, maximum: 15 }



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

	def self.from_omniauth(auth)
	  where(auth.slice(:provider, :uid)).first_or_create do |user|
	  	user.skip_confirmation!
	    user.provider = auth.provider
	    user.uid = auth.uid
	    user.username = auth.info.nickname
	    user.name = auth.info.name
	   	user.email = auth.info.email
	  end
	end

	def self.new_with_session(params, session)
	  if session["devise.user_attributes"]
	    new(session["devise.user_attributes"], without_protection: true) do |user|
	      user.attributes = params
	      user.valid?
	    end
	  else
	    super
	  end
	end

	def password_required?
	  super && provider.blank?
	end

	def update_with_password(params, *options)
	  if encrypted_password.blank?
	    update_attributes(params, *options)
	  else
	    super
	  end
	end
end
