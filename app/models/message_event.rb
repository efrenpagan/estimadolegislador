class MessageEvent < ActiveRecord::Base
  belongs_to :recipient
  has_one :contact, through: :recipient
  has_one :message, through: :recipient

  attr_accessor :env
  validates_with MessageEvent::EventValidator
end
