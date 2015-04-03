require_relative "gems_required"
require_relative "db/connection"
require_relative "lib/account"
require_relative "lib/transaction"
require_relative "lib/user"
binding.pry
@current_user = nil

def clear
  system("clear")
end

def prompt_buffer
  "*" * 80
end

def get_user_input(message)
  puts message
  gets.chomp
end

def exit_message
  puts "Thank you for using personal finance"
end

system("clear")
while true
  if @current_user
    clear
    account_index_plus_one = @current_user.show_accounts
    if account_index_plus_one == "exit"
      exit_message
      break
    elsif account_index_plus_one.to_i == 0
      account_name = get_user_input("What would you like to call your account?")
      @current_user.accounts.create(name: account_name)
      clear
      account_index_plus_one = @current_user.show_accounts
    end

    @account = @current_user.accounts[account_index_plus_one.to_i - 1]
    clear
    account_choice = @account.account_menu
    case account_choice
    when 1
      deposit_amount = get_user_input("How much would you like to deposit?")
      @account.deposit(deposit_amount.to_i)
    when 2
      withdraw_amount = get_user_input("How much would you like to withdraw?")
      @account.withdraw(withdraw_amount.to_i)
    when 3
      @current_user = nil
    when 4
      break
    end

  else
    clear
    user_input = get_user_input("What would you like to do? Enter a letter:\n#{prompt_buffer}\n(L) - Login\n(S) - Signup\n(E) - Exit")
    if user_input.downcase == "l"
      clear
      user_name = get_user_input("Please enter your user name:")
      clear
      if User.all.select{|user| user.username == user_name}.count == 1
        password = get_user_input("Please enter your password")
        if User.all.find_by(username: user_name).authenticate(password)
          @current_user = User.all.find_by(username: user_name)
        else
          puts "incorrect password"
        end
      else
        puts "Could not find username"
      end
    elsif user_input.downcase == "s"
      puts "Sign Up!"
      clear
      new_user_name = get_user_input("What would you like your username to be?")
      new_password = get_user_input("What would you like your password to be?")
      User.create(username: new_user_name, password: new_password)
      @current_user = User.last
    elsif user_input.downcase == "e"
      exit_message
      break
    end
  end
end
