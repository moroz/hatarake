class AutocompleteController < ApplicationController
  def skills
    autocomplete(Skill)
  end

  def professions
    autocomplete(Profession)
  end

  def schools
    @collection = EducationItem.distinct_organizations_like(params[:term])
    render json: view_context.highlight_search_term_in_collection(@collection, params[:term])
  end

  def organizations
    @collection = WorkItem.distinct_organizations_like(params[:term])
    render json: view_context.highlight_search_term_in_collection(@collection, params[:term])
  end

  private

  def autocomplete(model)
    @collection = model.search(params[:term])
    render json: @collection.serialize_for_autocomplete
  end
end
