Feature: Authentication with third party service

  Scenario Outline: The user can link their account with third party and login
    Given @charles exists and is logged in
    And I go to the projects page
    When I authenticate on "<service>" with "Charles" account
    Then I should see "Your account has been linked."
    And I log out
    And I authenticate on "<service>" with "Charles" account
    Then I should see "Logged in successfully"

    Examples:
      | service  |
      | Twitter  |
      | Google   |
      | Facebook |