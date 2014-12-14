class LegislatorsController < ApplicationController
	has_one :representantive
	has_one :senator
	enum role: [:representantive , :senator]

	after_destroy :destroy_dependencies

	private
	def destroy_dependencies
		
	end
end
