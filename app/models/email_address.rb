class EmailAddress < ActiveRecord::Base
	validates :email, presence: true
	validates :contact_id, presence: true
	belongs_to :contact, polymorphic: true
end
