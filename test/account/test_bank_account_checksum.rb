# encoding : utf-8
require 'helper'
require 'bgc/account'

module BGC::Account::Checksum
  describe BankAccount do
    subject        { BankAccount.new(type) }
    let(:type)     { :variant1 }
    let(:clearing) { '1323' }
    let(:account)  { '1610621' }
    let(:result)   { subject.valid?(clearing, account) }
    specify        { result.must_equal true }

    describe 'invalid input' do
      describe 'no type' do
        let(:type) { nil }
        specify    { result.must_equal false }
      end

      describe 'no clearing' do
        let(:clearing) { nil }
        specify        { result.must_equal false }
      end

      describe 'no account' do
        let(:account) { nil }
        specify       { result.must_equal false }
      end

      bad_accounts = %W{1610622 1610620 1000}
      bad_accounts.each do |account|
        describe "bad account: #{account}" do
          let(:account) { account }
          specify       { result.must_equal false }
        end
      end

      bad_clearings = %W{1322 1324 1000}
      bad_clearings.each do |clearing|
        describe "bad clearing: #{clearing}" do
          let(:account) { clearing }
          specify       { result.must_equal false }
        end
      end
    end
  end
end
