class Legislator < ActiveRecord::Base
	has_one :representative
	has_one :senator
	enum role: [:representative, :senator]
end
