class PoliticianMailer < ActionMailer::Base
  default from: "mensaje@atentamente.org"

  def send_politician_email(email_params)
  	@email_params = email_params
    @politicians = Politician.find(@email_params['politician_ids'])
    mail(to: "roberto@devstud.io", subject: @email_params['subject'] )
  end
end
