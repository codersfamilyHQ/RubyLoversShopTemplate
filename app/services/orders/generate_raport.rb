module Orders
  class Create
    include Dry::Monads[:result, :do]

    def call(user:, amount:)
      transaction do
        order = yield create_order(user, amount)
        token = yield generate_payment_token(order)

        Success(token)
      end
    end

    private

    def create_order(user, amount)
      session_id = SecureRandom.uuid
      order = user.orders.new(amount: amount, p24_session_id: session_id)

      if order.save
        Success(order)
      else
        Failure(order.errors.full_messages)
      end
    end

    def generate_payment_token(order)
      ::Payments::GenerateToken.new.call(order)
    end

    def transaction
      ActiveRecord::Base.transaction do
        yield
      end
    end
  end
end
