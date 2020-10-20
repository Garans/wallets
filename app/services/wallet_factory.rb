# frozen_string_literal: true

class WalletFactory

  attr_reader :type

  def initialize(type)
    validate_keys(type)
    @type = type
  end

  def class_model
    validate_keys(type)

    build_class_name(type).constantize
  end

  def relation_name
    validate_keys(type)

    name(type)
  end

  protected

  def build_class_name(type)
    name(type).classify
  end

  def name(type)
    "#{type}_wallet"
  end

  def validate_keys(type)
    raise StandardError if %w[user team stock].exclude?(type)
  end
end
