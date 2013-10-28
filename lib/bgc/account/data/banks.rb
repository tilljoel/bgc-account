# encoding : utf-8

# rubocop:disable MethodLength, ClassLength
module BGC::Account
  module Data
    class Banks

      # Inaccount_formation from bgc.se "Bank Account Numbers in Swedish"
      # The lookup table below translates like this
      #
      # http://www.bgc.se/upload/Gemensamt/Trycksaker/Manualer/BG910.pdf
      #
      # type1 + remark1 -> :variant1
      # type1 + remark2 -> :variant2
      # type2 + remark1 -> :variant3
      # type2 + remark2 -> :variant4
      # type2 + remark3 -> :variant5

      def self.find_by_clearing(clearing)
        @clearing = clearing.to_i
        found = bank_list.select do |bank|
          bank[:clearing_range].include?(@clearing)
        end
        found.first
      end

      def self.bank_list
        [
          { name:           'Avanza Bank AB',
            comment:        'deltar endast i dataclearing, ej i bankgiro',
            clearing_range: 9550..9569,
            account_format: '00000xxxxxxC',
            account_digits: 7,
            type:           :variant2 },

          { name:           'Citibank',
            comment:        'ingen kommentar',
            clearing_range: 9040..9049,
            account_format: '00000xxxxxxC',
            account_digits: 7,
            type:           :variant2 },

          { name:           'Danske Bank',
            comment:        'ingen kommentar',
            clearing_range: 1200..1399,
            account_format: '00000xxxxxxC',
            account_digits: 7,
            type:           :variant1 },

          { name:           'Danske Bank',
            comment:        'ingen kommentar',
            clearing_range: 2400..2499,
            account_format: '00000xxxxxxC',
            account_digits: 7,
            type:           :variant1 },

          { name:           'DnB NOR Bank',
            comment:        'ingen kommentar',
            clearing_range: 9190..9199,
            account_format: '00000xxxxxxC',
            account_digits: 7,
            type:           :variant2 },

          { name:           'DnB NOR Bank',
            comment:        'ingen kommentar',
            clearing_range: 9260..9269,
            account_format: '00000xxxxxxC',
            account_digits: 7,
            type:           :variant2 },

          { name:           'Forex Bank',
            comment:        'ingen kommentar',
            clearing_range: 9400..9449,
            account_format: '00000xxxxxxC',
            account_digits: 7,
            type:           :variant1 },

          { name:           'Fortis Bank S.A/NV Stockholm Branch',
            comment:        'ingen kommentar',
            clearing_range: 9470..9479,
            account_format: '00000xxxxxxC',
            account_digits: 7,
            type:           :variant2 },

          { name:           'GE Money Bank',
            comment:        'endast i dataclearingen, ej i bankgirosystemet',
            clearing_range: 9460..9469,
            account_format: '00000xxxxxxC',
            account_digits: 7,
            type:           :variant1 },

          { name:           'ICA Banken AB',
            comment:        'ingen kommentar',
            clearing_range: 9270..9279,
            account_format: '00000xxxxxxC',
            account_digits: 7,
            type:           :variant1 },

          { name:           'IKANO Bank',
            comment:        'ingen kommentar',
            clearing_range: 9170..9179,
            account_format: '00000xxxxxxC',
            account_digits: 7,
            type:           :variant1 },

          { name:           'Länsförsäkringar Bank',
            comment:        'ingen kommentar',
            clearing_range: 3400..3409,
            account_format: '00000xxxxxxC',
            account_digits: 7,
            type:           :variant1 },

          { name:           'Länsförsäkringar Bank',
            comment:        'ingen kommentar',
            clearing_range: 9020..9029,
            account_format: '00000xxxxxxC',
            account_digits: 7,
            type:           :variant2 },

          { name:           'Länsförsäkringar Bank',
            comment:        'ingen kommentar',
            clearing_range: 9060..9069,
            account_format: '00000xxxxxxC',
            account_digits: 7,
            type:           :variant1 },

          { name:           'Nordea',
            comment:        'exkl 10-siffriga personkonton',
            clearing_range: 1100..1199,
            account_format: '00000xxxxxxC',
            account_digits: 7,
            type:           :variant1 },

          { name:           'Nordea',
            comment:        'exkl 10-siffriga personkonton',
            clearing_range: 1400..2099,
            account_format: '00000xxxxxxC',
            account_digits: 7,
            type:           :variant1 },

          { name:           'Nordea',
            comment:        'exkl 10-siffriga personkonton',
            clearing_range: 3000..3299,
            account_format: '00000xxxxxxC',
            account_digits: 7,
            type:           :variant1 },

          { name:           'Nordea',
            comment:        'exkl 10-siffriga personkonton',
            clearing_range: 3301..3399,
            account_format: '00000xxxxxxC',
            account_digits: 7,
            type:           :variant1 },

          { name:           'Nordea',
            comment:        'exkl. personkonton',
            clearing_range: 3410..3781,
            account_format: '00000xxxxxxC',
            account_digits: 7,
            type:           :variant1 },

          { name:           'Nordea',
            comment:        'exkl. personkonton',
            clearing_range: 3783..3999,
            account_format: '00000xxxxxxC',
            account_digits: 7,
            type:           :variant1 },

          { name:           'Nordea',
            comment:        'exkl 10-siffriga personkonton',
            clearing_range: 4000..4999,
            account_format: '00000xxxxxxC',
            account_digits: 7,
            type:           :variant2 },

          { name:           'Nordnet Bank',
            comment:        'ingen kommentar',
            clearing_range: 9100..9109,
            account_format: '00000xxxxxxC',
            account_digits: 7,
            type:           :variant2 },

          { name:           'Resurs Bank',
            comment:        'ingen kommentar',
            clearing_range: 9280..9289,
            account_format: '00000xxxxxxC',
            account_digits: 7,
            type:           :variant1 },

          { name:           'Royal bank of Scotland',
            comment:        'ingen kommentar',
            clearing_range: 9090..9099,
            account_format: '00000xxxxxxC',
            account_digits: 7,
            type:           :variant2 },

          { name:           'SBAB',
            comment:        'ingen kommentar',
            clearing_range: 9250..9259,
            account_format: '00000xxxxxxC',
            account_digits: 7,
            type:           :variant1 },

          { name:           'SEB',
            comment:        'ingen kommentar',
            clearing_range: 5000..5999,
            account_format: '00000xxxxxxC',
            account_digits: 7,
            type:           :variant1 },

          { name:           'SEB',
            comment:        'ingen kommentar',
            clearing_range: 9120..9124,
            account_format: '00000xxxxxxC',
            account_digits: 7,
            type:           :variant1 },

          { name:           'SEB',
            comment:        'ingen kommentar',
            clearing_range: 9130..9149,
            account_format: '00000xxxxxxC',
            account_digits: 7,
            type:           :variant1 },

          { name:           'Skandiabanken',
            comment:        'ingen kommentar',
            clearing_range: 9150..9169,
            account_format: '00000xxxxxxC',
            account_digits: 7,
            type:           :variant2 },

          { name:           'Swedbank',
            comment:        'ingen kommentar',
            clearing_range: 7000..7999,
            account_format: '00000xxxxxxC',
            account_digits: 7,
            type:           :variant1 },

          { name:           'Ålandsbanken Sverige AB',
            comment:        'ingen kommentar',
            clearing_range: 2300..2399,
            account_format: '00000xxxxxxC',
            account_digits: 7,
            type:           :variant2 },

          { name:           'Danske Bank',
            comment:        'ingen kommentar',
            clearing_range: 9180..9189,
            account_format: '00xxxxxxxxxC',
            account_digits: 10,
            type:           :variant3 },

          { name:           'Handelsbanken',
            comment:        'ingen kommentar',
            clearing_range: 6000..6999,
            account_format: '000xxxxxxxxC',
            account_digits: 9,
            type:           :variant4 },

          { name:           'Nordea /Plusgirot',
            comment:        'ingen kommentar',
            clearing_range: 9500..9549,
            account_format: '00xxxxxxxxxC',
            account_digits: 10,
            type:           :variant5 },

          { name:           'Nordea /Plusgirot',
            comment:        'ingen kommentar',
            clearing_range: 9960..9969,
            account_format: '00xxxxxxxxxC',
            account_digits: 10,
            type:           :variant5 },

          { name:           'Nordea - personkonto',
            comment:        'ingen kommentar',
            clearing_range: 3300..3300,
            account_format: '00xxxxxxxxxC',
            account_digits: 10,
            type:           :variant3 },

          { name:           'Nordea - personkonto',
            comment:        'ingen kommentar',
            clearing_range: 3782..3782,
            account_format: '00xxxxxxxxxC',
            account_digits: 10,
            type:           :variant3 },

          { name:           'Sparbanken Öresund AB',
            comment:        'fd Spb Finn, fd Spb Gripen',
            clearing_range: 9330..9349,
            account_format: '00xxxxxxxxxC',
            account_digits: 10,
            type:           :variant3 },

          { name:           'Sparbanken Öresund AB',
            comment:        'fd Spb Finn, fd Spb Gripen',
            clearing_range: 9300..9329,
            account_format: '00xxxxxxxxxC',
            account_digits: 10,
            type:           :variant3 },

          { name:           'Sparbanken Syd',
            comment:        'ingen kommentar',
            clearing_range: 9570..9579,
            account_format: '00xxxxxxxxxC',
            account_digits: 10,
            type:           :variant3 },

          { name:           'Swedbank',
            comment:        'ingen kommentar',
            clearing_range: 8000..8999,
            account_format: '00xxxxxxxxxC',
            account_digits: 10,
            type:           :variant6 },
        ]
      end
    end
  end
end
# rubocop:enable MethodLength, ClassLength
