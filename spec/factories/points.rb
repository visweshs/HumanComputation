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

FactoryGirl.define do
  factory :point do
    x 1
    y 1
    graph nil
  end
end
