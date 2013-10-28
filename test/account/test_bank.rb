# encoding : utf-8
require 'helper'
require 'bgc/account'

module BGC::Account
  describe BankAccount::Bank do
    subject { BankAccount::Bank.new(opts) }

    describe 'invalid input' do
      let(:opts) { nil }
      specify    { subject.valid?.must_equal false }
    end

    describe 'valid input' do
      let(:opts) do
        {
          name:           'Handelsbanken',
          comment:        'ingen kommentar',
          clearing_range: 6000..6999,
          account_format: '000xxxxxxxxC',
          account_digits: 9,
          type:           :variant4,
        }
      end
      specify { subject.valid?.must_equal         true }
      specify { subject.must_be_instance_of       BankAccount::Bank }
      specify { subject.name.must_equal           'Handelsbanken' }
      specify { subject.comment.must_include      'ingen kommentar' }
      specify { subject.clearing_range.must_equal 6000..6999 }
      specify { subject.account_format.must_equal '000xxxxxxxxC' }
      specify { subject.account_digits.must_equal 9 }
      specify { subject.type.must_equal           :variant4 }
    end
  end
end
