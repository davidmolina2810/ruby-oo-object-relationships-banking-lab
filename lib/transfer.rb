class Transfer
  # your code here
  attr_reader :sender, :receiver
  attr_accessor :status, :amount

  def initialize(sender, receiver, amt)
    @sender = sender
    @receiver = receiver
    @amount = amt
    @status = 'pending'
  end

  def valid?
    self.sender.valid? && self.receiver.valid?
  end

  def execute_transaction
    if self.status == 'pending' && valid? && self.sender.balance > self.amount # execute only if transfer hasn't happened, 
                                                                                # both sender/receiver are valid accts, and the sender.balance > amount being sent
      self.sender.balance -= self.amount # subtract amount from sender balance
      self.receiver.balance += self.amount # add amount to receiver balance
      self.status = 'complete'
    else
      self.status = 'rejected'
      return "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if self.status == 'complete' # only reverse transfers that have been completed
      self.receiver.balance -= self.amount # retrieve amount from receiever account
      self.sender.balance += self.amount # restore sender account balance to pre-transfer

      self.status = 'reversed'
    end
  end
end
