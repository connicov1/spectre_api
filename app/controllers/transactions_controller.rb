class TransactionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @transactions = Spectre.get_transactions(params[:account_id])["data"]
  end
end
