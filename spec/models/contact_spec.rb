# coding: utf-8
require "rails_helper"

RSpec.describe Contact do
  it '姓と名とメール有れば有効な状態であること' do
    contact = Contact.new(
      firstname: 'Aaron',
      lastname: 'Sumner',
      email: 'tester@example.com'
    )
    expect(contact).to be_valid
  end
  it '名がなければ無効な状態であること' do
    contact = Contact.new(firstname: nil)
    contact.valid?
    expect(contact.errors[:firstname]).to include("can't be blank")
  end
  it '姓がなければ無効な状態であること' do
    contact = Contact.new(lastname: nil)
    contact.valid?
    expect(contact.errors[:lastname]).to include("can't be blank")
  end

  it 'メールアドレスがなければ無効な状態であること' do
    contact = Contact.new(email: nil)
    contact.valid?
    expect(contact.errors[:email]).to include("can't be blank")
  end

  it '重複したメールアドレスなら無効な状態であること' do
    Contact.create(firstname: 'Joe', lastname: 'Tester',
                   email: 'tester@example.com')
    contact = Contact.new(firstname: 'Jane', lastname: 'Tester',
                          email: 'tester@example.com')
    contact.valid?
    expect(contact.errors[:email]).to include('has already been taken')
  end
  it '連絡先のフルネームを文字列として返すこと'
end
