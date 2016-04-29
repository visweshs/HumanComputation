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

class Point < ActiveRecord::Base
  belongs_to :graph
end
