class User < ActiveRecord::Base
  has_many :accounts, dependent: :destroy
  has_many :transactions, through: :accounts
  has_secure_password

  def show_accounts
    puts "Hello #{self.username}"
    puts prompt_buffer
    puts "Which bank account would you like to view? Please enter a number"
    puts "\n" * 3
    puts "Index".ljust(20) + "Account Name".ljust(30) + "Account Balance".ljust(20)
    puts prompt_buffer
    self.accounts.each_with_index do |account, i|
      puts "#{((i+1).to_s + ')').ljust(20)}#{(account.name).ljust(30)}#{(account.balance.to_s).ljust(30)}"
    end
    puts prompt_buffer
    puts "If you would like to add an account, enter 0"
    puts "If you would like to exit the program, enter exit"
    gets.chomp
  end
end
