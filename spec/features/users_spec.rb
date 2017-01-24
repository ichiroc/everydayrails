# coding: utf-8
# frozen_string_literal: true
require 'rails_helper'

# MEMO: scaffold するとスペックも作られる
# 抑止するにはapplication.rb のジェネレータの設定で request_specs: false を指定する
# MEMO: before と等価の background が使える
# MEMO: let と等価の given が使える
feature 'ユーザー管理' do # MEMO: feature は describe と同等
  scenario '新しいユーザーを追加する' do # MEMO: it と同等
    admin = create :admin
    sign_in admin

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

    # MEMO: フィーチャースペックをデバッグしたい場合は普通のデバッグ手法が使える
    # binding.pry
    # gem 'launchy' の save_and_open_page を使えば
    # その時点のHTMLを保存して開いてくれる
    # save_and_open_page

    expect(current_path).to eq users_path
    expect(page).to have_content 'New user created'
    # MEMO: 特定のタグの中に操作を限定できる
    within 'h1' do
      expect(page).to have_content 'Users'
    end
    expect(page).to have_content 'newuser@example.com'
  end
end
