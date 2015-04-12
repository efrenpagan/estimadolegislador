class LegislatorMailer < ActionMailer::Base
  default from: "mensaje@estimadolegislador.com"

  def send_legislator_email(email)
  	@email = email
    @legislator = @email.legislator

    mail(to: "roberto@devstud.io", subject: @email.subject )
  end
end
