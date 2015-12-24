class MessageEvent::EventValidator <  ActiveModel::Validator
  def validate(record)
    self.class.validate(record)
  end

  class << self
    def validate(record)
      return record.errors.add(:recipient_id, 'es requerido') unless record.recipient_id.present?
      return record.errors.add(:event, 'es requerido') unless record.event.present?
      return record.errors.add(:env, 'no compatible') unless record.env == Rails.env
    end
  end

end
