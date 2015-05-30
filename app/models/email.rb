class Email < ActiveRecord::Base
	has_many :recipients
	has_many :politicians, through: :recipients
	accepts_nested_attributes_for :recipients

	validate :email_fields

	after_create :create_short_url

	default_scope { order("created_at") }

	private

	def email_fields
		errors.add(:from_name, 'invalid name') unless /\A[^0-9`!@#\$%\^&*+_=]+\z/.match(from_name)
		errors.add(:from_email, 'invalid email') unless /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/.match(from_email)
		errors.add(:subject, 'empty subject') unless subject.present?
		errors.add(:message, 'empty message') unless message.present?
	end

	def create_short_url
		EmailLogic.create_short_url(self)
	end

end
