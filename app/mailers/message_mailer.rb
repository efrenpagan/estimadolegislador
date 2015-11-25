class MessageMailer < ActionMailer::Base
  default from: "mensaje@atentamente.org"

  def send_message(message_params)
  	@message_params = message_params
    @contacts = Contact.find(@message_params['contact_ids'])
    mail(to: "roberto@devstud.io", subject: @message_params['subject'] )
  end
end
