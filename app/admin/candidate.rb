ActiveAdmin.register Candidate do
  menu label: 'Candidates'

  action_item :show, only: :show do
    link_to "View on Website", candidate_path(candidate), target: '_blank' unless candidate.profile.blank?
  end

  form partial: 'form'

  #action_item :index, only: :index do
  #  link_to 'Download as XLSX', candidates_path(format: 'xlsx')
  #end

  #action_item :mailing_list, only: :index do
  #  link_to "Mailing list", mailing_list_candidates_path, target: '_blank'
  #end

  order_by(:full_name) do |order_clause|
    'first_name ' + order_clause.order + ', last_name ' + order_clause.order
  end

  index title: 'Candidates' do
    column :id
    column :full_name do |c|
      c.profile.present? ? c.display_name : c.email
    end
    column :profession do |c|
      c&.profile&.profession_name
    end
    column :age do |c|
      c&.profile&.age
    end
    actions
  end

  filter :profile_profession_name, as: :string, label: 'Profession name'
  filter :profile_first_name, as: :string, label: 'First name'
  filter :profile_last_name, as: :string, label: 'Last name'
  filter :email, as: :string, label: 'E-mail'
  filter :phone, as: :string, label: 'Phone'

  show title: proc { |c| 'Candidate: ' + c.table_name } do
    attributes_table do
      row :avatar do |c|
        avatar_for c if c.avatar.present?
      end
      row :full_name do |c|
        c.display_name if c.profile.present?
      end
      row :email
      row :contact_email
      row :age do |c|
        c.age if c.profile.present?
      end
      row :sex do |c|
        c.sex if c.profile.present?
      end
      row :looking_for_work do |c|
        c.looking_for_work if c.profile.present?
      end
      row :profession do |c|
        c&.profile&.profession_name
      end
      row :description
      row :applications do |c|
        c.applications.count
      end
      row :resumes do |c|
        c.resumes.count
      end
    end
  end

  controller do
    def scoped_collection
      super.friendly.includes(:resumes, :profile)
    end

    def edit
      @page_title = "Edycja kandydata: #{resource.table_name}"
    end
  end
end
