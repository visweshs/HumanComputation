class ClosestPairTrialsController < ApplicationController
  protect_from_forgery with: :null_session
  def new
    check = 1
    until check == nil do
      #Randomly Generate Pairs of Points
      x_lst = 10.times.map{ 1 + Random.rand(100) }
      y_lst = 10.times.map{1 + Random.rand(100)}
      pair_lst = Hash[(1..x_lst.size).zip(x_lst.zip(y_lst))]

      #Build collection of point objects
      points = pair_lst.map.with_index{|(i,p)| Point.create!(x:p[0], y:p[1])}

      #Assign label to every point
      points.map.with_index{|p,i|p.update_attribute(:label, ('A'..'J').to_a[i])}

      #Calculate all distances(brute force)
      distances = []
      ids_considered = {}
      min_dist = (2**(0.size * 8 -2) -1)
      min_p1 = nil
      min_p2 = nil
      points.each do |p1|
        points.each do |p2|
          x2_x1 = p2.x - p1.x
          y2_y1 = p2.y - p1.y
          x2_x1_sq = x2_x1 ** 2
          y2_y1_sq = y2_y1 ** 2
          dist = Math.sqrt((x2_x1_sq + y2_y1_sq))
          if(p1.id != p2.id) then
            k = p1.label + "," + p2.label
            if(ids_considered.has_key?(k) == false && ids_considered.has_key?(k.reverse!) == false) then
              ids_considered[k] = 1
              distances.push(dist)
              if(dist < min_dist) then
                min_dist = dist
                min_p1 = p1.label
                min_p2 = p2.label
              end
            end
          end
        end
      end

      #Check whether there are duplicate answers
      check = distances.detect{ |e| distances.count(e) > 1 }
      distances.map{|d| puts d}
      if check != nil then points.map{|p| p.destroy} end
    end

    #calculate graph statistics
    sum_distances =  distances.inject(0){|accum, i| accum + i }
    mean = sum_distances / distances.length.to_f
    variance = distances.inject(0){|accum, i| accum + (i-mean)**2 }
    variance = variance / (distances.length - 1).to_f
    std_dev = Math.sqrt(variance)

    #Build graph object and add points
    graph = Graph.create!(answer: min_p1 + min_p2, mean: mean, variance: variance, std_dev: std_dev)
    points.map{|p| graph.points << p}

    #Pass data from controller to front end(d3)
    @dataset = points.map{|p| [p.x, p.y, p.label]}
    @labels = points.map{|p| [p.label]}
    @trial = ClosestPairTrial.new
    @trial.graph = graph
  end

  def create
    graph = Graph.find_by(id: params[:graph_id])
    user_answer = params[:closest_pair_trial][:user_answer]
    user_answer = user_answer.upcase
    time = params[:time_milliseconds]
    correct = user_answer == graph.answer ? true : false
    correct = correct || (user_answer.reverse! == graph.answer) ? true : false
    ClosestPairTrial.create!(correct: correct, user_answer: user_answer, graph: graph, time_milliseconds: time)
  end
end
