class Message < ActiveRecord::Base
	acts_as_paranoid

	has_many :recipients
	has_many :contacts, through: :recipients
	has_many :message_events, through: :recipients

	after_create :set_short_url
	after_create :set_text_version

	validates_with Message::FromNameValidator
	validates_with Message::EmailValidator
	validates_with Message::SubjectValidator
	validates_with Message::BodyHtmlValidator

	default_scope { order("created_at") }

	private

	def set_short_url
		update_attribute(:short_url, MessageLogic.generate_short_url(self.id))
	end

	def set_text_version
		update_attribute(:body_text, MessageLogic.html_to_text(self.body_html))
	end

end
