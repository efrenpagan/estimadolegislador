module MessageLogic
  extend self

  def send_message(message_params)
    MailerWorker.create(message_params)
  end

  def create_short_url(message)
  	bitly = Bitly.client.shorten(URI::encode("http://#{Global.config.domain}/messages/#{message.id}"))
  	message.update(short_url: bitly.short_url)
  end

  def html_to_text(html)
    message = ""
    html_doc = Nokogiri::HTML(html)
    html_doc.traverse do |node|
      if node.name == "p" && node.text
        if node.text.blank?
          message += "\n"
        else
          message += "#{node.text}\n"
        end
      elsif node.name == "ol"
        i = 0
        node.traverse do |ol|
          if ol.text && ol.parent.name == "ol"
            i += 1
            message += "\t#{i}. #{ol.text}\n"
          end
        end
      elsif node.name == "ul"
        node.traverse do |ul|
          if ul.text && ul.parent.name == "ul"
            message += "\t* #{ul.text}\n"
          end
        end
      end
    end
    return message
  end

end
