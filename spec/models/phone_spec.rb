# coding: utf-8
require "rails_helper"

RSpec.describe Phone do
  it '連絡先毎に重複した電話番号を許可しないこと' do
    contact = Contact.create(firstname: 'Joe', lastname: 'Tester',
                             email: 'tester@example.com')
    contact.phones.create(
      phone_type: 'home',
      phone: '123-123-1234'
    )
    mobile_phone = contact.phones.build(
      phone_type: 'mobile',
      phone: '123-123-1234'
    )
    mobile_phone.valid?
    expect(mobile_phone.errors[:phone]).to include('has already been taken')
  end
  it '2件の連絡先で同じ電話番号を共有できること' do
    contact = Contact.create(firstname: 'Joe', lastname: 'Tester',
                             email: 'tester@example.com')
    contact.phones.create(
      phone_type: 'home',
      phone: '123-123-1234'
    )
    other_contact = Contact.new
    other_phone = other_contact.phones.build(
      phone_type: 'home',
      phone: '123-123-1234'
    )
    expect(other_phone).to be_valid
  end

end
