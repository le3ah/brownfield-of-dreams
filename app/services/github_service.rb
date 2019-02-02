class GithubService
  def initialize(token)
    @token = token
  end

  def find_repos
    get_json('/user/repos')
  end

  def find_followers
    get_json('/user/followers')
  end

  def find_following
    get_json('/user/following')
  end

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true).take(5)
  end

  def conn
    Faraday.new(url: "https://api.github.com") do |faraday|
      faraday.headers["Authorization"] = @token
      faraday.adapter Faraday.default_adapter
    end
  end

  def self.find_repos(token)
    new(token).find_repos
  end

  def self.find_followers(token)
    new(token).find_followers
  end

  def self.find_following(token)
    new(token).find_following
  end

end
