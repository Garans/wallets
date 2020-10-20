class CreateTransactionFromAtm < CreateTransaction
  protected

  def recipient_score
    @recipient_score ||= Atm.find_wallet_by_in_crypt(params[:to_score])
  end

  def recipient_type
    Atm.name
  end
end
