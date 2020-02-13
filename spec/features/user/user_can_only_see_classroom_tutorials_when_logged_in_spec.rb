require 'rails_helper'

describe 'as a user' do
  xit "I cannot see tutorials marked with the label 'classroom' unless I am logged in" do
    tutorial_1 = create(:tutorial, title: "How to Tie Your Shoes", classroom: true)
    tutorial_2 = create(:tutorial, title: "How to Maintain Your Will to Live", classroom: true)
    tutorial_3 = create(:tutorial, title: "How to Make People Laugh as a Defense Mechanism", classroom: false)

    visit '/'

    expect(page).not_to have_content(tutorial_1.title)
    expect(page).not_to have_content(tutorial_2.title)
    expect(page).to have_content(tutorial_3.title)

    user = User.create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/'

    expect(page).to have_content(tutorial_1.title)
    expect(page).to have_content(tutorial_2.title)
    expect(page).to have_content(tutorial_3.title)
  end
end
