class Message::FromNameValidator <  ActiveModel::Validator
  def validate(record)
    self.class.validate(record)
  end

  class << self
    def validate(record)
      return record.errors.add(:from_name, 'es requerido') unless record.from_name.present?
      return record.errors.add(:from_name, 'no es válido') if (/\A[^0-9`!@#\$%\^&*+_=]+\z/ =~ record.from_name).nil?
    end
  end

end
