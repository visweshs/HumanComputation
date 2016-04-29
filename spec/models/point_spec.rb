# == Schema Information
#
# Table name: points
#
#  id         :integer          not null, primary key
#  x          :integer
#  y          :integer
#  label      :string
#  graph_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Point, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
