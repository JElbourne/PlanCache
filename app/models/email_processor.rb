class EmailProcessor
  def initialize(email)
    @email = email
  end

  def process
    # Rails.logger.info "IT WORKS JUST FINE, LETS MOVE ON"
    token = nil
    @email.to.each do |address|
      Rails.logger.info address
      token = address[:host] == "plancache.com"|| address[:host] == "in.plancache.com" ? address[:token] : nil
    end
    
    Rails.logger.info "\n\n\n#{token}\n\n\n"

    account = Account.find_by_key(token)
    return unless account
    
    user = account.user

    Rails.logger.info "\n\n\n#{user.email} - #{@email.from[:email]}\n\n\n"
    return unless user.email == @email.from[:email]
    # TODO determine if from_email is allowed to use this account based on a query on Account Associates (need to create this)
    
    branch = account.branches.get_from_subject(@email.subject)
    message = branch.messages.create_from_email(@email, branch.id)
  end
  
end