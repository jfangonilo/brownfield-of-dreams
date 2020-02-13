require 'rails_helper'

describe GithubUser do
  before(:each) do
    @attributes = {
      login: "jfangonilo",
      html_url: "https://github.com/jfangonilo",
      id: 56
    }
  end
  it 'has attributes' do
    gh_user = GithubUser.new(@attributes)
    expect(gh_user.handle).to eq "jfangonilo"
    expect(gh_user.url).to eq "https://github.com/jfangonilo"
    expect(gh_user.github_id).to eq 56
  end

  it 'can find whether or not a user has an account by github_id' do
    gh_user = GithubUser.new(@attributes)
    db_user = create(:user, github_id: 56)

    result = gh_user.has_account?

    expect(result.github_id).to eq(db_user.github_id)
  end
end
