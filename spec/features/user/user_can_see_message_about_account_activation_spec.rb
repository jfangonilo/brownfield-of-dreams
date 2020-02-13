require 'rails_helper'

describe 'As a guest user' do
  describe 'when I register for an account and I am redirected to my dashboard page' do
    it "and I should see 'logged in as <some name>' and a message saying 'This account has not yet been activated. Please check your email.'" do
      email = 'jimbob@aol.com'
      first_name = 'Jim'
      last_name = 'Bob'
      password = 'password'
      password_confirmation = 'password'

      visit '/'

      click_on 'Register'

      expect(current_path).to eq(register_path)

      fill_in 'user[email]', with: email
      fill_in 'user[first_name]', with: first_name
      fill_in 'user[last_name]', with: last_name
      fill_in 'user[password]', with: password
      fill_in 'user[password_confirmation]', with: password

      click_on'Create Account'

      expect(current_path).to eq(dashboard_path)

      expect(page).to have_content("Logged in as #{first_name} #{last_name}")
      expect(page).to have_content("This account has not yet been activated.")
    end
  end
end


# Background: The registration process above will trigger this story
#
# As a non-activated user
# When I check my email for the registration email
# I should see a message that says "Visit here to activate your account."
# And when I click on that link
# Then I should be taken to a page that says "Thank you! Your account is now activated."
#
# And when I visit "/dashboard"
# Then I should see "Status: Active"
