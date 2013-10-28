# encoding : utf-8

# rubocop:disable MethodLength, ClassLength
module BGC::Account::Data

  # Record with all fundraising(90-accounts)
  # http://www.90-konto.se/90konto
  class RevokedFundraising

    def self.revoked_bankgiro?(account_number)
      bankgiro_list.include?(account_number.to_s)
    end

    def self.revoked_plusgiro?(account_number)
      plusgiro_list.include?(account_number.to_s)
    end

    def self.bankgiro_list
      %W{
        9010133
        9004920
        9009473
        9007634
        9008939
        9003120
        9000233
        9001199
        9001140
        9049917
        9049974
        9001355
        9001224
        9000449
        9002585
        9001900
        9002148
        9001405
        9015025
        9001496
        9001488
        9007386
        9002692
        9003096
        9015306
        9002544
      }
    end

    def self.plusgiro_list
      %{
        9004318
        9011339
        9009473
        9000084
        9000803
        9010729
        9002312
        9017021
        9007634
        9019118
        9004920
        9010133
        9018029
        9008350
        9007006
        9008939
        9000407
        9007246
        9003575
        9000696
        9003120
        9003617
        9000233
        9001199
        9001140
        9008350
        9008368
        9011008
        9000274
        9001355
        9001272
        9000449
        9004276
        9002585
        9001900
        9002148
        9001405
        9000860
        9015025
        9001496
        9001488
        9007386
        9008848
        9002544
        9005463
        9002692
        9003096
        9000431
        9004557
        9015306
        9002379
        9003732
        9009317
        9003807
        9008384
        9011370
        9011297
        9007543
        900528
      }
    end
  end
end
# rubocop:enable MethodLength, ClassLength
