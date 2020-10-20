# frozen_string_literal: true

class Currency < ApplicationRecord
  has_many :wallets
end
