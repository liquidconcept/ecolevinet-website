module NavigationHelpers
  module Refinery
    module Sections
      def path_to(page_name)
        case page_name
        when /the list of sections/
          admin_sections_path

         when /the new section form/
          new_admin_section_path
        else
          nil
        end
      end
    end
  end
end
