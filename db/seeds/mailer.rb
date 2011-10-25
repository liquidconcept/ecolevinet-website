# encoding: UTF-8
::I18n.locale = :fr

if defined?(Page) && defined?(Section) && !Section.find_by_title('Parents').blank? && Page.find_by_title('Demande de congé').blank?

  s = Section.find_by_title('Parents')
  p = s.page.children.create(:title => 'Demande de congé',
                :show_in_menu => true,
                :data_type => 'form',
                :deletable => false)
  p.parts.create( {
    :title    => 'Contenu',
    :body     => '',
    :position => 0})

  p = s.page.children.create(:title => "Justification d’absence",
                :show_in_menu => true,
                :data_type => 'form',
                :deletable => false)
  p.parts.create( {
    :title    => 'Contenu',
    :body     => '',
    :position => 0})
end
