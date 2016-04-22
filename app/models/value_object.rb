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

class ValueObject < ApplicationRecord
  validates :data_set_name, :as_of_dt, :geo_type, :geo_id, :current_val, presence: true
  validates_numericality_of :geo_id, :current_val
  validates_numericality_of :previous_val, :current_fytd, :previous_fytd, :previous_year_period, allow_blank: true
  validates_format_of :as_of_dt, :with => /\d{4}\/\d{2}\/\d{2}/, :message => "is not a correct date format"
  validates_format_of :created_dt, :with => /\d{4}\/\d{2}\/\d{2}/, :message => "is not a correct date format"
  validates :uid, uniqueness: true
  before_validation :generate_uid
  def self.update_or_create(attributes)
    assign_or_new(attributes).save
  end
  def self.assign_or_new(attributes)
    obj = first || new
    obj.assign_attributes(attributes)
    obj
  end
  def generate_uid
    self.uid = Base64::urlsafe_encode64("#{self.data_set_name.parameterize}_#{self.as_of_dt.to_s.parameterize}_#{self.geo_id.to_s.parameterize}_#{self.geo_type.to_s.parameterize}".parameterize, padding:false) if self.data_set_name && self.as_of_dt && self.geo_id && self.geo_type
  end
  def valid_for_create_or_update?
    self.errors.messages.except(:uid) == 0
  end

  def as_of_dt=(value)
    self.as_of_dt = Date.parse(value) if value.present?
  end
  def created_dt=(value)
    self.created_dt = Date.parse(value) if value.present?
  end
end
