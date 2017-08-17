module FormHelpers
  def submit_form
    find('input[name=commit]').click
  end

  def dom_id(object)
    "#" + object.class.to_s.downcase + "_#{object.id}"
  end
end
