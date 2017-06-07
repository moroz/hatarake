module CandidatesHelper
  # http://stackoverflow.com/questions/819263/get-persons-age-in-ruby
  def age(dob)
    now = Time.now.utc.to_date
    now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
  end

  def looking_for_work_label(lfw)
    classNames = lfw ? 'label success' : 'label alert'
    text = I18n.t('candidates.show.looking_for_work.' + (!!lfw).to_s)
    content_tag :span, class: classNames do
      concat fa_icon 'briefcase'
      concat ' ' + text
    end
  end
end
