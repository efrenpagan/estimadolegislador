module Legislator::FilterLogic
	extend self

	def search query
		Legislator.search(query).records
	end
end