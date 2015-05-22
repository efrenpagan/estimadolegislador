# Preview all emails at http://localhost:3000/rails/mailers/politician_mailer
class PoliticianMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/politician_mailer/send_politician_email
  def send_politician_email
    PoliticianMailer.send_politician_email
  end

end
