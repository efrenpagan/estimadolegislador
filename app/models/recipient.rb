class Recipient < ActiveRecord::Base
	belongs_to :email
	belongs_to :politician
	accepts_nested_attributes_for :politician
end
