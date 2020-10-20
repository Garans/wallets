# frozen_string_literal: true

class TransactionController < ApplicationController
  def show; end

  def new
    @from_wallets = current_user.wallets.map { |x| [x.number, x.number] }
    @to_wallets = @from_wallets
    @recipient_type = :wallet
  end

  def create
    @transaction = TransferStates::StateManager.perform(transaction_params)
    redirect_to transfer_index_path
  end

  def new_withdraw
    @recipient_type = :atm
    @from_wallets = current_user.wallets.map { |x| [x.number, x.number] }
    @to_wallets = Atm.all.map { |x| ["Atm number #{x.number}", x.number] }
    render :new
  end

  def index
    @transactions = Transaction.all
  end

  private

  def transaction_params
    params.permit(:from_score, :to_score, :amount, :pin_code, :recipient_type)
  end
end
