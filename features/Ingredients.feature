Feature: Ingredients
  As a chef
  I want to manage ingredients
  So that I can save and later tie them to recipes

  Scenario: Listing all ingredients
    Given there are some ingredients
    When I dispatch the GET request passing no parameters
    Then I should receive all the ingredients

#  Scenario: Creating an ingredient
#    When I dispatch the request with the ingredient name
#    Then the ingredient must be stored
#    And I should receive its id

#  Scenario: Removing an ingredient
#    Given the ingredient I am trying to remove exists
#    When I dispatch a remove request with the id
#    Then the ingredient must be removed

#  Scenario: Updating an ingredient
#    Given the ingredient I am trying to update exists
#    When I dispatch an update request passing the ingredient id and the new data
#    Then the ingredient should be updated

#  Scenario: Getting a single ingredient
#    Given the ingredient I am trying to read exists
#    When I dispatch a request passing the ingredient id
#    Then I should receive the ingredient data

#  Scenario: Removing all ingredients
#    Given there are some ingredients
#    When I dispatch the request
#    Then all ingredients must be removed
