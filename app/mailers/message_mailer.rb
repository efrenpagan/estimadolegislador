class MessageMailer < ActionMailer::Base
  default from: "mensaje@atentamente.org"

  def self.send_message(message)
    message.contacts.each do |contact|
      individual_message(message, contact).deliver_now
    end
  end

  def individual_message(message, contact)
    @contact = contact
    @message = message
    headers['X-SMTPAPI'] = { unique_args: { recipient_id: @message.recipients.where(contact_id: contact.id).take!.id, env: Rails.env } }.to_json
    mail(to: @contact.email, subject: @message.subject)
  end
end
