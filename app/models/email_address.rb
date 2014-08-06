class EmailAddress < ActiveRecord::Base
	belongs_to :person
	validates :email, :person_id, presence: true
end
