class LegislatorMailer < ActionMailer::Base
  default from: "mensaje@estimadolegislador.com"

  def send_legislator_email(email_params)
  	@email_params = email_params
    @legislator = Legislator.find(@email_params['legislator_id'])
    mail(to: "roberto@devstud.io", subject: @email_params['subject'] )
  end
end
