module NavigationHelpers
  module Refinery
    module Actualites
      def path_to(page_name)
        case page_name
        when /the list of actualites/
          admin_actualites_path

         when /the new actualite form/
          new_admin_actualite_path
        else
          nil
        end
      end
    end
  end
end
