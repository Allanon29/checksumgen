require "rails_helper"

describe "home/index" do

  before(:each) do 
    render
  end

  it "displays all the headline" do
    expect(rendered).to match /Checksummer/
  end

  it "has a textarea to input checksum text" do
    expect(rendered).to have_selector(:id, 'checksum_text')
  end

  it "has a textarea to input checksum text" do
    expect(rendered).to have_selector("input[type='submit']")
  end

end