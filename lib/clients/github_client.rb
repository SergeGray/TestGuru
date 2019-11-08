class GithubClient
  ACCESS_TOKEN = ENV['GITHUB_TOKEN']

  def initialize
    @client = setup_client
  end

  def create_gist(params)
    @client.create_gist(params.to_json)
  end

  private

  def setup_client
    Octokit::Client.new(access_token: ACCESS_TOKEN)
  end
end
