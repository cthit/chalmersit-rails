require 'rails_helper'

describe 'PostsEvents' do
  it 'should not create event unless specified' do
    post = FactoryGirl.build(:post)
    visit new_post_path

    fill_in 'Användare', with: post.user_id
    fill_in 'Förening/kommitté', with: post.group_id
    fill_in 'Title', with: post.title_en
    fill_in 'Titel', with: post.title_sv
    fill_in 'Body', with: post.body_en
    fill_in 'Innehåll', with: post.body_sv

    click_on 'Skapa Nyhet'

    expect(page).to have_content(post.title_sv)
    expect(page).not_to have_selector('.meta.event-meta')
    expect(page).to have_content(post.title_sv + ' har skapats')
  end

  it 'should create event when specified' do
    post = FactoryGirl.build(:post, title_en: 'unique title', title_sv: 'unik titel')
    event = FactoryGirl.build(:event)
    visit new_post_path

    fill_in 'Användare', with: post.user_id
    fill_in 'Förening/kommitté', with: post.group_id
    fill_in 'Title', with: post.title_en
    fill_in 'Titel', with: post.title_sv
    fill_in 'Body', with: post.body_en
    fill_in 'Innehåll', with: post.body_sv

    check 'Arrangemang'
    fill_in 'Arrangemangsdatum', with: event.event_date
    fill_in 'Starttid', with: event.start_time
    fill_in 'Sluttid', with: event.end_time
    fill_in 'Facebooklänk', with: event.facebook_link
    fill_in 'Plats', with: event.location

    click_on 'Skapa Nyhet'

    expect(page).to have_content(post.title_sv)
    expect(page).to have_selector('.meta.event-meta')
    expect(page).to have_content(event.location)
    expect(page).to have_content(post.title_sv + ' har skapats')
  end
end
