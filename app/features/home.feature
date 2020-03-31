Feature: Basic Homepage test
  In order to see title on homepage
  As a visitor
  I should see title on the home page

  Scenario: A visitor can see title on the home page
    Given I am at "/"
    Then I should see the text "Welcome to DRUPAL-EPHEMERAL-DEMO"
