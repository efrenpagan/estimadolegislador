class Message::EmailValidator <  ActiveModel::Validator
  def validate(record)
    self.class.validate(record)
  end

  class << self
    def validate(record)
      return record.errors.add(:from_email, 'es requerido') unless record.from_email.present?
      return record.errors.add(:from_email, 'no es válido') if (/\A[^@]+@([^@\.]+\.)+[^@\.]+\z/ =~ record.from_email).nil?
    end
  end

end
