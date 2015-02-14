class EmailProcessor
  def initialize(email)
    @email = email
  end

  def process
    logger.info "IT WORKS JUST FINE, LETS MOVE ON"
  end
  
end