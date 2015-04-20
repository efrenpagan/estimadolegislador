class Email < ActiveRecord::Base
	belongs_to :legislator
	validate :email_fields
	validates_presence_of :legislator

	private

	def email_fields
		errors.add(:from_name, 'invalid name') unless /\A[^0-9`!@#\$%\^&*+_=]+\z/.match(from_name)
		errors.add(:from_email, 'invalid email') unless /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/.match(from_email)
		errors.add(:subject, 'empty subject') unless subject.present?
		errors.add(:message, 'empty message') unless message.present?
	end

end