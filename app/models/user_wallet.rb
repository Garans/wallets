class UserWallet < Wallet
  include Vault::EncryptedModel
  vault_attribute :number

  has_many :out_come_send_info, class_name: 'TransactionSendInfo', foreign_key: 'sender_id', as: :sender
  has_many :in_come_send_info, class_name: 'TransactionSendInfo', foreign_key: 'recipient_id', as: :recipient

  has_one :crypted_datum, as: :owner

end