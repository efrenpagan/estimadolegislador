class Message::BodyHtmlValidator <  ActiveModel::Validator
  def validate(record)
    self.class.validate(record)
  end

  class << self
    def validate(record)
      return record.errors.add(:body_html, 'es requerido') unless record.body_html.present?
    end
  end

end
