# == Schema Information
#
# Table name: synchronizations
#
#  id         :integer          not null, primary key
#  date       :datetime
#  status     :string
#  sync_id    :string
#  log        :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  sync_at    :datetime
#

class Synchronization < ApplicationRecord
  HEADERS = ["data_set_name", "as_of_dt", "geo_type", "created_dt", "geo_id", "current_val", "previous_val", "current_fytd", "previous_fytd", "previous_year_period"]
end
