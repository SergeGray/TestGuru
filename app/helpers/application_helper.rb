module ApplicationHelper
  GITHUB_LINK = "http://github.com".freeze

  def current_year
    Time.zone.now.year
  end

  def github_url(author, repo)
    "#{GITHUB_LINK}/#{author}/#{repo}"
  end
end
