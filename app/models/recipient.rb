class Recipient < ActiveRecord::Base
	belongs_to :email
	belongs_to :politician
end
