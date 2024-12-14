Feature:

  Background:
    * def session = { capabilities: { browserName: 'chrome' }, desiredCapabilities: { browserName: 'chrome' } }
    * driver { type: 'chromedriver', webDriverSession: '#(session)', start: false, webDriverUrl: '#(hub)' }
#  Background:
#    * configure driver = { type: 'chrome' }

  Scenario:
    * driver 'http://localhost:8080'
    * input('input[name=title]', 'Task One' + Key.ENTER)
    * waitForText('.border-bottom', 'Task One')
    * waitFor('button').click()
    * waitUntil(() => locateAll('.border-bottom').length == 0)
