Feature: Home page

  Scenario: Viewing application's home page
    Given there's a post with "Hello, BDD world!" content
    When I am on the homepage
    Then I should see the "Hello, BDD world!" post
