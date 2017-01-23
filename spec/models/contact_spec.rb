# coding: utf-8
require "rails_helper"

RSpec.describe Contact do
  it '姓と名とメール有れば有効な状態であること'
  it '名がなければ無効な状態であること'
  it '姓がなければ無効な状態であること'
  it 'メールアドレスがなければ無効な状態であること'
  it '重複したメールアドレスなら無効な状態であること'
  it '連絡先のフルネームを文字列として返すこと'
end
