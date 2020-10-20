  class CreateScore
    attr_reader :wallet, :user, :params, :currency

    BONUS_FUND = 1000

    def initialize(wallet, user, params)
      @wallet = wallet
      @user = user
      @params = params
      @currency = Currency.find(params[:currency_id])
    end

    def call
      wallet.currency = currency
      wallet.expire_date = score.expire_date
      wallet.number = score.number
      wallet.description = params[:description]
      wallet.funds = BONUS_FUND
      Wallet.transaction do
        WalletAvailable.transaction do
          CryptedDatum.transaction do
            wallet.save!
            wallet.users << user
            score.activated_at = Date.today
            score.status = false
            score.save!

            crypted_pin.owner = wallet
            crypted_pin.value = params[:pin]
            crypted_pin.save!
          end
        end
      end
      wallet
    end

    private

    def score
      @score ||= WalletAvailable.take_available_score(currency)
    end

    def crypted_pin
      @crypted_pin ||= CryptedDatum.new(value: params[:pin], is_active: true)
    end
  end

