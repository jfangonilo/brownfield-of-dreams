class UserDashboardFacade
  def initialize(user)
    @user = user
  end

  def repositories
    service.repo_info.take(5).map do |data|
      Repository.new(data)
    end
  end

  private

  def service
    GithubService.new(@user.github_token)
  end
end
