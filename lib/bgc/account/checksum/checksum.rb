# encoding: utf-8

require_relative 'checksum_variants'

module BGC::Account

  # Mod 11 and mod 10 checksums are used depending on the account variant
  #
  # http://www.bgc.se/upload/Gemensamt/Trycksaker/Manualer/10-MODUL.pdf
  # http://www.bgc.se/upload/Gemensamt/Trycksaker/Manualer/11-MODUL.pdf
  # http://www.bgc.se/upload/Gemensamt/Trycksaker/Manualer/BG910.pdf
  #
  module Checksum

    class Plusgiro
      def valid?(account)
        return false unless account
        check = Checksum::ChecksumVariant3.new
        check.valid?(nil, account)
      end
    end

    class Bankgiro
      def valid?(account)
        return false unless account
        check = Checksum::ChecksumVariant3.new
        check.valid?(nil, account)
      end
    end

    class BankAccount
      attr_accessor :variant

      def initialize(variant)
        @variant = variant
      end

      def valid?(clearing, account)
        return false unless clearing && account
        @variant = 'invalid' if @variant.nil?
        klass_name = "Checksum#{@variant.to_s.capitalize}"
        check = Checksum.const_get(klass_name).new
        check.valid?(clearing, account)
      end
    end
  end
end
