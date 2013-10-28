# encoding: utf-8
require 'helper'
require 'bgc/account'

module BGC::Account

  describe BankAccount do
    subject        { BankAccount.new(clearing, account) }
    let(:clearing) { '9150' }
    let(:account)  { '6849212' }
    specify        { subject.valid?.must_equal true }

    describe 'invalid input' do
      # XXX these accounts are not 'real' accounts,
      #     they reverse engineered and should fail
      invalid_accounts =\
        [
          { clearing: '0000',   account_number: '00000000' },
          { clearing: '8147-1', account_number: '1230' },
          { clearing: '9022',   account_number: '3318631' },
          { clearing: '5206',   account_number: '02 683 68' },
          { clearing: '6651',   account_number: '176183181' },
          { clearing: '3202',   account_number: '0169937' },
          { clearing: '9022',   account_number: '3768239' },
          { clearing: '8420-2', account_number: '104683715-9' },
          { clearing: '6226',   account_number: '238663193' },
          { clearing: '8103-4', account_number: '911 631 311-0' },
          { clearing: '5206',   account_number: '0281630' },
          { clearing: '6651',   account_number: '35117305' },
          { clearing: '8147-1', account_number: '994553393-1' },
          { clearing: '5287',   account_number: '04 563 46' },
          { clearing: '3300',   account_number: '7204139432' }
      ]

      invalid_accounts.each do |account|
        describe "invalid #{account}" do
          let(:clearing) { account[:clearing] }
          let(:account)  { account[:account_number] }
          specify        { subject.valid?.must_equal false, subject }
        end
      end

      describe 'no clearing' do
        let(:clearing) { nil }
        specify        { subject.valid?.must_equal false }
      end

      describe 'no account' do
        let(:account) { nil }
        specify       { subject.valid?.must_equal false }
      end
    end

    describe 'valid input' do
      # XXX these accounts are not 'real' accounts,
      #     they reverse engineered and should pass
      valid_accounts =\
        [
          { clearing: '1323',   account_number: '000001651913' },
          { clearing: '3300',   account_number: '8029011213' },
          { clearing: '3300',   account_number: '6706123814' },
          { clearing: '3300',   account_number: '9508183390' },
          { clearing: '3300',   account_number: '7104169136' },
          { clearing: '3300',   account_number: '8705189184' },
          { clearing: '3300',   account_number: '7411078269' },
          { clearing: '9300',   account_number: '002140752516' },
          { clearing: '7603',   account_number: '000000793535' },
          { clearing: '1323',   account_number: '000007612618' },
          { clearing: '2407',   account_number: '000000213848' },
          { clearing: '1323',   account_number: '000001651816' },
          { clearing: '1402',   account_number: '000003717037' },
          { clearing: '5383',   account_number: '000000195729' },
          { clearing: '4710',   account_number: '000000220749' },
          { clearing: '6752',   account_number: '000451237218' },
          { clearing: '5672',   account_number: '000000007211' },
          { clearing: '9150',   account_number: '000009967127' },
          { clearing: '1230',   account_number: '000000971712' },
          { clearing: '6600',   account_number: '459891839' },
          { clearing: '5267',   account_number: '0159869' },
          { clearing: '9020',   account_number: '6218984' },
          { clearing: '4235',   account_number: '0007215' },
          { clearing: '82701',  account_number: '0077511889' },
          { clearing: '8336-0', account_number: '17 088 212-0' },
          { clearing: '3214',   account_number: '0812018' },
          { clearing: '9150',   account_number: '6849212' },
          { clearing: '5267',   account_number: '0089917' },
          { clearing: '6846',   account_number: '778121879' },
          { clearing: '8147-1', account_number: '991910193-2' },
          { clearing: '6101',   account_number: '645628204' },
          { clearing: '1402',   account_number: '2767162' },
          { clearing: '6759',   account_number: '146812069' },
          { clearing: '5312',   account_number: '0016624' },
          { clearing: '6144',   account_number: '191061336' },
          { clearing: '9022',   account_number: '3318681' },
          { clearing: '5206',   account_number: '02 681 68' },
          { clearing: '6651',   account_number: '176189181' },
          { clearing: '3202',   account_number: '0169967' },
          { clearing: '9022',   account_number: '3768229' },
          { clearing: '8420-2', account_number: '104681715-9' },
          { clearing: '6226',   account_number: '238668193' },
          { clearing: '8103-4', account_number: '911 611 311-0' },
          { clearing: '5206',   account_number: '0281660' },
          { clearing: '6651',   account_number: '35117605' },
          { clearing: '8147-1', account_number: '994556393-1' },
          { clearing: '5287',   account_number: '04 566 46' },
          { clearing: '3300',   account_number: '7204169432' },
          { clearing: '3030',   account_number: '03 46662' },
          { clearing: '8166',   account_number: '19946666071' },
          { clearing: '8314-7', account_number: '3007766-3' },
          { clearing: '5406',   account_number: '00 276 34' },
          { clearing: '81059',  account_number: '9039656856' },
          { clearing: '8327-9', account_number: '147363055' },
          { clearing: '8214-9', account_number: '993036283-6' },
          { clearing: '82149',  account_number: '9838361484' },
          { clearing: '9022',   account_number: '1667611' },
          { clearing: '8032-5', account_number: '42336974' },
          { clearing: '6823',   account_number: '236466224' },
          { clearing: '8032-5', account_number: '31886724' },
          { clearing: '9300',   account_number: '431.861.736-4' }
        ]
      valid_accounts.each do |account|
        describe "valid #{account}" do
          let(:clearing) { account[:clearing] }
          let(:account)  { account[:account_number] }
          specify        { subject.valid?.must_equal true, subject }
        end
      end
    end
  end
end
