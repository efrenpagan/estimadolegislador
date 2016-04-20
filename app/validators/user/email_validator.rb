class User::EmailValidator <  ActiveModel::Validator
  def validate(record)
    self.class.validate(record)
  end

  class << self
    def validate(record)
      record.errors.add(:email, "es requerido") if record.email.blank?
      record.errors.add(:email, "no es válido") if (Devise.email_regexp =~ record.email).nil?
      record.errors.add(:email, "ya existe") if User.find_by_email(record.email)
    end
  end

end
