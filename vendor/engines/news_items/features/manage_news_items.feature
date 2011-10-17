@news_items
Feature: News Items
  In order to have news_items on my website
  As an administrator
  I want to manage news_items

  Background:
    Given I am a logged in refinery user
    And I have no news_items

  @news_items-list @list
  Scenario: News Items List
   Given I have news_items titled UniqueTitleOne, UniqueTitleTwo
   When I go to the list of news_items
   Then I should see "UniqueTitleOne"
   And I should see "UniqueTitleTwo"

  @news_items-valid @valid
  Scenario: Create Valid News Item
    When I go to the list of news_items
    And I follow "Add New News Item"
    And I fill in "Title" with "This is a test of the first string field"
    And I press "Save"
    Then I should see "'This is a test of the first string field' was successfully added."
    And I should have 1 news_item

  @news_items-invalid @invalid
  Scenario: Create Invalid News Item (without title)
    When I go to the list of news_items
    And I follow "Add New News Item"
    And I press "Save"
    Then I should see "Title can't be blank"
    And I should have 0 news_items

  @news_items-edit @edit
  Scenario: Edit Existing News Item
    Given I have news_items titled "A title"
    When I go to the list of news_items
    And I follow "Edit this news_item" within ".actions"
    Then I fill in "Title" with "A different title"
    And I press "Save"
    Then I should see "'A different title' was successfully updated."
    And I should be on the list of news_items
    And I should not see "A title"

  @news_items-duplicate @duplicate
  Scenario: Create Duplicate News Item
    Given I only have news_items titled UniqueTitleOne, UniqueTitleTwo
    When I go to the list of news_items
    And I follow "Add New News Item"
    And I fill in "Title" with "UniqueTitleTwo"
    And I press "Save"
    Then I should see "There were problems"
    And I should have 2 news_items

  @news_items-delete @delete
  Scenario: Delete News Item
    Given I only have news_items titled UniqueTitleOne
    When I go to the list of news_items
    And I follow "Remove this news item forever"
    Then I should see "'UniqueTitleOne' was successfully removed."
    And I should have 0 news_items
 