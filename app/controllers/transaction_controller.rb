# frozen_string_literal: true

class TransactionController < ApplicationController
  before_action :authenticate_user!
  before_action :build_scores, only: %i[new new_withdraw]
  def show; end

  def new
    @recipient_type = :wallet
  end

  def create
    wallet = Wallet.find_by_number_encrypted(transaction_params[:from_score])
    @transaction = TransferStates::StateManager.perform(transaction_params)
    redirect_to wallet_path(wallet.id)
  rescue StandardError => e
    flash[:error] = e.message
    redirect_to transaction_params[:recipient_type].to_sym == :atm ? transaction_new_withdraw_path : new_transaction_path
  end

  def new_withdraw
    @recipient_type = :atm
    @to_wallets = Atm.all.map { |x| ["Atm number #{x.number}", x.number] }
    render :new
  end

  def index
    @transactions = Transaction.all
  end

  private

  def build_scores
    @from_wallets = current_user.wallets.map { |x| [x.number, x.number] }
    @to_wallets = @from_wallets
    @selected = params[:score]
    @selected_balance = Wallet.find_wallet_by_in_crypt(@selected)&.balance if @selected.present?
  end

  def transaction_params
    params.permit(:from_score, :to_score, :amount, :pin_code, :recipient_type)
  end
end
