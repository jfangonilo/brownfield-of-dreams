class GithubService
  def initialize(token)
    @token = token
  end

  def repo_info
    get_json('/user/repos')
  end

  private

  def get_json(uri)
    response = conn.get(uri)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new('https://api.github.com') do |f|
      f.adapter Faraday.default_adapter
      f.headers['authorization'] = "token #{@token}"
    end
  end
end