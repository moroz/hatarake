ActiveAdmin.register Candidate do
  menu label: 'Candidates'

  action_item :show, only: :show do
    link_to "View on Website", candidate_path(candidate), target: '_blank'
  end

  order_by(:full_name) do |order_clause|
    binding.pry
    'first_name ' + order_clause.order + ', last_name ' + order_clause.order
  end
  index title: 'Candidates' do
    column :id
    column :full_name do |c|
      c.display_name
    end
    column :slug
    column :profession { |c| c.profession.name_en }
    actions
  end

  filter :profession { |c| c.profession.name_en }

  show title: proc { |c| 'Candidate: ' +c.display_name } do
    attributes_table do
      row :avatar { |c| avatar_for c }
      row :full_name { |c| c.display_name }
      row :age
      row :sex
      row :looking_for_work
      row :profession { |c| c.profession.name_en }
      row :description
      row :applications { |c| c.applications.count }
      row :resumes { |c| c.resumes.count }
    end
  end

  controller do
    def scoped_collection
      super.friendly.includes(:profession, :resumes, :profile)
    end
  end
end
