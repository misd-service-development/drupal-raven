Feature: Website description

  Scenario: Can configure website description
    Given the "raven_website_description" variable is set to "NULL"
    And I am logged in as the admin user
    And I am on "/admin/config/people/raven"
    When I fill in "Your website description" with "Website Description"
    And I press "Save configuration"
    Then the "raven_website_description" variable should be "Website Description"

  Scenario: Uses site name when not set
    Given the "site_name" variable is set to "My Site Name"
    When I go to "/raven/login"
    Then I should see "My Site Name"

  Scenario: Uses website description when site
    Given the "site_name" variable is set to "My Site Name"
    And the "raven_website_description" variable is set to "Website Description"
    When I go to "/raven/login"
    Then I should see "Website Description"
    And I should not see "My Site Name"

  Scenario: Encodes website description
    Given the "raven_website_description" variable is set to "Foo & Bar"
    When I go to "/raven/login"
    Then I should see "Foo & Bar"
