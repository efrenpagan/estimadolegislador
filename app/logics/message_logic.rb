module MessageLogic
  extend self

  def send_message(message_params)
    MailerWorker.create(message_params)
  end

  def generate_short_url(message_id)
  	Bitly.client.shorten(URI::encode("http://#{Global.config.domain}/messages/#{message_id}")).short_url
  end

  def html_to_text(html)
    HtmlToPlainText.plain_text(html)
  end

end
