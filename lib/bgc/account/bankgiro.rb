# encoding: utf-8
require 'active_model'
require 'bgc/account/base'
require 'bgc/account/validations'
require 'bgc/account/checksum/checksum'
require 'bgc/account/data/revoked_fundraising'

module BGC::Account

  # Bankgirot is a proprietary clearing system in Sweden used for
  # transactions such as bill payments. It is owned by Swedish banks.
  #
  # http://sv.wikipedia.org/wiki/Bankgirot
  #
  # - Mod 10 checksum
  # - 7 or 8 digits
  # - The numbers between 900-000x tand 904-999x are reserved for chairity
  class Bankgiro

    include Base
    include Validations

    validates :account_number, length: { minimum: 7, maximum: 8 }
    validates :account_number, presence: true

    def is_fundraising?
      is_in_range? && not_revoked?
    end

    def lb_format
      "#{account_number}".rjust(16, '0')
    end

    def normalize
      "#{account_number[0...-4]}-#{account_number[-4..-1]}"
    end

    private

    def not_revoked?
      !Data::RevokedFundraising.revoked_bankgiro?(account_number)
    end

    def is_in_range?
      fundraising_range.include?(account_number.to_i)
    end

    def fundraising_range
      900_000_0..904_999_9
    end

    def valid_checksum?
      check = Checksum::Bankgiro.new
      check.valid?(account_number)
    end
  end
end
