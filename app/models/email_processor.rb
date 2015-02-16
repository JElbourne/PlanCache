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
    # serializedEmail = Marshal.dump(@email)
    # Rails.logger.info "\n\n\n#{serializedEmail}\n\n\n"
    #
    # deserializedEmail = Marshal.load(serializedEmail)
    # Rails.logger.info "\n\n\n#{deserializedEmail}\n\n\n"
    
    ## Send email to the correct worker, background task
    if token == "TODO_Feature"
    elsif token.nil?
      return #This seems to be an invalid email since it does not have a valid to:email
    else
      #Catch_all is the document uploading
      CommitWorker.perform_async(@Email, token)
    end
    
  end
  
end