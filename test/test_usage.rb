# encoding: utf-8
require 'helper'
require 'bgc/account'

describe 'Example Usage' do
  describe 'Plusgiro' do
    let(:expected_output) do
      "8181000\n" +
      "0000000008181000\n" +
      "818100-0\n" +
      "false\n"
    end

    it 'print account info' do
      proc do
        account = BGC::Account::Plusgiro.new('818100-0')
        if account.valid?
          puts account.account_number
          puts account.lb_format
          puts account.normalize
          puts account.is_fundraising?
        end
      end.must_output expected_output
    end
  end
  describe 'Bankgiro' do
    let(:expected_output) do
      "6886444\n" +
      "0000000006886444\n" +
      "688-6444\n" +
      "false\n"
    end

    it 'print account info' do
      proc do
        account = BGC::Account::Bankgiro.new('688-64 44')
        if account.valid?
          puts account.account_number
          puts account.lb_format
          puts account.normalize
          puts account.is_fundraising?
        end
      end.must_output expected_output
    end
  end

  describe 'Bank Account' do
    let(:expected_output) do
      "83360\n" +
      "170882120\n" +
      "Swedbank\n" +
      "0083360170882120\n" +
      "83360-170882120\n"
    end

    it 'print account info' do
      proc do
        account = BGC::Account::BankAccount.new('8336-0', '17 088 212-0')
        if account.valid?
          puts account.clearing_number
          puts account.account_number
          puts account.bank_name
          puts account.lb_format
          puts account.normalize
        end
      end.must_output expected_output
    end
  end
end
