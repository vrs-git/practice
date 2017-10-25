class CustomersApiController < ApiController
	before_action :authenticate_customer,only:[:signout]
	def signin
		email=params["email"]
		password=params["password"]
		customer = Customer.find_for_authentication(email:email)
		if customer
			if customer.valid_password?(password)
				session["cust_id"]=customer.id
				return response_data session,"You are logged in",200
			end
		else
			return response_data nil,"Please sign up",200
		end
		# customer=Customer.find_by_email_and_password(email:email,password:password)
	end
	def signup
		# byebug
		email=params["email"]
		password=params["password"]
		firstname=params["first_name"]
		lastname=params["last_name"]
		phonenumber=params["phone_number"]
		address=params["address"]
		customer=Customer.new(email:email,password:password,first_name:firstname,last_name:lastname,phone_number:phonenumber,address:address)
		if customer.save
			session["cust_id"]=customer.id
			return response_data customer,"created new id",200
		else
			return response_data nil,customer.errors.messages,200
		end
	end
	def signout
		# @current_customer.logout
		session["cust_id"]=nil
		return response_data nil,"You are logged out",200
	end
end