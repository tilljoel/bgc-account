# encoding: utf-8

module BGC::Account

  module Checksum
    module Base
      def mod_check11(number)
        return false unless number
        weights_array = [1, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1]
        digits = number.scan(/./).map(&:to_i)
        weights = weights_array[-digits.length..-1]
        weighted_array = weights.zip(digits).map do |weight, val|
          weight * val
        end
        rest = sum_array(weighted_array) % 11
        rest == 0
      end

      def mod_check10(number)
        return false unless number
        weights_array = [1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1]
        digits = number.scan(/./).map(&:to_i)
        weights = weights_array[-digits.length..-1]
        weighted_array = weights.zip(digits).map do |weight, val|
          digit_sum_if_two_digits(weight * val)
        end
        rest = weighted_array.reduce(0) { |a, e| a + e } % 10
        rest == 0
      end

      private

      def sum_array(arr)
        arr.reduce(0) { |a, e| a + e }
      end

      def digit_sum_if_two_digits(prod)
        if prod >= 10
          1 + (prod - 10)
        else
          prod
        end
      end
    end

    # For Variant1-2
    #
    # The account number consisst of a total of eleven digits - the
    # clearing number and the actual account number, including a check
    # digit ( C ) according to Modulus-11, using the weights 1, 10, 9,
    # 8, 7, 6, 5, 4, 3, 2, 1. For check sum calculation, please see the
    # Remarks.

    # Checksum calculation is made on the Clearing number with the
    # exception of the first digit, and seven digits of the actual account
    # number.
    class ChecksumVariant1
      include Base
      def valid?(clearing, account)
        account = account.rjust(7, '0')
        mod_check11("#{clearing[1..3]}#{account[-7..-1]}")
      end
    end

    # Checksum calculation is made on the entire Clearing number, and
    # seven digits of the actual account number.
    class ChecksumVariant2
      include Base
      def valid?(clearing, account)
        account = account.rjust(7, '0')
        mod_check11("#{clearing}#{account[-7..-1]}")
      end
    end

    # For Variant3-6
    #
    # The Clearing number is not part of the Bank Account number.
    # Significant digits in the Account Number Field are designatingumber
    # the Account Number

    # The account number consists of 10 digits. Checksum calculation uses
    # the 10 last digits in field 5 using the modulus 10 check.
    class ChecksumVariant3
      include Base
      def valid?(clearing, account)
        account = account.rjust(10, '0')
        mod_check10(account[-10..-1])
      end
    end

    # The account number consists of 9 digits. Checksum calculation uses
    # the 9 last digits in field 5 using the modulus 11 check.
    class ChecksumVariant4
      include Base
      def valid?(clearing, account)
        account = account.rjust(9, '0')
        mod_check11(account[-9..-1])
      end
    end

    # The account number consists of 10 digits. Checksum calculation uses
    # the last ten digits in field 5 using the modulus 10 check. However
    # in rare occasions some of Swedbank accounts cannot be valideted
    # by a checksum calculation.
    class ChecksumVariant5
      include Base
      def valid?(clearing, account)
        account = account.rjust(10, '0')
        mod_check10(account[-10..-1])
      end
    end

    # This is a variation on Variant5, but also do a checksum on the clearing
    # if there are five digits.
    #
    # XXX: Special case for Swedbank account with clearing 8000..8999
    class ChecksumVariant6
      include Base
      def valid?(clearing, account)
        account = account.rjust(10, '0')
        account_ok = mod_check10(account[-10..-1])
        clearing_ok = clearing.length == 5 ? mod_check10(clearing) : true
        clearing_ok && account_ok
      end
    end

    class ChecksumInvalid
      def valid?(clearing, account)
        false
      end
    end
  end
end
