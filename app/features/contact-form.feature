Feature: Contact form
  In order to send a message to the site administrators
  As a visitor
  I should be able to use the site-wide contact form

  @javascript
  Scenario: A visitor can use the site-wide contact form
    Given I am at "contact/feedback"
    When I fill in "name" with "Jane Doe"
    And I fill in "mail" with "john@doe.com"
    And I fill in "subject[0][value]" with "Hello world"
    And I fill in "message[0][value]" with "Lorem Ipsum"
    And I press "Send message"
    Then I should see the text "Your message has been sent."

  @wip
  Scenario: A visitor couldn't send a message with a bad email address
    Given I am at "contact/feedback"
    When I fill in the following:
    |name               |John Doe         |
    |mail               |john#doe         |
    |subject[0][value]  |Hello world      |
    |message[0][value]  |Lorem Ipsum      |
    And I press "Send message"
    Then I should see an error message
