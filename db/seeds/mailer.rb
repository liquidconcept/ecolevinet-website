# encoding: UTF-8
::I18n.locale = :fr

if defined?(Page) && defined?(Section) && !Section.find_by_title('Parents').blank? && Page.find_by_title('Demande de congé').blank?

  s = Section.find_by_title('Parents')
  sp = s.page.children.create(:title => 'En Savoir Plus',
                :show_in_menu => true,
                :deletable => false)

  p = sp.children.create(:title => 'Demande de congé',
                :show_in_menu => true,
                :link_url => '/send/demande_absence',
                :data_type => 'form',
                :deletable => false)
  p.parts.create( {
    :title    => 'Contenu',
    :body     => '',
    :position => 0})

  p = sp.children.create(:title => "Justification d’absence",
                :show_in_menu => true,
                :link_url => '/send/justification_absence',
                :data_type => 'form',
                :deletable => false)
  p.parts.create( {
    :title    => 'Contenu',
    :body     => '',
    :position => 0})
end
