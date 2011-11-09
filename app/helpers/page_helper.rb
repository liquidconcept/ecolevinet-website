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
    return Section.first if page.nil?
    page.try(:section) || in_section(page.parent)
  end

  def page_tree(page, level = 1)
    return if !page.children.any?{|child| page_tree_child?(child) }

    content = []
    content << "<ul class=\"tree_level_#{level}\">"
    page.children.select{|child| page_tree_child?(child) }.each do |child|
      content << '<li>' + link_to(child.title, url_for(child.url))
      content << page_tree(child, level + 1)
      content << '</li>'
    end
    content << '</ul>'

    content.compact.join("\n").html_safe
  end

  def page_tree_child?(child)
    child.data_type.blank? || !%w(form).include?(child.data_type.blank?)
  end

  def date_for(event_object)
    if event_object.start_date == event_object.end_date
      event_object.start_date.strftime("%d.%m.%Y")
    else
      'du ' + event_object.start_date.strftime("%d.%m.%Y") + ' au ' + event_object.end_date.strftime("%d.%m.%Y")
    end
  rescue Exception => e
    logger.error(" #{e.message}")
  end
end


