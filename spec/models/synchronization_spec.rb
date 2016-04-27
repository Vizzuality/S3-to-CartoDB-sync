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
  it 'responds to HEADERS' do
    expect(Synchronization::HEADERS.class).to eq(Array)
  end
end
