Feature: Raven failure

  Scenario: Can configure Raven failure redirect path
    Given the "raven_login_fail_redirect" variable is set to "NULL"
    And I am logged in as the admin user
    And I am on "/admin/config/people/raven"
    When I fill in "Login failure redirect" with "foo"
    And I press "Save configuration"
    Then the "raven_login_fail_redirect" variable should be "foo"

  Scenario: Redirects on failure
    Given the "raven_login_fail_redirect" variable is set to "foo"
    When I go to "/raven/auth"
    Then I should be on "/foo"

  Scenario: Pressing cancel fails gracefully
    Given I am on "/raven/login"
    When I press "Cancel"
    Then I should see "Raven authentication cancelled"

  Scenario: 'kid' problem causes failure
    Given the "dblog" module is enabled
    And I have a Raven response with a "kid" problem
    Then I should see "Suspicious login attempt denied and logged"
    And I should see an "alert" "raven" Watchdog message "Suspicious login attempt claiming to be test0001. 'kid' validation failed: expecting '901', got '999'."

  Scenario: URL problem causes failure
    Given the "dblog" module is enabled
    And I have a Raven response with a "url" problem
    Then I should see "Suspicious login attempt denied and logged"
    And I should see an "alert" "raven" Watchdog message "Suspicious login attempt claiming to be test0001. 'url' validation failed"

  Scenario: 'auth' problem causes failure
    Given the "dblog" module is enabled
    And I have a Raven response with an "auth" problem
    Then I should see "Suspicious login attempt denied and logged"
    And I should see an "alert" "raven" Watchdog message "Suspicious login attempt claiming to be test0001. 'auth' validation failed: expecting 'pwd', got 'test'."

  Scenario: 'sso' problem causes failure
    Given the "dblog" module is enabled
    And I have a Raven response with an "sso" problem
    Then I should see "Suspicious login attempt denied and logged"
    And I should see an "alert" "raven" Watchdog message "Suspicious login attempt claiming to be test0001. 'sso' validation failed: expecting 'pwd', got 'test'."

  Scenario: Invalid response causes failure
    Given the "dblog" module is enabled
    And I have a Raven response with an "invalid" problem
    Then I should see "Raven authentication failure."
    And I should see an "error" "raven" Watchdog message "Authentication failure: Successful authentication."

  Scenario: Incomplete response causes failure
    Given the "dblog" module is enabled
    And I have a Raven response with an "incomplete" problem
    Then I should see "Suspicious login attempt denied and logged"
    And I should see an "alert" "raven" Watchdog message "Suspicious login attempt. Raven response is not acceptable"

  Scenario: Expired response causes failure
    Given the "dblog" module is enabled
    And I have a Raven response with an "expired" problem
    Then I should see "Login attempt timed out."
    And I should see a "warning" "raven" Watchdog message "Timeout on login attempt for test0001"
