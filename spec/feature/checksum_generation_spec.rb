require "rails_helper"

RSpec.feature "Checksum generator", :type => :feature do
  scenario "Creating a checksum" do
    visit "/"
    expect(page).to have_title "Checksumgen" 
    fill_in 'checksum_text', with: 'foo bar baz wibble fizzbuzz fizz buzz'
    find('input[name="commit"]').click
    expect(page).to have_content '7-4-5-21-37'
  end
end