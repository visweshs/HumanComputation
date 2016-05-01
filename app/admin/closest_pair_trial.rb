ActiveAdmin.register ClosestPairTrial do
  show do
    attributes_table do
        row :experiment
        row :time_milliseconds
        row :user_answer
        table_for closest_pair_trial.graph do
          column "Answer" do |g|
            g.answer
          end
          column "Mean" do |g|
            g.mean
          end
          column "Variance" do |g|
            g.variance
          end
          column "Standard Deviation" do |g|
            g.std_dev
          end
          table_for closest_pair_trial.graph.points do
            column "X" do |p|
              p.x
            end
            column "Y" do |p|
              p.y
            end
            column "Label" do |p|
              p.label
            end
          end
        end
    end
  end
end


