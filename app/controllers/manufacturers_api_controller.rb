class ManufacturersApiController < ApiController
	before_action :authenticate_manufacturer,only:[:signout]
	def signin
		email=params["email"]
		password=params["password"]
		manufacturer = Manufacturer.find_for_authentication(email:email)
		if manufacturer
			if manufacturer.valid_password?(password)
				session["manu_id"]=manufacturer.id
				return response_data session,"You are logged in",200
			end
		else
			return response_data nil,"Please sign up",200
		end
		# manufacturer=Manufacturer.find_by_email_and_password(email:email,password:password)
	end
	def signup
		# byebug
		email=params["email"]
		password=params["password"]
		firstname=params["first_name"]
		lastname=params["last_name"]
		phonenumber=params["phone_number"]
		factory_address=params["factory_address"]
		storage_address=params["storage_address"]
		manufacturer=Manufacturer.new(email:email,password:password,first_name:firstname,last_name:lastname,phone_number:phonenumber,factory_address:factory_address,storage_address:storage_address)
		if manufacturer.save
			session["manu_id"]=manufacturer.id
			return response_data manufacturer,"created new id",200
		else
			return response_data nil,manufacturer.errors.messages,200
		end
	end
	def signout
		# @current_manufacturer.logout
		session["manu_id"]=nil
		return response_data nil,"You are logged out",200
	end
end