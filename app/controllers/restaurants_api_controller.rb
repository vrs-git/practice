class RestaurantsApiController < ApiController
	before_action :authenticate_restaurant,only:[:signout]
	def signin
		email=params["email"]
		password=params["password"]
		restaurant = Restaurant.find_for_authentication(email:email)
		if restaurant
			if restaurant.valid_password?(password)
				session["restaurant_id"]=restaurant.id
				return response_data session,"You are logged in",200
			end
		else
			return response_data nil,"Please sign up",200
		end
		# restaurant=Restaurant.find_by_email_and_password(email:email,password:password)
	end
	def signup
		# byebug
		email=params["email"]
		password=params["password"]
		restaurantname=params["restaurant_name"]
		ownersfirstname=params["owners_first_name"]
		ownerslastname=params["owners_last_name"]
		phonenumber=params["phone_number"]
		address=params["address"]
		restaurant=Restaurant.new(email:email,password:password,restaurant_name:restaurantname,owners_first_name:ownersfirstname,owners_last_name:ownerslastname,phone_number:phonenumber,address:address)
		if restaurant.save
			session["restaurant_id"]=restaurant.id
			return response_data restaurant,"created new id",200
		else
			return response_data nil,restaurant.errors.messages,200
		end
	end
	def signout
		# @current_restaurant.logout
		session["restaurant_id"]=nil
		return response_data nil,"You are logged out",200
	end
end