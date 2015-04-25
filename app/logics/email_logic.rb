module EmailLogic
  extend self

  def send_email_async(email_params)
    MailerWorker.create(email_params)
  end

  def create_email(email_params)
  	email_params = email_params.except(:from_name, :message) unless email_params[:is_public]
  	Email.create(email_params)
  end

  def create_short_url(email)
  	bitly = Bitly.client.shorten(URI::encode('http://'+ Global.config.domain +'/emails/'+ email.id))
  	email.update(short_url: bitly.short_url)
  end

end
