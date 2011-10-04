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
  def first_day
    Date.today.beginning_of_month.beginning_of_week
  end
  def last_day
    Date.today.end_of_month.end_of_week
  end
  def day_type(day)
    klass =  ''
    klass << ' first'       if day.to_date == day.beginning_of_month.to_date
    klass << ' weekend'     if day.to_date.cwday >= 6
    klass << ' event_check' if Event.given_day(day).count > 0
    klass
  end


end
