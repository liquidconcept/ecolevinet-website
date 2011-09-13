@actualites
Feature: Actualites
  In order to have actualites on my website
  As an administrator
  I want to manage actualites

  Background:
    Given I am a logged in refinery user
    And I have no actualites

  @actualites-list @list
  Scenario: Actualites List
   Given I have actualites titled UniqueTitleOne, UniqueTitleTwo
   When I go to the list of actualites
   Then I should see "UniqueTitleOne"
   And I should see "UniqueTitleTwo"

  @actualites-valid @valid
  Scenario: Create Valid Actualite
    When I go to the list of actualites
    And I follow "Add New Actualite"
    And I fill in "Title" with "This is a test of the first string field"
    And I press "Save"
    Then I should see "'This is a test of the first string field' was successfully added."
    And I should have 1 actualite

  @actualites-invalid @invalid
  Scenario: Create Invalid Actualite (without title)
    When I go to the list of actualites
    And I follow "Add New Actualite"
    And I press "Save"
    Then I should see "Title can't be blank"
    And I should have 0 actualites

  @actualites-edit @edit
  Scenario: Edit Existing Actualite
    Given I have actualites titled "A title"
    When I go to the list of actualites
    And I follow "Edit this actualite" within ".actions"
    Then I fill in "Title" with "A different title"
    And I press "Save"
    Then I should see "'A different title' was successfully updated."
    And I should be on the list of actualites
    And I should not see "A title"

  @actualites-duplicate @duplicate
  Scenario: Create Duplicate Actualite
    Given I only have actualites titled UniqueTitleOne, UniqueTitleTwo
    When I go to the list of actualites
    And I follow "Add New Actualite"
    And I fill in "Title" with "UniqueTitleTwo"
    And I press "Save"
    Then I should see "There were problems"
    And I should have 2 actualites

  @actualites-delete @delete
  Scenario: Delete Actualite
    Given I only have actualites titled UniqueTitleOne
    When I go to the list of actualites
    And I follow "Remove this actualite forever"
    Then I should see "'UniqueTitleOne' was successfully removed."
    And I should have 0 actualites
 