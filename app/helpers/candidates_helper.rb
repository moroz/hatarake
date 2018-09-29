# frozen_string_literal: true

module CandidatesHelper
  # http://stackoverflow.com/questions/819263/get-persons-age-in-ruby
  def age(dob)
    now = Time.now.utc.to_date
    now.year - dob.year - (now.month > dob.month || (now.month == dob.month && now.day >= dob.day) ? 0 : 1)
  end

  def looking_for_work_label(lfw)
    class_names = lfw ? 'label candidate__lfw candidate__lfw--green' : 'label candidate__lfw candidate_lfw--red'
    text = I18n.t('candidates.show.looking_for_work.' + (!!lfw).to_s)
    content_tag :span, class: class_names do
      concat fa_icon 'briefcase'
      concat ' ' + text
    end
  end

  def sex_icon(sex)
    sex == 'male' ? 'mars' : 'venus'
  end

  def sex_age_label(sex, age)
    class_names = 'label candidate__sex_age'
    if sex == 'male'
      class_names += ' candidate__sex_age--blue'
      icon = 'mars'
    else
      class_names += ' candidate__sex_age--purple'
      icon = 'venus'
    end
    content_tag :span, class: class_names do
      concat fa_icon icon
      concat ' ' + age.to_s
    end
  end

  def timespan(start_date, end_date = nil)
    str = I18n.l(start_date, format: :month_and_year) + '–'
    str << if end_date
             I18n.l(end_date, format: :month_and_year)
           else
             'present'
           end
  end

  def yes_no_icon(val)
    fa_icon(val ? 'check' : 'times')
  end
end
