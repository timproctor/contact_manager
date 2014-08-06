require 'rails_helper'
require 'capybara/rails'
require 'capybara/rspec'

describe 'the person view', type: :feature do
	
	let(:person) { Person.create(first_name: 'John', last_name: 'Doe') }
  
  describe 'the phone_numbers' do
		before(:each) do
			person.phone_numbers.create(number: "555-1234")
			person.phone_numbers.create(number: "555-5678")
			visit person_path(person)
		end

		it 'shows the phone numbers' do
			person.phone_numbers.each do |phone|
				expect(page).to have_content(phone.number)
			end
		end

		it 'has a link to add a new phone number' do
			expect(page).to have_link('Add phone number', href: new_phone_number_path(person_id: person.id))
		end

		it 'adds a new phone number' do
			page.click_link('Add phone number')
			page.fill_in('Number', with: '555-8888')
			page.click_button('Create Phone number')
			expect(current_path).to eq(person_path(person))
			expect(page).to have_content('555-8888')
		end

		it 'has links to edit phone numbers' do
			person.phone_numbers.each do |phone|
				expect(page).to have_link('edit', href: edit_phone_number_path(phone))
			end
		end

		it 'edits a phone number' do
			phone = person.phone_numbers.first
			old_number = phone.number

			first(:link, 'edit').click
			page.fill_in('Number', with: '555-9191')
			page.click_button('Update Phone number')
			expect(current_path).to eq(person_path(person))
			expect(page).to have_content('555-9191')
			expect(page).to_not have_content(old_number)
		end

		it 'deletes a phone number' do
			deleted = person.phone_numbers.first
			number = person.phone_numbers.last

			first(:link, 'delete').click
			expect(current_path).to eq(person_path(person))
			expect(page).to have_content(number.number)
			expect(page).to_not have_content(deleted.number)
		end
	end

	describe "how emails go" do
  	let(:person) { Person.create(first_name: 'Will', last_name: "Riker")}

  	before(:each) do
  		person.email_addresses.create(email: "some@example.com")
  		person.email_addresses.create(email: "other@example.com")
  		visit person_path(person)
  	end

  	it 'has an emails list' do
  		expect(page).to have_selector('li', text: person.email_addresses.first.email )
  	end
	end
end