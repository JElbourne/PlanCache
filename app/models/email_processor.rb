class EmailProcessor
  def self.process(email)
    new(email).process
  end
  
  def process    
    message = Message.new
  end
  
end