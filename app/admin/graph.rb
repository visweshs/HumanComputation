ActiveAdmin.register Graph do
  show do
    attributes_table do
        row :experiment
        row :answer
        table_for graph.points do
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
