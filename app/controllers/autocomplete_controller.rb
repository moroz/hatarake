class AutocompleteController < ApplicationController
  def skills
    @skills = Skill.search(params[:term])
    render json: @skills.serialize_for_autocomplete
  end
end
