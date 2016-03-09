require 'elasticsearch/model'

class Message < ActiveRecord::Base
	include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

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

	def as_indexed_json(options = {})
	  self.as_json({
	    only: [:subject, :body_text]
	  })
	end

	settings index: {
		number_of_shards: 1,
		analysis: {
			analyzer: {
        default: {
					tokenizer: "standard",
					filter: ["standard", "lowercase", "asciifolding"]
				}
			}
		}
	} do
	  mappings dynamic: 'false' do
	    indexes :subject, analyzer: 'default'
			indexes :body_text, analyzer: 'default'
	  end
	end

	private

	def set_short_url
		update_attribute(:short_url, MessageLogic.generate_short_url(self))
	end

	def set_text_version
		update_attribute(:body_text, MessageLogic.html_to_text(self))
	end

end

Message.__elasticsearch__.client.indices.delete index: Message.index_name rescue nil

Message.__elasticsearch__.client.indices.create \
  index: Message.index_name,
  body: { settings: Message.settings.to_hash, mappings: Message.mappings.to_hash }

Message.__elasticsearch__.import
