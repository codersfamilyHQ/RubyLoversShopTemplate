class OrdersController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token, only: [:callback]

  def create
    result = ::Orders::Create.new.call(user: current_user, amount: 50)

    if result.success?
      token = result.value!
      redirect_to "#{Rails.application.credentials.przelewy24[:gateway_url]}/trnRequest/#{token}"
    else
      redirect_to root_path, notice: result.failure
    end
  end

  def callback
    result = ::Orders::Finalize.new.call(user: current_user, amount: 50)

    if result.success?
      head :ok
    else
      head :unprocessable_entity
    end
  end
end
