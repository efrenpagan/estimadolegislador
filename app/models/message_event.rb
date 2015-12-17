class MessageEvent < ActiveRecord::Base
  belongs_to :recipient
end
