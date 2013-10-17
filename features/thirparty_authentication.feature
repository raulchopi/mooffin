Feature: Authentication with third party service

  Scenario Outline: The user create an account with third party and login
    Given I visit the home page
    When I try to sign up with "<service>"
    And I authenticate on "<service>" with "Flynn" account
    Then I should redirect to my new profile page
    And I should see "Your account has been created."

    Examples:
      | service        |
      | Twitter        |
      | Google_oauth2  |
      | Facebook       |


  Scenario Outline: The user can link their account with another third party and login
    Given I visit the home page
    When I try to sign in with "<service>"
    And I authenticate on "<service>" with "Flynn" account
    And this "<service>" is not linked with "Flynn" account
    Then I should redirect to my new profile page
    And I should see "Your account has been linked."
    Examples:
      | service        |
      | Twitter        |
      | Google_oauth2  |
      | Facebook       |

  Scenario Outline: The user login in the system with an existing account
    Given I visit the home page
    When I try to sign in with "<service>"
    And I authenticate on "<service>" with "Flynn" account
    And this "<service>" is already linked with "Flynn" account
    Then I should redirect to my new profile page
    And I should see "Logged in successfully"

    Examples:
      | service        |
      | Twitter        |
      | Google_oauth2  |
      | Facebook       |
      