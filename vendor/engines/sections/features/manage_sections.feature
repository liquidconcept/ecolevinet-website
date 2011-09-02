@sections
Feature: Sections
  In order to have sections on my website
  As an administrator
  I want to manage sections

  Background:
    Given I am a logged in refinery user
    And I have no sections

  @sections-list @list
  Scenario: Sections List
   Given I have sections titled UniqueTitleOne, UniqueTitleTwo
   When I go to the list of sections
   Then I should see "UniqueTitleOne"
   And I should see "UniqueTitleTwo"

  @sections-valid @valid
  Scenario: Create Valid Section
    When I go to the list of sections
    And I follow "Add New Section"
    And I fill in "Nom" with "This is a test of the first string field"
    And I press "Save"
    Then I should see "'This is a test of the first string field' was successfully added."
    And I should have 1 section

  @sections-invalid @invalid
  Scenario: Create Invalid Section (without nom)
    When I go to the list of sections
    And I follow "Add New Section"
    And I press "Save"
    Then I should see "Nom can't be blank"
    And I should have 0 sections

  @sections-edit @edit
  Scenario: Edit Existing Section
    Given I have sections titled "A nom"
    When I go to the list of sections
    And I follow "Edit this section" within ".actions"
    Then I fill in "Nom" with "A different nom"
    And I press "Save"
    Then I should see "'A different nom' was successfully updated."
    And I should be on the list of sections
    And I should not see "A nom"

  @sections-duplicate @duplicate
  Scenario: Create Duplicate Section
    Given I only have sections titled UniqueTitleOne, UniqueTitleTwo
    When I go to the list of sections
    And I follow "Add New Section"
    And I fill in "Nom" with "UniqueTitleTwo"
    And I press "Save"
    Then I should see "There were problems"
    And I should have 2 sections

  @sections-delete @delete
  Scenario: Delete Section
    Given I only have sections titled UniqueTitleOne
    When I go to the list of sections
    And I follow "Remove this section forever"
    Then I should see "'UniqueTitleOne' was successfully removed."
    And I should have 0 sections
 