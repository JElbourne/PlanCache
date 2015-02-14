class Message < ActiveRecord::Base
  
  def self.create_from_email(email)
    create do |m|
      m.email = email.from[:email]
      m.subject = email.subject if email.subject
      m.to = email.to if email.to
      m.from = email.from if email.from
      m. cc = email.cc if email.cc

      m.body = email.body if email.body
      m.raw_text = email.raw_text if email.raw_text
      m.raw_html = email.raw_html if email.raw_html
      m.raw_body = email.raw_body if email.raw_body
      m.raw_headers = email.raw_headers if email.raw_headers
      m.headers = email.headers if email.headers
    end
  end
end
