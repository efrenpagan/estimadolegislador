require 'elasticsearch/model'

class Legislator < ActiveRecord::Base
	include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

	has_many :emails

	has_attached_file :image
	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

	validates :branch, inclusion: { in: %w[senate representative] }

	def representative?
		branch == 'representative'
	end

	def senator?
		branch == 'senate'
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

Legislator.__elasticsearch__.client.indices.delete index: Legislator.index_name rescue nil
 
Legislator.__elasticsearch__.client.indices.create \
  index: Legislator.index_name,
  body: { settings: Legislator.settings.to_hash, mappings: Legislator.mappings.to_hash }
 
Legislator.import