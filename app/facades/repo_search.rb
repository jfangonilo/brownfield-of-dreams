class RepoSearch
  def repos
    conn = Faraday.new("https://api.github.com") do |f|
      f.adapter Faraday.default_adapter
      f.headers["Authorization"] = "token #{ENV['GITHUB_TOKEN']}"
    end

    response = conn.get("/user/repos")

    json = JSON.parse(response.body, symbolize_names: true)

    hash = json.take(5)

    hash.map do |data|
      Repo.new(data)
    end
  end
end
