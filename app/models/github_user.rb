class GithubUser
  attr_reader :handle, :url, :github_id

  def initialize(data)
    @handle = data[:login]
    @url = data[:html_url]
    @github_id = data[:id]
  end

  def account?
    User.find_by(github_id: github_id)
  end
end
