# coding: utf-8
require "rails_helper"

feature 'About BigCo modal' do
  scenario 'aboutのモーダル表示を切り替える' do
    visit root_path
    # JavaScript ドライバを使用していないので下記の example は失敗する
    expect(page).not_to have_content 'About BigCo'
    expect(page).not_to have_content 'BigCo produces the finest widgets in all the land'

    click_link 'About Us'
    expect(page).to have_content 'About BigCo'
    expect(page).to have_content 'BigCo produces the finest widgets in all the land'

    within '#about_us' do
      click_button 'Close'
    end

    expect(page).not_to have_content 'About BigCo'
    expect(page).to have_content 'BigCo produces the finest widgets in all the land'
  end
end
