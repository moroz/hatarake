module CandidatesHelper
  # http://stackoverflow.com/questions/819263/get-persons-age-in-ruby
  def age(dob)
    now = Time.now.utc.to_date
    now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
  end

  def looking_for_work_label(lfw)
    classNames = lfw ? 'label candidate__lfw candidate__lfw--green' : 'label candidate__lfw candidate_lfw--red'
    text = I18n.t('candidates.show.looking_for_work.' + (!!lfw).to_s)
    content_tag :span, class: classNames do
      concat fa_icon 'briefcase'
      concat ' ' + text
    end
  end

  def sex_age_label(sex, age)
    classNames = 'label candidate__sex_age'
    if sex == 'male'
      classNames << ' candidate__sex_age--blue'
      icon = 'mars'
    else
      classNames << ' candidate__sex_age--purple'
      icon = 'venus'
    end
    content_tag :span, class: classNames do
      concat fa_icon icon
      concat ' ' + age.to_s
    end
  end

  def timespan(start_date, end_date = nil)
    str = I18n.l(start_date, format: :month_and_year) + "–"
    if end_date
      str << I18n.l(end_date, format: :month_and_year)
    else
      str << "present" 
    end
  end
end
