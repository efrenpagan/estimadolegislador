class Message < ActiveRecord::Base
	has_many :recipients
	has_many :contacts, through: :recipients

	validate :message_fields

	after_create :set_short_url
	after_create :set_text_version

	default_scope { order("created_at") }

	private

	def message_fields
		errors.add(:from_name, 'invalid name') unless /\A[^0-9`!@#\$%\^&*+_=]+\z/.match(from_name)
		errors.add(:from_email, 'invalid email') unless /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/.match(from_email)
		errors.add(:subject, 'empty subject') unless subject.present?
		errors.add(:body_html, 'empty message') unless body_html.present?
	end

	def set_short_url
		update_attribute(:short_url, MessageLogic.generate_short_url(self.id))
	end

	def set_text_version
		update_attribute(:body_text, MessageLogic.html_to_text(self.body_html))
	end

end
