require 'rails_helper'

RSpec.describe "email_addresses/index", :type => :view do
  before(:each) do
    assign(:email_addresses, [
      EmailAddress.create!(
        :email => "Email",
        :contact_id => 1,
        :contact_type => "MyString"
      ),
      EmailAddress.create!(
        :email => "Email",
        :contact_id => 1,
        :contact_type => "MyString"
      )
    ])
  end

  it "renders a list of email_addresses" do
    render
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
