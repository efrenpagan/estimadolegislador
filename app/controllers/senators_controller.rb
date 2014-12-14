class SenatorsController < ApplicationController
	belongs_to :district
	belongs_to :legislator

	enum type: [:district, :accumulation]
end
