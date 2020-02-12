require 'rails_helper'

describe 'As a logged in user connected to github' do
  it 'I see a button to add friend next to followers who are also connected to github' do
    VCR.use_cassette('I_see_a_button_to_add_friend_next_to_followers_who_are_also_connected_to_github', allow_playback_repeats: true) do
      jomah = create(:user, github_token: ENV['GITHUB_TOKEN_2'])
      carl = create(:user, github_token: ENV['GITHUB_TOKEN'], github_id: ENV['GITHUB_ID'])
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

      jomah.reload
      expect(page).to have_content("#{carl.first_name} is now your friend!")
    end
  end
end
