class CommitService
  
  def initialize(email, token)
    @email = email
    @token = token
  end
  
  def commit_inbound_email_to_cache
    #Rails.logger.debug "\n\nEmail Object => #{@email}\n\n"
    account = Account.find_by_key(@token)
    return unless sender_authorized? account

    branch = account.branches.get_from_subject(@email.subject)
    message = branch.messages.create_from_email(@email, branch.id)
  end
  
  def sender_authorized?(account)
    user = account ? account.user : nil
    return user ? user.email == @email.from[:email] : false
    # TODO determine if from_email is allowed to use this account based on a query on Account Associates (need to create this)
  end
end