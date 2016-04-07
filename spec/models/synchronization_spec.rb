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

require 'rails_helper'

RSpec.describe Synchronization, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
