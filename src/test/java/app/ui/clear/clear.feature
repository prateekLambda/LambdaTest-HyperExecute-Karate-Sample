@ignore
Feature:

  Background:
    * def session = { capabilities: { browserName: 'chrome' }, desiredCapabilities: { browserName: 'chrome' } }
    * driver { type: 'chromedriver', webDriverSession: '#(session)', start: false, webDriverUrl: '#(hub)' }
#  Background:
#    * configure driver = { type: 'chrome' }

  Scenario:
    * driver 'http://localhost:8080'
    * if (locateAll('.border-bottom').length == 0) karate.abort()
    * click('.form-switch input')
    * click('{}Clear Completed')
    * waitUntil(() => locateAll('.border-bottom').length == 0)
