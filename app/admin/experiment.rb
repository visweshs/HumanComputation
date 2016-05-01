ActiveAdmin.register Experiment do
  permit_params :name, :description
  show do
    attributes_table do
        row :name
        row :description
        table_for experiment.trials do
          column "Trial Time" do |t|
            t.time
          end
          column "Trial Graph" do |t|
            t.graph
          end
          column "Correct" do |t|
            t.correct
          end
        end
    end
  end
end
