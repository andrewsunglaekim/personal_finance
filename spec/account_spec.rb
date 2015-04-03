require_relative '../gems_required'
require_relative '../db/connection'
require_relative 'spec_helper'
require_relative '../lib/account'
require_relative '../lib/user'
require_relative '../lib/transaction'

# describe Account do
#
#   @checking_account = Account.first
#   @savings_account = Account.last
#   describe '.balance' do
#     it "should have a balance" do
#       expect(@checking_account.balance).to eq(-30)
#       expect(@savings_account.balance).to eq(-43)
#     end
#   end
# end

describe Account do
  subject(:checking) { Account.new(name: 'Checking') }

  describe '.balance' do
    it "should be a sum Deposit transactions" do
      checking.transactions.build(transaction_type: "deposit", amount: 10)
      checking.transactions.build(transaction_type: "deposit", amount: 30)
      expect(checking.balance).to eq(40)
    end

    it "should be a Withdraw debit transactions" do
      checking.transactions.build(transaction_type: "withdraw", amount: 20)
      checking.transactions.build(transaction_type: "withdraw", amount: 40)
      expect(checking.balance).to eq(-60)
    end

    # it "should be a sum Deposit & Withdraw transactions" do
    #   checking.transactions.build(transaction_type: "deposit", amount: 10)
    #   checking.transactions.build(transaction_type: "withdraw", amount: 20)
    #   expect(checking.balance).to eq(-10)
    # end
  end
end
