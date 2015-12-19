require 'elasticsearch/model'

class Contact < ActiveRecord::Base
	include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

	has_many :recipients
	has_many :messages, through: :recipients
	has_many :message_events, through: :recipients

	has_attached_file :image
	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

	POSITION_TYPES = %w[governor senator representative mayor]

	validates :position_type, inclusion: { in: POSITION_TYPES }

	def governor?
		position_type == 'governor'
	end

	def senator?
		position_type == 'senator'
	end

	def representative?
		position_type == 'representative'
	end

	def mayor?
		position_type == 'mayor'
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
	    indexes :name, analyzer: 'default'
	  end
	end

end

Contact.__elasticsearch__.client.indices.delete index: Contact.index_name rescue nil

Contact.__elasticsearch__.client.indices.create \
  index: Contact.index_name,
  body: { settings: Contact.settings.to_hash, mappings: Contact.mappings.to_hash }

Contact.__elasticsearch__.import
