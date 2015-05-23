require 'elasticsearch/model'

class Politician < ActiveRecord::Base
	include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

	has_many :emails

	has_attached_file :image
	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

	validates :position, inclusion: { in: %w[governor senator representative mayor] }

	def governor?
		position == 'governor'
	end

	def senator?
		position == 'senator'
	end

	def representative?
		position == 'representative'
	end

	def mayor?
		position == 'mayor'
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

Politician.__elasticsearch__.client.indices.delete index: Politician.index_name rescue nil
 
Politician.__elasticsearch__.client.indices.create \
  index: Politician.index_name,
  body: { settings: Politician.settings.to_hash, mappings: Politician.mappings.to_hash }
 
Politician.import