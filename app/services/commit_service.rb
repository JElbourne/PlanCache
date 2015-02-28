class CommitService
  
  def initialize(email, token)
    @email = email
    @token = token
  end
  
  def commit_inbound_email_to_message
    #Rails.logger.debug "\n\nEmail Object => #{@email}\n\n"
    account = Account.find_by_key(@token)
    user = account ? account.user : nil
    return unless sender_authorized? user

    branch = account.branches.get_from_subject(@email.subject, user.id, account.id)
    message = branch.messages.create_from_email(@email, branch.id, user.id, account.id)
    
    # TODO check if email has attachments then run a method to create the cache and save files to S3
  end
  
  def sender_authorized?(user)
    return user ? user.email == @email.from[:email] : false
    # TODO determine if from_email is allowed to use this account based on a query on Account Associates (need to create this)
  end
end