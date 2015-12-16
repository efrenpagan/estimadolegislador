class Message::SubjectValidator <  ActiveModel::Validator
  def validate(record)
    self.class.validate(record)
  end

  class << self
    def validate(record)
      return record.errors.add(:subject, 'es requerido') unless record.subject.present?
    end
  end

end
