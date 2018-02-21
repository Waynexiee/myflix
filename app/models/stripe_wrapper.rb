module StripeWrapper
  class Charge
    def initialize(response, error_message)
      @response = response
      @error_message = error_message
    end

    def self.create(option={})
      begin
        response = Stripe::Charge.create(
          amount: option[:amount],
          currency: "usd",
          description: option[:description],
          card: option[:card]
        )
        new(response, nil)
      rescue Stripe::CardError => e
        new(nil, e.message)
      end
    end

    def successful?
      @response.present?
    end

    def error_message
      @error_message
    end
  end
end