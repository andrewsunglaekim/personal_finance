require_relative "../gems_required"
require_relative "connection"
require_relative "../lib/user"
require_relative "../lib/account"
require_relative "../lib/transaction"

User.destroy_all
User.create([
  {username: "andy", password: "password"}
])
User.first.accounts.create([
  {name: "checking"},
  {name: "savings"}
])

User.first.accounts[0].transactions.create([
  {transaction_type: "deposit", amount: 30},
  {transaction_type: "deposit", amount: 15},
  {transaction_type: "deposit", amount: 30},
  {transaction_type: "withdraw", amount: 45},
  {transaction_type: "withdraw", amount: 30},
  {transaction_type: "withdraw", amount: 30}
  ])

User.first.accounts[1].transactions.create([
  {transaction_type: "deposit", amount: 45},
  {transaction_type: "deposit", amount: 15},
  {transaction_type: "deposit", amount: 2},
  {transaction_type: "withdraw", amount: 22},
  {transaction_type: "withdraw", amount: 30},
  {transaction_type: "withdraw", amount: 53}
])
