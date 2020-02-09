require 'rails_helper'

describe 'oauth validation process', :vcr do
  it "displays a link to connect with github if user doesn't have a token" do
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/dashboard'

    expect(page).to have_link "Connect to GitHub"
  end

  it "connects me to my github account when I click the link" do
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/dashboard'
    expect(user.github_token).to be nil

    stub_oauth
    click_on "Connect to GitHub"

    expect(user.github_token).to eq stub_oauth[:credentials][:token]
  end

  it "doesn't have a link to connect to github if user already has token" do
    user = create(:user, github_token: ENV['GITHUB_TOKEN'])

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/dashboard'

    expect(page).not_to have_link "Connect to GitHub"
  end
end