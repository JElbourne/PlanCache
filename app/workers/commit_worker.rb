class CommitWorker
  
  include Sidekiq::Worker
  sidekiq_options queue: "high"
  # sidekiq_options retry: false
  
  def perform(email, token)
    account = Account.find_by_key(token)
    return unless account
  
    user = account.user
    return unless user.email == email.from[:email]
    # TODO determine if from_email is allowed to use this account based on a query on Account Associates (need to create this)

    branch = account.branches.get_from_subject(email.subject)
    message = branch.messages.create_from_email(email, branch.id)
  end
  

end