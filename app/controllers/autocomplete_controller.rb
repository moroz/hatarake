class AutocompleteController < ApplicationController
  def skills
    autocomplete(Skill)
  end

  def professions
    autocomplete(Profession)
  end

  private

  def autocomplete(model)
    @collection = model.search(params[:term])
    render json: @collection.serialize_for_autocomplete
  end
end
