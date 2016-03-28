class Message::EmailValidator <  ActiveModel::Validator
  def validate(record)
    self.class.validate(record)
  end

  class << self
    def validate(record)
      return record.errors.add(:from_email, 'es requerido') if record.from_email.blank?
      return record.errors.add(:from_email, 'no es válido') if (Devise.email_regexp =~ record.from_email).nil?
    end
  end

end
