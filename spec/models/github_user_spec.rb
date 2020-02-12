require 'rails_helper'

describe GithubUser do
  it 'has attributes' do
    attributes = {
      login: "jfangonilo",
      html_url: "https://github.com/jfangonilo",
      id: 56
    }

    gh_user = GithubUser.new(attributes)
    expect(gh_user.handle).to eq "jfangonilo"
    expect(gh_user.url).to eq "https://github.com/jfangonilo"
    expect(gh_user.github_id).to eq 56
  end
end
