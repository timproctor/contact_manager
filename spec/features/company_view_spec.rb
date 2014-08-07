require 'rails_helper'
require 'capybara/rails'
require 'capybara/rspec'

describe 'the company view', type: :feature do
	
	let(:company) { Company.create(name: "we hire devs" ) }
  
  describe 'the phone_numbers' do
		before(:each) do
			company.phone_numbers.create(number: "555-1234")
			company.phone_numbers.create(number: "555-5678")
			visit company_path(company)
		end

		it 'shows the phone numbers' do
			company.phone_numbers.each do |phone|
				expect(page).to have_content(phone.number)
			end
		end

		it 'has a link to add a new phone number' do
			expect(page).to have_link('Add phone number', href: new_phone_number_path(contact_id: company.id, contact_type: "Company"))
		end

		it 'adds a new phone number' do
			page.click_link('Add phone number')
			page.fill_in('Number', with: '555-8888')
			page.click_button('Create Phone number')
			expect(current_path).to eq(company_path(company))
			expect(page).to have_content('555-8888')
		end

		it 'has links to edit phone numbers' do
			company.phone_numbers.each do |phone|
				expect(page).to have_link('edit', href: edit_phone_number_path(phone))
			end
		end

		it 'edits a phone number' do
			phone = company.phone_numbers.first
			old_number = phone.number

			first(:link, 'edit').click
			page.fill_in('Number', with: '555-9191')
			page.click_button('Update Phone number')
			expect(current_path).to eq(company_path(company))
			expect(page).to have_content('555-9191')
			expect(page).to_not have_content(old_number)
		end

		it 'deletes a phone number' do
			deleted = company.phone_numbers.first
			number = company.phone_numbers.last

			first(:link, 'delete').click
			expect(current_path).to eq(company_path(company))
			expect(page).to have_content(number.number)
			expect(page).to_not have_content(deleted.number)
		end
	end

	describe "how emails go" do
  	let(:company) { Company.create(name: "we hire j devs")}

  	before(:each) do
  		company.email_addresses.create(email: "data@example.com")
  		company.email_addresses.create(email: "other@example.com")
  		visit company_path(company)
  	end

  	it 'has an emails list' do
  		expect(page).to have_selector('li', text: company.email_addresses.first.email )
  	end

  	it 'has an add email address link' do
  		skip
  		expect(page).to have_link('Add email address', href: new_email_address_path(company_id: company.id))
  	end

  	it 'creates a new email address' do
  		skip
			page.click_link('Add email address')
			fill_in('Email', with: 'data@example.com')
			page.click_on('Create Email address')
			expect(current_path).to eq(company_path(company))
			expect(page).to have_content('data@example.com')
		end

		it 'edits an email address' do
			skip
			email = company.email_addresses.first
			old_number = email.email

			first(:link, 'edit').click
			page.fill_in('Email', with: 'data@example.com')
			page.click_button('Update Email address')
			expect(current_path).to eq(company_path(company))
			expect(page).to have_content('data@example.com')
		end

		it 'deletes email addresses' do
			skip
		  deleted = company.email_addresses.first
		  email = company.email_addresses.last

		  first(:link, 'delete').click
		  expect(current_path).to eq(company_path(company))
		  expect(page).to have_content(email.email)
		  expect(page).to_not have_content(deleted.email)
		end
	end
end