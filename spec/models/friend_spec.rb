require 'rails_helper'

describe Friend do
  it 'has attributes' do
    attributes = {
      login: "jfangonilo",
      html_url: "https://github.com/jfangonilo"
    }

    friend = Friend.new(attributes)
    expect(friend.handle).to eq "jfangonilo"
    expect(friend.url).to eq "https://github.com/jfangonilo"
  end
end