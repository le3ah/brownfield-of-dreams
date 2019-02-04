require 'rails_helper'

describe 'As a valid user' do
  describe 'when the visit the tutorials page' do
    it 'shows videos' do
      tutorial_1 = create(:tutorial, title: "How to Tie Your Shoes")
      video_1 = create(:video, title: "The Bunny Ears Technique", tutorial: tutorial_1, position: 1)
      video_2 = create(:video, title: "The Wanda Technique", tutorial: tutorial_1, position: 2)
      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit tutorial_path(tutorial_1)

      expect(page).to have_link(video_1.title)
      expect(page).to have_link(video_2.title)
    end

    it 'does not show videos without a position' do
      tutorial_1 = create(:tutorial, title: "How to Tie Your Shoes")
      video_1 = create(:video, title: "The Bunny Ears Technique", tutorial: tutorial_1, position: 1)
      video_2 = create(:video, title: "The Wanda Technique", tutorial: tutorial_1, position: nil)
      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit tutorial_path(tutorial_1)
      expect(page).to have_link(video_1.title)
      expect(page).to_not have_link(video_2.title)
    end

  end

end
