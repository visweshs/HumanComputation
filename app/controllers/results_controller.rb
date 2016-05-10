class ResultsController < ApplicationController
  def closest_pair
    @trials = ClosestPairTrial.all.order('updated_at DESC').limit(10000)
  end
end
