module ApplicationHelper
  GITHUB_LINK = "https://github.com".freeze

  def current_year
    Time.zone.now.year
  end

  def github_url(author, repo)
    "#{GITHUB_LINK}/#{author}/#{repo}"
  end

  def flash_message(message, type)
    content_tag :div, message, class: "flash #{type}"
  end
end
