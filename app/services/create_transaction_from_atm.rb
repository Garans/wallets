class CreateTransactionFromAtm < CreateTransaction
  protected

  def builder
    Builders::TransactionFromAtmBuilder.build(params[:parent]) do |t|
      yield t
    end
  end
end
