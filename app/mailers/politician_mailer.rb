class PoliticianMailer < ActionMailer::Base
  default from: "mensaje@estimadolegislador.com"

  def send_politician_email(email_params)
  	@email_params = email_params
    @politician = Politician.find(@email_params['politician_id'])
    mail(to: "roberto@devstud.io", subject: @email_params['subject'] )
  end
end
