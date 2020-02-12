require 'rails_helper'

describe 'As a logged in user connected to github', :vcr do
  it 'I see a button to add friend next to followers who are also connected to github' do
    jomah = create(:user, github_token: ENV['GITHUB_TOKEN_2'])
    carl = create(:user, github_token: ENV['GITHUB_TOKEN'], github_id: 47065120)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(jomah)

    visit dashboard_path

    within(first(".followers")) do
      expect(page).not_to have_button("Add Friend")
    end

    within "#follower-#{carl.github_id}" do
      click_button "Add Friend"
    end

    friendship = Friendship.last
    expect(friendship.user_id).to eq(jomah.id)
    expect(friendship.friended_user_id).to eq(carl.id)
    
    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("#{carl.handle} is now your friend!")
  end
end
