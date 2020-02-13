class UserDashboardFacade
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def user_has_token?
    @user.github_token
  end

  def first_name
    @user.first_name
  end

  def last_name
    @user.last_name
  end

  def email
    @user.email
  end

  def repositories
    service.repo_info.take(5).map do |data|
      Repository.new(data)
    end
  end

  def followers
    service.follower_info.map do |data|
      GithubUser.new(data)
    end
  end

  def followings
    service.following_info.map do |data|
      GithubUser.new(data)
    end
  end

  def all_friends
    user.friended_users
  end
  private

  def service
    @service ||= GithubService.new(@user.github_token)
  end
end
