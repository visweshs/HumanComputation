# == Schema Information
#
# Table name: graphs
#
#  id         :integer          not null, primary key
#  answer     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Graph < ActiveRecord::Base
  belongs_to :closest_pair_trial
  has_many :points, dependent: :destroy
end
