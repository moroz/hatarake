class AutocompleteController < ApplicationController
  def skills
    @skills = Skill.search(params[:term])
    render json: @skills.map { |s| {id: s.id, label: s.name, value: s.name} }
  end
end
