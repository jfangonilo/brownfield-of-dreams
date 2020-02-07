require "rails_helper"

feature "As a logged in user" do
  feature "when I visit my dashboard" do
    scenario "I see a section for github and see five repos which link to the repo on github", :vcr do
      user = create(:user, github_token: ENV['GITHUB_TOKEN'])
      user_2 = create(:user, github_token: ENV['GITHUB_TOKEN_2'])

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/dashboard'

      expect(page).to have_content("Github")
      expect(page).to have_link("battleship")
      expect(page).to have_link("activerecord-obstacle-course")
      expect(page).to have_link("adopt_dont_shop")
      expect(page).to have_link("adopt_dont_shop_paired")
      expect(page).to have_link("apartments_1908")
    end
  end
end
