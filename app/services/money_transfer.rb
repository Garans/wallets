class MoneyTransfer

  attr_reader :sender, :recipient, :amount

  def initialize(sender_wallet, recipient_wallet, amount)
    @sender = sender_wallet
    @recipient = recipient_wallet
    @amount = amount
  end

  def call

  end
end