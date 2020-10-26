# frozen_string_literal: true

namespace :population do
  desc 'Generate free wallets'
  task generate_wallet_list: :environment do
    wallets = WalletAvailable.all.map(&:number).uniq
    Currency.all.each do |currency|
      s = ScoreGenerator.new(currency).call
      Atm.create!(currency: currency, address: 'Test address' + currency.id, number: IbanNumberGenerator.perform(SystemSetting.first, s, currency))
      1000.times do
        data = ScoreGenerator.new(currency)
        score = data.call
        score = data.call while wallets.include?(score)
        iban = IbanNumberGenerator.perform(SystemSetting.first, score, currency)
        wallets << iban
        WalletAvailable.create!(expire_date: Date.today + 4.year, number: iban, status: true, currency: currency)
      end
    end
  end
end
