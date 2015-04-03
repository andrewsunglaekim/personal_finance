class Account < ActiveRecord::Base
  belongs_to :user
  has_many :transactions, dependent: :destroy

  def deposit amount
    self.transactions.create({transaction_type: "deposit", amount: amount})
  end

  def withdraw amount
    self.transactions.create({transaction_type: "withdraw", amount: amount})
  end

  def balance
    if self.transactions.size == 0
      0
    else
      deposit_amounts = self.transactions.select{|transaction| transaction.transaction_type == "deposit"}.map{|transaction| transaction.amount}.inject(:+).to_i
      withdraw_amounts = self.transactions.select{|transaction| transaction.transaction_type == "withdraw"}.map{|transaction| transaction.amount}.inject(:+).to_i
      deposit_amounts - withdraw_amounts
    end
  end

  def account_menu
    system("clear")
    puts "What would you like to do?"
    puts ("Account Name: #{self.name}".ljust(30) + "Balance: #{self.balance}")
    puts prompt_buffer
    puts "1) Make a deposit"
    puts "2) Make a withdrawal"
    puts "3) Log out"
    puts "4) Exit program"
    gets.chomp.to_i
  end
end
