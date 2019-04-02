class AccountsController < ApplicationController
  before_action :authenticate_user!

  def index
    @accounts = Spectre.get_accounts(params[:login_id])["data"]
  end
end