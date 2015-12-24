class MessageEvent < ActiveRecord::Base
  belongs_to :recipient
  has_one :contact, through: :recipient
  has_one :message, through: :recipient
end
