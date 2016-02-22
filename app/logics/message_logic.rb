module MessageLogic
  extend self

  def send_message(message)
    MailerWorker.create(message)
  end

  def generate_short_url(message)
  	Bitly.client.shorten(URI::encode(url(message))).short_url
  end

  def html_to_text(message)
    HtmlToPlainText.plain_text(message.body_html)
  end

  def meta_tags_data(message)
    {
      url: url(message),
      type: "article",
      title: message.subject,
      description: PragmaticSegmenter::Segmenter.new(text: message.body_text, language: 'es').segment.first(3).join(' ')
    }
  end

  private

  def url(message)
    Rails.application.routes.url_helpers.message_url(message, host: Global.config.domain)
  end

end
