require 'rails_helper'

describe GithubService do
  it 'exists', :vcr do
    user = create(:user, oauth_token: ENV["GITHUB_TOKEN"])
    token = user.oauth_token

    allow_any_instance_of(ApplicationController)
    .to receive(:current_user).and_return(user)
    github_service = GithubService.new(token)

    expect(github_service).to be_a(GithubService)
  end

  it 'gets repos by user', :vcr do
    user = create(:user, first_name: "Wanda", oauth_token: ENV["GITHUB_TOKEN"])
    token = user.oauth_token

    allow_any_instance_of(ApplicationController)
    .to receive(:current_user).and_return(user)
    github_service = GithubService.new(token)

    repo = github_service.find_repos.first
    # binding.pry
    expect(github_service.find_repos.count).to eq(5)
    expect(repo).to have_key(:name)
    expect(repo).to have_key(:html_url)
  end

end
