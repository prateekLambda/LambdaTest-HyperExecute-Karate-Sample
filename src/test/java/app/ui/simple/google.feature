Feature: browser automation demo

Background:
	* def session = { capabilities: { browserName: 'chrome' }, desiredCapabilities: { browserName: 'chrome' } }
	* configure driver = { type: 'chromedriver', webDriverSession: '#(session)', start: false, webDriverUrl: '#(hub)' }

  Scenario: try to login to github
    and then do a google search

    Given driver 'https://github.com/login'
    And input('#login_field', 'XXXX')
    And input('#password', 'world')
    When submit().click("input[name=commit]")
    Then match html('.flash-error') contains 'Incorrect username or password.'
    And screenshot()

    Given driver 'https://google.com'
    And input("#APjFqb", 'karate dsl')
    When submit().click("input[name=btnI]")
    Then waitForUrl('https://github.com/karatelabs/karate')
