require 'rails_helper'

describe Repository do
  it 'has attributes' do
    attributes = {
      name: "enigma",
      html_url: "https://github.com/jfangonilo/enigma"
    }

    repo = Repository.new(attributes)
    expect(repo.name).to eq "enigma"
    expect(repo.url).to eq "https://github.com/jfangonilo/enigma"
  end
end