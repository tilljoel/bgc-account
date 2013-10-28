# encoding : utf-8
require 'helper'
require 'bgc/account'

module BGC::Account
  describe Data::Banks do
    let(:bank_data) { Data::Banks.find_by_clearing(clearing) }
    let(:bank)      { BankAccount::Bank.new(bank_data) }

    describe 'invalid clearing' do
      [nil, '', 0, '0000', 'joel', 9999, '9999'].each do |clearing|
        let(:clearing) { clearing }
        specify { bank.must_be_instance_of BankAccount::Bank }
        specify { bank.valid?.must_equal false }
      end
    end

    describe 'valid clearing' do
      describe 'Avanza Bank AB' do
        %W{9550 9569 9551}.each do |clearing|
          describe "with clearing: #{clearing}" do
            let(:clearing) { clearing }
            specify { bank.valid?.must_equal         true }
            specify { bank.must_be_instance_of       BankAccount::Bank }
            specify { bank.name.must_equal           'Avanza Bank AB' }
            specify { bank.comment.must_include      'deltar endast i data' }
            specify { bank.type.must_equal           :variant2 }
            specify { bank.account_format.must_equal '00000xxxxxxC' }
            specify { bank.clearing_range.must_equal 9550..9569 }
            specify { bank.account_digits.must_equal 7 }
          end
        end
      end

      describe 'Swedbank' do
        %W{8000 8999 8500}.each do |clearing|
          describe "with clearing: #{clearing}" do
            let(:clearing) { clearing }
            specify { bank.valid?.must_equal         true }
            specify { bank.must_be_instance_of       BankAccount::Bank }
            specify { bank.name.must_equal           'Swedbank' }
            specify { bank.comment.must_include      'ingen kommentar' }
            specify { bank.type.must_equal           :variant6 }
            specify { bank.account_format.must_equal '00xxxxxxxxxC' }
            specify { bank.clearing_range.must_equal 8000..8999 }
            specify { bank.account_digits.must_equal 10 }
          end
        end
      end

      describe 'Handlesbanken' do
        %W{6000 6999 6500}.each do |clearing|
          describe "with clearing: #{clearing}" do
            let(:clearing) { clearing }
            specify { bank.valid?.must_equal         true }
            specify { bank.must_be_instance_of       BankAccount::Bank }
            specify { bank.name.must_equal           'Handelsbanken' }
            specify { bank.comment.must_include      'ingen kommentar' }
            specify { bank.type.must_equal           :variant4 }
            specify { bank.account_format.must_equal '000xxxxxxxxC' }
            specify { bank.clearing_range.must_equal 6000..6999 }
            specify { bank.account_digits.must_equal 9 }
          end
        end
      end
    end
  end
end
