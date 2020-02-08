require "rails_helper"

feature "As a logged in user" do
  feature "when I visit my dashboard" do
    scenario "I see a section for github and see five repos which link to the repo on github", :vcr do
      user = create(:user, github_token: ENV['GITHUB_TOKEN'])
      user_2 = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/dashboard'

      expect(page).to have_content("Github")
      expect(page).to have_css('.repositories', count: 5)
    end

    scenario "if user does not have token, 'Github' and repos do not display" do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit '/dashboard'
      expect(page).to_not have_content("Github")
      expect(page).not_to have_css('.repositories')
    end
  end
end
