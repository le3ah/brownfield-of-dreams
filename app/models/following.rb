class Following
  attr_reader :login, :html_url
  def initialize(attributes)
    @login = attributes[:login]
    @html_url = attributes[:html_url]
  end

  def self.find_all_following(token)
    data = GithubService.find_following(token)
    data.map do |raw_following|
      Following.new(raw_following)
    end
  end

end
