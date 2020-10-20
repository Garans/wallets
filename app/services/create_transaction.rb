# frozen_string_literal: true

class CreateTransaction
  attr_reader :params

  def self.perform(params)
    new(params).call
  end

  def initialize(params)
    @params = params
  end

  def call
    Transaction.transaction do
      @transaction = build_transaction
      @transaction.save!
      send_info = TransactionSendInfo.new(
        recipient_id: recipient_score.id, recipient_type: recipient_type,
        charge_transaction: @transaction
      )

      if from_score.present?
        send_info.sender_id = from_score.id
        send_info.sender_type = sender_type
      end

      send_info.save!

      @transaction
    end
  end

  protected

  def build_transaction
    builder do |t|
      t.sender(from_score)
      t.recipient(recipient_score)
      t.operation_type(params[:operation_type])
      t.currency
      t.currency_converters_info
      t.build_amount(amount)
      t.status(Transaction.transaction_statuses[:in_progress])
    end
  end

  def amount
    params[:amount].to_i
  end

  def from_score
    @from_score ||= Wallet.find_wallet_by_in_crypt(params[:from_score])
  end

  def recipient_score
    return @recipient_score if @recipient_score.present?

    @recipient_score = params[:recipient_type].to_s
                                              .classify
                                              .constantize.find_wallet_by_in_crypt(params[:to_score])
  end

  def sender_type
    from_score.type
  end

  def recipient_type
    params[:recipient_type] == :wallet ? recipient_score.type : params[:recipient_type].to_s.classify
  end

  def builder
    Builders::TransactionBuilder.build(params[:parent]) do |t|
      yield t
    end
  end
end
