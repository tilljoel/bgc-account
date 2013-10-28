# encoding: utf-8

module BGC::Account
  module Base
    attr_reader :account_number

    def initialize(account_number = nil)
      self.account_number = account_number
    end

    def account_number=(account_number)
      @account_number = keep_digits(account_number)
    end

    def keep_digits(str)
      str.to_s.gsub(/[^0-9]/, '') if str
    end
  end
end
