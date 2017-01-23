# coding: utf-8
require "rails_helper"

RSpec.describe Contact do

  it '有効なファクトリを持つこと' do
    expect(build :contact).to be_valid
  end

  it '姓と名とメール有れば有効な状態であること' do
    contact = build(:contact,
                    firstname: 'Aaron',
                    lastname: 'Sumner',
                    email: 'tester@example.com')
    expect(build :contact).to be_valid
  end

  it '名がなければ無効な状態であること' do
    contact = build(:contact, firstname: nil)
    contact.valid?
    expect(contact.errors[:firstname]).to include("can't be blank")
  end

  it '姓がなければ無効な状態であること' do
    contact = build(:contact, lastname: nil)
    contact.valid?
    expect(contact.errors[:lastname]).to include("can't be blank")
  end

  it 'メールアドレスがなければ無効な状態であること' do
    contact = build(:contact, email: nil)
    contact.valid?
    expect(contact.errors[:email]).to include("can't be blank")
  end

  it '重複したメールアドレスなら無効な状態であること' do
    create(:contact, email: 'tester@example.com')
    contact = build(:contact, email: 'tester@example.com')
    contact.valid?
    expect(contact.errors[:email]).to include('has already been taken')
  end

  it '連絡先のフルネームを文字列として返すこと' do
    contact = build :contact
    expect(contact.name).to eq 'John Doe'
  end

  describe '文字で姓をフィルタする' do
    # DRY にするのは良いことだが、ファイル内でスクロールを何度もするぐらいなら重複しましょう（本書より）
    before :each do # each は毎回実施する指示。省略しても良い
      @smith = Contact.create(
        firstname: 'John',
        lastname: 'Smith',
        email: 'jsmith@example.com'
      )

      @jones = Contact.create(
        firstname: 'Tim',
        lastname: 'Jones',
        email: 'tjones@example.com'
      )

      @johnson = Contact.create(
        firstname: 'John',
        lastname: 'Johnson',
        email: 'jjohnson@example.com'
      )
    end

    context 'マッチする文字の場合' do
      it 'マッチした結果をソート済みの配列として返すこと' do
        # ↓順番もテストしている
        expect(Contact.by_letter('J')).to eq [@johnson, @jones]
      end
    end

    context 'マッチしない文字の場合' do
      it 'マッチしなかったものは結果に含まれないこと' do
        # ↓順番もテストしている
        expect(Contact.by_letter('J')).not_to include @smith
      end
    end
  end
end
