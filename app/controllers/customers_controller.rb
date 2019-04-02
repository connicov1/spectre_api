class CustomersController < ApplicationController
	before_action :authenticate_user!

	def index
		@customers = Spectre.get_customers["data"]
	end

	def destroy
		Spectre.delete("/customers/#{params[:customer_id]}")
		redirect_to customers_path
	end
end
