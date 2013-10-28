# encoding: utf-8
require 'helper'
require 'bgc/account'

module BGC::Account

  describe Bankgiro do
    subject { Bankgiro.new(bankgiro) }

    describe 'invalid input' do
      invalid_giro_numbers = ['00000001',
                              '000000000',
                              '00000',
                              '3318633',
                              '02 683 6']

      invalid_giro_numbers.each do |giro_number|
        describe "invalid #{giro_number}" do
          let(:bankgiro)  { giro_number }
          specify         { subject.valid?.must_equal false, subject }
        end
      end

      describe 'no giro_number' do
        let(:bankgiro) { nil }
        specify        { subject.valid?.must_equal false }
      end
    end

    describe 'valid input' do

      describe '#normalize' do
        let(:bankgiro) { '68-864-4 4' }
        specify        { subject.normalize.must_equal '688-6444' }
      end
      describe '#normalize' do
        let(:bankgiro) { '50 50-10 55 ' }
        specify        { subject.normalize.must_equal '5050-1055' }
      end
      describe '#lb_format' do
        let(:bankgiro) { '68-864-4 4' }
        specify        { subject.lb_format.must_equal '0000000006886444' }
      end
      describe '#is_fundraising?' do
        let(:bankgiro) { '900-8004' }
        specify        { subject.is_fundraising?.must_equal true }
      end

      describe '#is_fundraising?' do
        let(:bankgiro) { '688-6444' }
        specify        { subject.is_fundraising?.must_equal false }
      end

      describe '#is_fundraising?' do
        let(:bankgiro) { '9004920' }
        specify        { subject.is_fundraising?.must_equal false }
      end

      valid_giro_numbers = ['688-6444',
                            '900-8004',
                            '6886444',
                            '900 80 04',
                            '282-4639',
                            ' 282-46 47',
                            '5050-10 55 ',
                            '5055 - 2272',
                            '5055-2132',
                            '5055-20 90',
                            '5050.10 55']
      valid_giro_numbers.each do |giro_number|
        describe "valid #{giro_number}" do
          let(:bankgiro) { giro_number }
          specify        { subject.valid?.must_equal true, subject }
        end
      end
    end
  end
end
