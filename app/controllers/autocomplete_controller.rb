class AutocompleteController < ApplicationController
  def skills
    autocomplete(Skill)
  end

  def professions
    q = ActiveRecord::Base.send(:sanitize_sql_like, params[:term])
    collection = CandidateProfile.distinct.where('profession_name ILIKE ?', "%#{q}%").pluck(:profession_name)
    render json: collection
  end

  def schools
    render json: EducationItem.distinct_organizations_like(params[:term])
  end

  def organizations
    render json: WorkItem.distinct_organizations_like(params[:term])
  end

  private

  def autocomplete(model)
    @collection = model.search(params[:term])
    render json: @collection.serialize_for_autocomplete
  end
end
