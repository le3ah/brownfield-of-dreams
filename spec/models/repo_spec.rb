require 'rails_helper'

describe Repo do
  it "exists" do
    attributes = {}
    repository = Repo.new(attributes)

    expect(repository).to be_a(Repo)
  end
  it "has attributes" do
    attributes = { name: "Leah",
                   html_url: "https://github.com/le3ah"
                 }
    repository = Repo.new(attributes)
    expect(repository.name).to eq("Leah")
    expect(repository.html_url).to eq("https://github.com/le3ah")
  end
end

describe 'class methods', :vcr do
  it ".find_all_repos" do
    user = create(:user, oauth_token: ENV["GITHUB_TOKEN"])
    token = user.oauth_token
    repos = Repo.find_all_repos(token)

    expect(repos.count).to eq(5)
    expect(repos.first).to be_an_instance_of(Repo)
  end
end
