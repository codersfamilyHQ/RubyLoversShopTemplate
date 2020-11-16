class OrdersController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token, only: [:callback]

  def create
    result = ::Orders::Create.new.call(user: current_user, amount: 50)

    # binding.pry
    if result.success?
      redirect_to "https://sandbox.przelewy24.pl/trnRequest/#{result.value!}"
    else
      redirect_to root_path, notice: 'fail'
    end
    # zarejestrowania transakcji oraz przekierowanie na strone platnosciw
  end

  def callback
    params
  end
end
