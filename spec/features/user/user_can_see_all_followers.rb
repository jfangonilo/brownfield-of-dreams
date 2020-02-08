require 'rails_helper'

feature 'As a logged in user, when I visit my dashboard' do
  scenario 'I can see a list of my followers', :vcr do
    user = create(:user, github_token: ENV['GITHUB_TOKEN'])

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/dashboard'

    expect(page).to have_css('.followers')
  end

  scenario "I can't see my followers if I'm not authenticated" do
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/dashboard'

    expect(page).to_not have_content("Followers")
    expect(page).not_to have_css('.followers')
  end
end