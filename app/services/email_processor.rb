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
      break if token
    end
    
    ## Send email to the correct worker, background task
    if token == "TODO_Feature"
      ## TODO
    elsif token.nil?
      return #This seems to be an invalid email since it does not have a valid to:email
    else
      #Catch_all is the document uploading
      CommitService.new(@email, token).commit_inbound_email_to_message
    end
    
  end
  
end