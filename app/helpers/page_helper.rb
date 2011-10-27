module PageHelper
  def current_day
    Date.today
  end
  def current_month
    l(current_day , :format => :month_word)
  end
  def current_day_word
    l(current_day , :format => :day_word)
  end
  def current_day_number
    l(current_day , :format => :day_number)
  end
  def first_day(day)
    day.to_date.beginning_of_month.beginning_of_week
  end
  def last_day(day)
    day.to_date.end_of_month.end_of_week
  end
  def day_type(day)
    klass =  ''
    klass << ' first'       if day.to_date.cwday == 1
    klass << ' weekend'     if day.to_date.cwday >= 6
    klass << ' event_check' if Event.given_day(day).count > 0
    klass
  end
  def week_type(day)
    (day.to_date.cweek == current_day.cweek &&  day.to_date.cwyear == current_day.cwyear ) ? 'id="current_week"' : ''
  end
  def day_count(day)
    Event.given_day(day).count
  end

  def in_section(page)
    page.section || page.parent.section || page.parent.parent.section ||
    page.parent.parent.parent.section || page.parent.parent.parent.section ||
    page.parent.parent.parent.parent.section
  end

end

