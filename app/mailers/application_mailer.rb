class ApplicationMailer < ActionMailer::Base
  default from: 'no_reply@brownfield.io'
  layout 'mailer'
end
