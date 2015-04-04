class Legislator < ActiveRecord::Base
	has_attached_file :image
	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

	validates :branch, inclusion: { in: %w[senate representative] }
end
