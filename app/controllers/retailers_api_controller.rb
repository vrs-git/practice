class RetailersApiController < ApiController
	before_action :authenticate_retailer,only:[:signout]
	
	def signin
		email=params["email"]
		password=params["password"]
		retailer = Retailer.find_for_authentication(email:email)
		if retailer
			if retailer.valid_password?(password)
				session["retailer_id"]=retailer.id
				return response_data session,"You are logged in",200
			end
		else
			return response_data nil,"Please sign up",200
		end
		# retailer=Retailer.find_by_email_and_password(email:email,password:password)
	end
	def signup
		# byebug
		email=params["email"]
		password=params["password"]
		firstname=params["first_name"]
		lastname=params["last_name"]
		phonenumber=params["phone_number"]
		shop_address=params["shop_address"]
		residential_address=params["residential_address"]
		retailer=Retailer.new(email:email,password:password,first_name:firstname,last_name:lastname,phone_number:phonenumber,shop_address:shop_address,residential_address:residential_address)
		if retailer.save
			session["retailer_id"]=retailer.id
			return response_data retailer,"created new id",200
		else
			return response_data nil,retailer.errors.messages,200
		end
	end
	def signout
		# @current_retailer.logout
		session["retailer_id"]=nil
		return response_data nil,"You are logged out",200
	end
end