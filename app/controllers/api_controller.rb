class ApiController < ActionController::API
	def response_data data,message,status
		data={
			data:data,
			message:message,
		}
		render json:data,status:status
	end
	def authenticate_customer
		# access_token=params["access_token"]
		# @current_user=User.find_by_access_token(access_token)
		@current_customer=Customer.where(id:session["cust_id"]).first
		unless @current_customer #&& access_token!=nil
			return response_data nil,"Please Login",200
		end
	end
	def current_customer
		@current_customer
	end
	def authenticate_retailer
		# access_token=params["access_token"]
		# @current_user=User.find_by_access_token(access_token)
		@current_retailer=Retailer.where(id:session["retailer_id"]).first
		unless @current_retailer #&& access_token!=nil
			return response_data nil,"Please Login",200
		end
	end
	def confirm_retailer
		@current_retailer=Retailer.where(id:session["retailer_id"]).first
		unless @current_retailer.confirmed? #&& access_token!=nil
			return response_data nil,"Please verify your email",200
		end
	end
	def current_retailer
		@current_retailer
	end
	def authenticate_manufacturer
		# access_token=params["access_token"]
		# @current_user=User.find_by_access_token(access_token)
		@current_manufacturer=Manufacturer.where(id:session["manu_id"]).first
		unless @current_manufacturer #&& access_token!=nil
			return response_data nil,"Please Login",200
		end
	end
	def confirm_manufacturer
		@current_manufacturer=Manufacturer.where(id:session["manu_id"]).first
		unless @current_manufacturer.confirmed? #&& access_token!=nil
			return response_data nil,"Please verify your email",200
		end
	end
	def current_manufacturer
		@current_manufacturer
	end
	def authenticate_restaurant
		# access_token=params["access_token"]
		# @current_user=User.find_by_access_token(access_token)
		@current_restaurant=Restaurant.where(id:session["restaurant_id"]).first
		unless @current_restaurant #&& access_token!=nil
			return response_data nil,"Please Login",200
		end
	end
	def confirm_restaurant
		# access_token=params["access_token"]
		# @current_user=User.find_by_access_token(access_token)
		@current_restaurant=Restaurant.where(id:session["restaurant_id"]).first
		unless @current_restaurant.confirmed? #&& access_token!=nil
			return response_data nil,"Please verify your email",200
		end
	end
	def current_restaurant
		@current_restaurant
	end
	
end