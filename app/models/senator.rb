class Senator < ActiveRecord::Base
  belongs_to :district
  belongs_to :legislator
  enum category: [:district, :accumulation]
end
