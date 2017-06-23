class AutocompleteController < ApplicationController
  def skills
    autocomplete(Skill)
  end

  def professions
    autocomplete(Profession)
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
