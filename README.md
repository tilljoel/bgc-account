[![Build Status](https://travis-ci.org/tilljoel/bgc-account.png?branch=master)](https://travis-ci.org/tilljoel/bgc-account)
[![Code Climate](https://codeclimate.com/github/tilljoel/bgc-account.png)](https://codeclimate.com/github/tilljoel/bgc-account)
# BGC::Account

Ruby Gem for Swedish account numbers.

* __Validate account checksum__
* __Normalize format__
* __Extract meta data from account number__

## Swedish Bank Accounts

[BGC, Bankgirocentralen](http://bgc.se) is the only clearing house in
Sweden and they control the payments infrastructure between Swedish
banks. Payments can be made to three different account types

* Bank Account
* Bankgiro
* Plusgiro (formerly Postgiro)

To protect against errors, all accounts has a simple checksum
using a weighted [Mod-10]
(http://www.bgc.se/upload/Gemensamt/Trycksaker/Manualer/10-MODUL.pdf)/[Mod-11](http://www.bgc.se/upload/Gemensamt/Trycksaker/Manualer/11-MODUL.pdf)
check digit. For some reason different banks decided to do the
checksum calculation on different subsets of the account number, which
makes it a little more complicated.

Some references used in the implementation

* [BGC - Mod 10](http://www.bgc.se/upload/Gemensamt/Trycksaker/Manualer/10-MODUL)
* [BGC - Mod 11 ](http://www.bgc.se/upload/Gemensamt/Trycksaker/Manualer/11-MODUL.pdf)
* [BGC - Check sum rules](http://www.bgc.se/upload/Gemensamt/Trycksaker/Manualer/BG910.pdf)
* [Bankgiro in swedish](http://sv.wikipedia.org/wiki/Bankgirot)
* [Plusgirot in swedish](http://sv.wikipedia.org/wiki/Plusgirot)
* [Danske bank - local swedish payments](https://www-2.danskebank.com/Link/BOCMSIUK/$file/BO_CMSI_UK.pdf)

# Installation

Add this line to your application's Gemfile:

```ruby
  gem 'bgc-account' # or add, :git => 'git://github.com/tilljoel/bgc-account.git'
```

And then execute:

```
  > bundle
```

Or install it yourself as:

```
  > gem install bgc-account
```

# Usage

### Bank Account

```ruby

# clearing and account number, everything except numbers are stripped
account = BGC::Account::BankAccount.new('8336-0', '17 088 212-0')

if account.valid?
  puts account.clearing_number # '83360'
  puts account.account_number  # '170882120'
  puts account.lb_format       # '0083360170882120'
  puts account.normalize       # '83360-170882120'
  puts account.bank_name       # 'Swedbank'
end

```

### Bankgiro

The Bankgiro number is not an account number, but an address that points to a
bank account. BGC helps with the routing to correct bank account.

```ruby

account = BGC::Account::Bankgiro.new('688-64 44')

if account.valid?
  puts account.account_number  # '6886444'
  puts account.lb_format       # '0000000006886444'
  puts account.normalize       # '688-6444'
  puts account.is_fundraising? # false (not correct serie or revoked license)
end

```

### Plusgiro

Plusgirot (formerly Postgirot) is a Swedish money transaction system developet
by the Swedish postal service, currently owned by Nordea. Plusgirot is
connected to BGC, enabling it to take deposits from other banks.

```ruby

account = BGC::Account::Plusgiro.new('818100-0')

if account.valid?
  puts account.account_number  # '8181000'
  puts account.lb_format       # '0000000008181000'
  puts account.normalize       # '818100-0'
  puts account.is_fundraising? # false (not correct serie or revoked license)
end

```

### Error handling

All classes use active_model validations and and support the usual methods

```ruby

account.valid?
account.invalid?
account.errors.any?
account.errors.added?(:account_number, :checksum)
account.errors.count
account.errors.messages

```

## BGC-related gems

I have some code for the BGC-LB and Swedbank-SUS format, it's a gem for
creating payment files for upload to your bank, probably will publish
them soon.

## Copyright

Copyright (c) 2012 Joel Larsson. See LICENSE for further details.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
