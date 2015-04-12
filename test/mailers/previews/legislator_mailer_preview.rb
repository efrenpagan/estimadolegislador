# Preview all emails at http://localhost:3000/rails/mailers/legislator_mailer
class LegislatorMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/legislator_mailer/send_legislator_email
  def send_legislator_email
    LegislatorMailer.send_legislator_email
  end

end
