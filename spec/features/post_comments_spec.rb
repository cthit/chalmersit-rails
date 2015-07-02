require 'rails_helper'

describe 'PostComments' do
  it 'allows users to post comments on a post' do
    post = FactoryGirl.create(:post)
    visit post_path(nil, post)

    username = 'smurf'
    comment = 'This post really adds to a relevant topic!'

    fill_in 'Användare', with: username
    fill_in 'Kommentar', with: comment
    click_on 'Skapa Kommentar'

    expect(current_path).to eq(post_path(nil, post))
    expect(page).to have_content(comment)
    expect(page).to have_content('Kommentaren har skapats')
  end
end
