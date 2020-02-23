class GatewayCall

  FAKEPAY_KEY = ENV['FAKEPAY_KEY']

  GATEWAY_ERRORS = {
  	1000001 => "Invalid credit card number",
  	1000002 => "Insufficient funds",
  	1000003 => "CVV failure",
  	1000004 => "Expired card",
  	1000005 => "Invalid zip code",
  	1000006	=> "Invalid purchase amount",
  	1000007 => "Invalid token",
  	1000008 => "Invalid params: can only pass token or card informationi"
  }

  def initialize(params)
    @amount = params[:amount]
    @card_number = params[:card_number]
    @expiration_year = params[:expiration_year]
    @expiration_month = params[:expiration_month]
    @zip_code = params[:zip_code]
    @cvv = params[:cvv]
  end

  def purchase
    response = HTTParty.post(
      "https://www.fakepay.io/purchase",
      :body => purchase_attributes.to_json,
      headers: {
      	"Accept" => "application/json",
        "Content-Type" => "application/json",
        "Authorization" => "Token #{FAKEPAY_KEY}"
      }
  	)
  end

  private

  attr_accessor :amount, :card_number, :expiration_month, :expiration_year, :zip_code, :cvv

  def purchase_attributes
  	{
      amount: amount,
      card_number: card_number,
      expiration_year: expiration_year,
      expiration_month: expiration_month,
      zip_code: zip_code,
      cvv: cvv
	}
  end
end