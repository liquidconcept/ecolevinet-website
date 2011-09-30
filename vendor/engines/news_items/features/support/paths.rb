module NavigationHelpers
  module Refinery
    module NewsItems
      def path_to(page_name)
        case page_name
        when /the list of news_items/
          admin_news_items_path

         when /the new news_item form/
          new_admin_news_item_path
        else
          nil
        end
      end
    end
  end
end
