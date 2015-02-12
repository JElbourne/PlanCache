require 'rails_helper'

describe "Welcome" do
  describe "GET / (root)" do
    it "visits the root path" do
      visit root_path
      expect(page).to have_text("Welcome")
    end
  end
end
