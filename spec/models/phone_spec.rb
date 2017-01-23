# coding: utf-8
require "rails_helper"

RSpec.describe Phone do
  it '連絡先毎に重複した電話番号を許可しないこと' do
    contact = create :contact
    create( :home_phone, contact: contact, phone: '000-000-0000')
    mobile_phone = build( :mobile_phone, contact: contact, phone: '000-000-0000')

    mobile_phone.valid?
    expect(mobile_phone.errors[:phone]).to include('has already been taken')
  end

  it '2件の連絡先で同じ電話番号を共有できること' do
    create :phone, phone: '234-234-2345'
    expect(build :phone, phone: '234-234-2345').to be_valid
  end

end
