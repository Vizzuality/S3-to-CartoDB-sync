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
  validates :data_set_name, presence: true
  validates_numericality_of :geo_id, :current_val, allow_blank: true
  validates_numericality_of :previous_val, :current_fytd, :previous_fytd, :previous_year_period, allow_blank: true
  validates :uid, uniqueness: true
  before_save :generate_uid
  # def self.update_or_create(attributes)
  #   assign_or_new(attributes).save
  # end
  # def self.assign_or_new(attributes)
  #   obj = first || new
  #   obj.assign_attributes(attributes)
  #   obj
  # end
  def generate_uid
    base_string = ''
    base_string += self.data_set_name.parameterize if self.data_set_name
    base_string += '_'
    base_string += self.as_of_dt.to_s.parameterize if self.as_of_dt
    base_string += '_'
    base_string += self.geo_id.to_s.parameterize if self.geo_id
    base_string += '_'
    base_string += self.geo_type.to_s.parameterize if self.geo_type
    self.uid = Base64::urlsafe_encode64(base_string.parameterize, padding:false)
  end
  def valid_for_create_or_update?
    self.errors.messages.except(:uid) == 0
  end
end
