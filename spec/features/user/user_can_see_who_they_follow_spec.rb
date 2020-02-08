require 'rails_helper'

describe 'As a logged in user, when I visit my dashboard' do
  scenario 'I can see a list of all who follow me', :vcr do
    user = create(:user, github_token: ENV['GITHUB_TOKEN'])

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/dashboard'

    expect(page).to have_css('.followings')
  end

  scenario "I can't see who I follow if I'm not authenticated" do
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/dashboard'

    expect(page).to_not have_content("Followings")
    expect(page).not_to have_css('.followings')
  end
end