# encoding: utf-8
require 'active_model'
require 'bgc/account'

module BGC::Account

  # PlusGirot (formerly PostGirot) is a Swedish money transaction
  # system, owned by Nordea
  #
  # http://sv.wikipedia.org/wiki/Plusgirot
  #
  # https://www-2.danskebank.com/Link/BOCMSIUK/$file/BO_CMSI_UK.pdf
  # http://www.privatgirot.se/Global/anvandarguide-priv/pgavi.pdf
  # http://www.samlogic.com/blogg/2012/11/kontroll-validering-av-
  # bankgironummer-och-plusgironummer/
  #
  # BGC has no information about the format, but some random sites
  # say its 2-8 digits.
  #
  # - Mod 10 checksum
  # - Should be 2-8 digits
  # - The numbers between 900 000 and 909 999 are reserved for chairity
  class Plusgiro

    include Base
    include Validations

    validates :account_number, length: { minimum: 2, maximum: 8 }
    validates :account_number, presence: true

    def is_fundraising?
      is_in_range? && not_revoked?
    end

    def lb_format
      "#{account_number}".rjust(16, '0')
    end

    def normalize
      "#{account_number[0...-1]}-#{account_number[-1]}"
    end

    private

    def not_revoked?
      !Data::RevokedFundraising.revoked_plusgiro?(account_number)
    end

    def is_in_range?
      fundraising_range.include?(account_number.to_i)
    end

    def fundraising_range
      900_000_0..909_999_9
    end

    def valid_checksum?
      check = Checksum::Plusgiro.new
      check.valid?(account_number)
    end
  end
end
