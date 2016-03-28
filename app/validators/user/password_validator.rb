class User::PasswordValidator <  ActiveModel::Validator
  def validate(record)
    self.class.validate(record)
  end

  class << self
    def validate(record)
      record.errors.add(:password, "es requerida") if record.password.blank?
      record.errors.add(:password, "requiere entre #{Devise.password_length.to_s} caracteres") if (record.password.blank? || Devise.password_length.include?(record.password.length))
    end
  end

end
