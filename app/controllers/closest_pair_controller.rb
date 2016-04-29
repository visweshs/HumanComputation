class ClosestPairController < ApplicationController
  def index
    #Randomly Generate Pairs of Points
    x_lst = 10.times.map{ 1 + Random.rand(100) }
    y_lst = 10.times.map{1 + Random.rand(100)}
    pair_lst = Hash[(1..x_lst.size).zip(x_lst.zip(y_lst))]

    #Build collection of point objects
    points = pair_lst.map.with_index{|(i,p)| Point.create!(x:p[0], y:p[1])}

    #Assign label to every point
    points.map.with_index{|p,i|p.update_attribute(:label, ('A'..'J').to_a[i])}

    #Build graph object and add points
    g = Graph.create!(experiment: "Closest Pair")
    points.map{|p| g.points << p}

    #Pass data from controller to front end(d3)
    @dataset = points.map{|p| [p.x, p.y]}
    @labels = points.map{|p| [p.label]}
  end
end
