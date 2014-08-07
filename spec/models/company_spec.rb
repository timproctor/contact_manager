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
end
