class S3UploadWorker
  
  include Sidekiq::Worker
  sidekiq_options queue: "high"
  # sidekiq_options retry: false
  
  def perform(email, token)

  end
  

end