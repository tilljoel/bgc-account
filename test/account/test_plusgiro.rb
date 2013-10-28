# encoding: utf-8
require 'helper'
require 'bgc/account'

module BGC::Account

  describe Plusgiro do
    subject         { Plusgiro.new(plusgiro) }

    describe 'invalid input' do
      invalid_giro_numbers = %w{'00000001'
                                '1'
                                '00000000000'
                                '818100-3'
                                '222135-2'
                                '222358-1'}

      invalid_giro_numbers.each do |giro_number|
        describe "invalid #{giro_number}" do
          let(:plusgiro)  { giro_number }
          specify         { subject.valid?.must_equal false, subject }
        end
      end

      describe 'no giro_number' do
        let(:plusgiro) { nil }
        specify        { subject.valid?.must_equal false }
      end
    end

    describe 'valid input' do

      describe '#normalize' do
        let(:plusgiro) { '414 54 00-4' }
        specify        { subject.normalize.must_equal '4145400-4' }
      end

      describe '#normalize' do
        let(:plusgiro) { '81 81.00-0 ' }
        specify        { subject.normalize.must_equal '818100-0' }
      end

      describe '#lb_format' do
        let(:plusgiro) { '8181.00.0' }
        specify        { subject.lb_format.must_equal '0000000008181000' }
      end

      describe 'funraising' do
        let(:plusgiro) { '901232-9' }
        specify        { subject.is_fundraising?.must_equal true }
      end

      describe 'non-funraising' do
        let(:plusgiro) { '818100-0' }
        specify        { subject.is_fundraising?.must_equal false }
      end

      valid_giro_numbers = ['414 53 04-4',
                            '818100-0',
                            '222135-6',
                            '222358-4',
                            '4320011-2',
                            '4311811-6',
                            '476 51 01-3.',
                            '16 67 23 - 7',
                            '38 19 53 - 9',
                            '93 66- 006',
                            '480 04 03-0',
                            '484- 66 015']
      valid_giro_numbers.each do |giro_number|
        describe "valid #{giro_number}" do
          let(:plusgiro) { giro_number }
          specify        { subject.valid?.must_equal true, subject }
        end
      end
    end
  end
end
