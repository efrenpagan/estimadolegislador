class Email < ActiveRecord::Base
	has_many :recipients
	has_many :politicians, through: :recipients

	validate :email_fields

	after_create :create_short_url
	after_create :create_text_version

	default_scope { order("created_at") }

	private

	def email_fields
		errors.add(:from_name, 'invalid name') unless /\A[^0-9`!@#\$%\^&*+_=]+\z/.match(from_name)
		errors.add(:from_email, 'invalid email') unless /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/.match(from_email)
		errors.add(:subject, 'empty subject') unless subject.present?
		errors.add(:message_html, 'empty message') unless message_html.present?
	end

	def create_short_url
		EmailLogic.create_short_url(self)
	end

	def create_text_version
		update_attribute(:message_text, EmailLogic.html_to_text(self.message_html))
	end

end
