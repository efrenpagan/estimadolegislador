class RepresentativesController < ApplicationController
	belongs_to :district
	belongs_to :legislator, dependent: :destroy

	enum type: [:district, :accumulation]
end
