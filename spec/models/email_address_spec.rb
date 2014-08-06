require 'rails_helper'

RSpec.describe EmailAddress, :type => :model do
	let(:email_address) do
     EmailAddress.new(email: "spock@example.com", person_id: 1)
   end

   it 'is valid' do
     email_address.person_id = nil
     expect(email_address).not_to be_valid, "you need both email and person_id"
   end

   it 'is valid only with a person_id' do
   		expect(email_address.person_id).to eq 1
   end
end
