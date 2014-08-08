require 'rails_helper'

RSpec.describe EmailAddress, :type => :model do
	let(:email_address) do
    EmailAddress.new(email: "spock@example.com", contact_id: 1, contact_type: "Person")
  end

  it 'is valid' do
    expect(email_address).to be_valid
  end

  it 'is valid only with a contact_id' do
    email_address.contact_id = nil
    expect(email_address).not_to be_valid, "you need both email and contact_id"
  end

  it 'must have a reference to a contact' do
    email_address.contact_id = nil
    expect(email_address).to_not be_valid
  end

  it 'is associated with a contact' do
    expect(email_address).to respond_to(:contact)
  end
end
