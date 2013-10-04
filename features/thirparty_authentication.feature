Feature: Authentication with third party service

  Scenario Outline: The user create an account with third party and login
    Given @flynn isn't in the system
    When I authenticate on "<service>" with "Flynn" account
    Then I should see "Your account has been created."

    Examples:
      | service  |
      | Twitter  |
      | Google   |
      | Facebook |


  Scenario Outline: The user can link their account with another third party and login
    Given @flynn is in the system
    When I authenticate on "<service>" with "Flynn" account
    And this "<service>" is not linked with "Flynn" account
    Then I should see "Your account has been linked."
    Examples:
      | service  |
      | Twitter  |
      | Google   |
      | Facebook |

  Scenario Outline: The user can link their account with another third party and login
    Given @flynn is in the system
    When I authenticate on "<service>" with "Flynn" account
    And this "<service>" is already linked with "Flynn" account
    Then I should see "Logged in successfully"

    Examples:
      | service  |
      | Twitter  |
      | Google   |
      | Facebook |