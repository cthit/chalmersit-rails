require 'rails_helper'

describe 'Locale' do
  it 'keeps the locale when logo is clicked' do
    visit root_path
    locale = I18n.locale

    click_on "Informationsteknik Chalmers Studentkår"

    expect(I18n.locale).to eq(locale)
  end

  it 'changes the locale when flag is clicked' do
    visit root_path
    locale = I18n.locale

    click_on "En"

    expect(I18n.locale).not_to eq(locale)
    expect(I18n.locale).to eq(:en)
  end
end
