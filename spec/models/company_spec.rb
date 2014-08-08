require 'rails_helper'

RSpec.describe Company, :type => :model do
	let(:company) do
		Company.new(name: "junior devs" )
	end

	it 'is valid' do
		expect(company).to be_valid
	end

	it 'is valid only with a name' do
		company.name = nil
		expect(company).not_to be_valid
	end

	it 'has an array of phone numbers' do
		expect(company.phone_numbers).to eq([])
	end

	it "repsonds with its phone numbers after they're created" do
		phone_number = company.phone_numbers.build(number: "333-4444")
		expect(phone_number.number).to eq('333-4444')
	end

	it "responds with its created email addresses" do
		company.email_addresses.build(email: 'me@example.com')
		expect(company.email_addresses.map(&:email)).to eq(['me@example.com'])
	end
end
