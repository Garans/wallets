# frozen_string_literal: true

class WalletController < ApplicationController
  before_action :authenticate_user!
  before_action :wallet_set, only: %i[show edit update]

  def index
    @wallets = current_user.wallets.includes(:currency)
  end

  def show; end

  def edit; end

  def balance
    wallet = Wallet.find_wallet_by_in_crypt(params[:wallet_id])
    render json: { wallet: wallet.number, balance: wallet.balance, currency_sym: wallet.currency.symbol_icon }
  end

  def create
    @wallet = CreateScore.new(wallet_by_type.class_model.new, current_user, wallet_params).call
    redirect_to wallet_index_path
  rescue StandardError => e
    flash[:error] = e.message
    redirect_to new_wallet_path(wallet_type: params[:wallet_type])
  end

  def update
    @wallet = UpdateScore.perform(@wallet, wallet_params.merge(pin_new: wallet_new_pin[:pin_new]))
    redirect_to wallet_path(id: @wallet.id)
  rescue StandardError => e
    flash[:error] = e.message
    render :edit, status: 400
  end

  def new
    @currencies = Currency.all.pluck('id, id')
    @wallet = wallet_by_type.class_model.new
  end

  private

  def wallet_set
    @wallet = current_user.wallets.find(params[:id])
  end

  def wallet_by_type
    WalletFactory.new(params[:wallet_type])
  end

  def wallet_params
    params.require(wallet_by_type.relation_name).permit(:currency_id, :description, :pin)
  end

  def wallet_new_pin
    params.require(wallet_by_type.relation_name).permit(:pin_new)
  end
end
