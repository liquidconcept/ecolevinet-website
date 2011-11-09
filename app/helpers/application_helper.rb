module ApplicationHelper
  def breadcrumb(page, html = '')
    return html unless page

    html = link_to(page.title, url_for(page)) + ' / ' + html
    breadcrumb(page.parent, html).html_safe
  end
end
