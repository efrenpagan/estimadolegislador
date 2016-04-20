class Recipient < ActiveRecord::Base
	belongs_to :message
	belongs_to :contact
	has_many :message_events
end
