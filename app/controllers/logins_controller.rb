class LoginsController < ApplicationController
  before_action :authenticate_user!, :create_customer

  def index
    return redirect_to customers_path unless params[:customer_id]

    @logins = Spectre.get_logins(params[:customer_id])["data"]
  end

  def destroy
    Spectre.delete("/logins/#{params[:login_id]}")
    redirect_to logins_path(customer_id: params[:customer_id])
  end

  def refresh
    Spectre.put("/logins/#{params[:login_id]}/refresh")
    redirect_to logins_path(customer_id: params[:customer_id])
  end

  def reconnect
    Spectre.put("/logins/#{params[:login_id]}/reconnect")
    redirect_to logins_path(customer_id: params[:customer_id])
  end

  def create
    url = Spectre.create_connection(current_user.spectre_id)["data"]["connect_url"]
    redirect_to url
  end

  def create_customer
    return if current_user.spectre_id.present?
    customer_id = Spectre.create_customer(current_user.email)["data"]["id"]
    current_user.update!(spectre_id: customer_id)
  end
end
