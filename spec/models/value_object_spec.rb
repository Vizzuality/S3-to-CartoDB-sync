# == Schema Information
#
# Table name: value_objects
#
#  id                   :integer          not null, primary key
#  data_set_name        :string
#  geo_type             :string
#  geo_id               :integer
#  current_val          :integer
#  previous_val         :integer
#  current_fytd         :integer
#  previous_fytd        :integer
#  previous_year_period :integer
#  uid                  :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  as_of_dt             :date
#  created_dt           :date
#

require 'rails_helper'

RSpec.describe ValueObject, :type => :model do
  it "is valid with a data_set_name, as_of_dt, geo_type, geo_id, current_val, uid" do
    value_object = ValueObject.new(
      data_set_name: 'dataset1',
      geo_type: 'nyc',
      as_of_dt: '02-JAN-15 05.21.33',
      geo_id: 1,
      current_val: 3
      )
    expect(value_object).to be_valid
  end
  it "is invalid without a data_set_name" do
    value_object = ValueObject.new(
      data_set_name: nil,
      geo_type: 'nyc',
      as_of_dt: '02-JAN-15 05.21.33',
      geo_id: 1,
      current_val: 3
      )
    value_object.valid?
    expect(value_object.errors[:data_set_name]).to include("can't be blank")
  end
  it "is invalid without an as_of_dt" do
    value_object = ValueObject.new(
      data_set_name: 'dataset1',
      geo_type: 'nyc',
      as_of_dt: nil,
      geo_id: 1,
      current_val: 3
      )
    value_object.valid?
    expect(value_object.errors[:as_of_dt]).to include("can't be blank")
  end
  it "is invalid without a geo_type" do
    value_object = ValueObject.new(
      data_set_name: 'dataset1',
      geo_type: nil,
      as_of_dt: '02-JAN-15 05.21.33',
      geo_id: 1,
      current_val: 3
      )
    value_object.valid?
    expect(value_object.errors[:geo_type]).to include("can't be blank")
  end
  it "is valid without a geo_id" do
    value_object = ValueObject.new(
      data_set_name: 'dataset1',
      geo_type: 'nyc',
      as_of_dt: '02-JAN-15 05.21.33',
      geo_id: nil,
      current_val: 3
      )
    value_object.valid?
    expect(value_object.errors[:geo_id]).to include("can't be blank")
  end
  it "has a numeric geo_id" do
    value_object = ValueObject.new(
      data_set_name: 'dataset1',
      geo_type: 'nyc',
      as_of_dt: '02-JAN-15 05.21.33',
      geo_id: 'a',
      current_val: 3
      )
    value_object.valid?
    expect(value_object.errors[:geo_id]).to include("is not a number")
  end
  it "is invalid without a current_val" do
    value_object = ValueObject.new(
      data_set_name: 'dataset1',
      geo_type: 'nyc',
      as_of_dt: '02-JAN-15 05.21.33',
      geo_id: 1,
      current_val: nil,
      )
    value_object.valid?
    expect(value_object.errors[:current_val]).to include("can't be blank")
  end
  it "has a numeric current_val" do
    value_object = ValueObject.new(
      data_set_name: 'dataset1',
      geo_type: 'nyc',
      as_of_dt: '02-JAN-15 05.21.33',
      geo_id: 1,
      current_val: 'a'
      )
    value_object.valid?
    expect(value_object.errors[:current_val]).to include("is not a number")
  end
  it "generates an uid based on dataset, date and geo_id" do
    value_object = ValueObject.new(
      data_set_name: 'dataset1',
      geo_type: 'nyc',
      as_of_dt: '02-JAN-15 05.21.33',
      geo_id: 1,
      current_val: 3
      )
    value_object.save!
    uid_test = Base64::urlsafe_encode64("#{value_object.data_set_name.parameterize}_#{value_object.as_of_dt.to_s.parameterize}_#{value_object.geo_id.to_s.parameterize}".parameterize, padding:false)
    expect(value_object.uid).to eq(uid_test)
  end
  it "should have an unique uid" do
    value_object_a = ValueObject.new(
      data_set_name: 'dataset1',
      geo_type: 'nyc',
      as_of_dt: '02-JAN-15 05.21.33',
      geo_id: 1,
      current_val: 3
      )
    value_object_b = ValueObject.new(
      data_set_name: 'dataset1',
      geo_type: 'nyc',
      as_of_dt: '02-JAN-15 05.21.33',
      geo_id: 1,
      current_val: 3
      )
    value_object_a.save!
    value_object_b.valid?
    expect(value_object_b.errors[:uid]).to include("has already been taken")
  end
end
