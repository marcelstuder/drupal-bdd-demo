@api
Feature: Login displays a welcome message
  As a known user to the website
  I want to see a welcome message after login
  So that I feel home

  @javascript @init @check
  Scenario: check the welcome message at the homepage
    Given I am an anonymous user
    When I am logged in as an Administrator
    Then a mail has been sent to "banana@example.com" with the subject "Sample mail"
    And I should see the message "Whoa! It würgs!"
