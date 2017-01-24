# coding: utf-8
# frozen_string_literal: true
require 'rails_helper'

feature 'ユーザー管理' do # MEMO: feature は describe と同等
  scenario '新しいユーザーを追加する' do # MEMO: it と同等
    admin = create :admin
    visit root_path
    click_link 'Log In'
    fill_in 'Email', with: admin.email
    fill_in 'Password', with: admin.password
    click_button 'Log In'
    visit root_path

    # MEMO: expect{ hoge }.to change(receiver, message).by(count)
    # 処理hoge を行うことによって receiver.message の値が count 変わる
    # by は変更できる
    expect {
      click_link 'Users'
      click_link 'New User'
      fill_in 'Email', with: 'newuser@example.com'
      # MEMO: CSS, XPath セレクタが使える。 ここでは Password では絞れないので使用している。
      find('#password').fill_in 'Password', with: 'secret123'
      find('#password_confirmation').fill_in 'Password confirmation',
                                             with: 'secret123'
      click_button 'Create User'
    }.to change(User, :count).by(1)

    expect(current_path).to eq users_path
    expect(page).to have_content 'New user created'
    # MEMO: 特定のタグの中に操作を限定できる
    within 'h1' do
      expect(page).to have_content 'Users'
    end
    expect(page).to have_content 'newuser@example.com'
  end
end
