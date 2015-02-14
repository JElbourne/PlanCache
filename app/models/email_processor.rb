class EmailProcessor
  def initialize(email)
    @email = email
  end

  def process
    Rails.logger.info "IT WORKS JUST FINE, LETS MOVE ON"
    token = nil
    @email.to.each do |address|
      Rails.logger.info address
      token = address[:host] == "plancache.com"|| address[:host] == "in.plancache.com" ? address[:token] : nil
    end
    
    Rails.logger.info token
    Rails.logger.info @email.attachments
    
    return if token == "1234" || token.nil? #TODO replace this with a query to valid tenant
    
    message = Message.new
    message.save
  end
  
end