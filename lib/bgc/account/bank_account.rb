# encoding: utf-8
require 'active_model'
require_relative 'checksum/checksum'
require_relative 'data/banks'
require_relative 'validations'
require_relative 'base'

module BGC::Account

  # Bank Account Numbers in Swedish banks consist of a clearing
  # number (4-5 digits) and the actual account number (6-13 digits)
  #
  # http://www.bgc.se/upload/Gemensamt/Trycksaker/Manualer/BG910.pdf
  #
  # The clearing number is used to look up the correct Bank, there are five
  # different variantions on how to perform the checksum calculation
  # depending on the bank. See the Data::Banks class for the lookup table.
  class BankAccount

    include Base
    include Validations

    validates :account_number, length: { minimum: 6, maximum: 13 }
    validates :account_number, presence: true
    validates :clearing_number, length: { minimum: 4, maximum: 5 }
    validates :clearing_number, presence: true
    validates :bank, presence: true

    attr_reader :clearing_number
    attr_accessor :bank

    def initialize(clearing_number = nil, account_number = nil)
      super(account_number)
      self.clearing_number = clearing_number
      bank_data = Data::Banks.find_by_clearing(four_digit_clearing)
      self.bank = Bank.new(bank_data)
    end

    def clearing_number=(clearing_number)
      @clearing_number = keep_digits(clearing_number) if clearing_number
    end

    def four_digit_clearing
      @clearing_number[0..3] if clearing_number
    end

    def bank_name
      bank.name if bank
    end

    def lb_format
      "#{clearing_number}#{account_number}".rjust(16, '0')
    end

    def normalize
      str = ''
      str += "#{clearing_number}-"
      str += "#{account_number}"
      str
    end

    private

    def valid_checksum?
      return false unless bank
      bank.checksum.valid?(clearing_number, account_number)
    end

    class Bank
      attr_accessor :name,
                    :clearing_range,
                    :clearing,
                    :comment,
                    :account_format,
                    :type,
                    :account_digits

      def initialize(opts)
        if opts
          @name = opts[:name]
          @comment = opts[:comment]
          @clearing_range = opts[:clearing_range]
          @account_format = opts[:account_format]
          @account_digits = opts[:account_digits]
          @type = opts[:type]
          @valid = true
        else
          @valid = false
        end
      end

      def checksum
        Checksum::BankAccount.new(type)
      end

      def valid?
        @valid
      end
    end
  end
end
