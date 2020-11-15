class Transfer
  # your code here
  attr_accessor :sender, :receiver, :amount, :status

  def initialize (sender, receiver, amount, status = "pending")
    @sender = sender
    @receiver = receiver
    @status = status
    @amount = amount
  end

  def valid?
    sender.valid? && receiver.valid? && sender.balance >= amount
  end

  def execute_transaction
    if valid? && status == "pending"
      if @sender.balance > amount
        @sender.withdraw(amount)
        @receiver.deposit(amount) 
        @status = "complete"
      else
        @status = "rejected"
        "Transaction rejected. Please check your account balance."
      end
    else
      @status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if @status == "complete"
      @sender.deposit(amount)
      @receiver.withdraw(amount)
      @status = "reversed"
    end
  end

end
