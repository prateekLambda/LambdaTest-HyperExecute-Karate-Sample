Feature:

  Background:
    * def session = { capabilities: { browserName: 'chrome' }, desiredCapabilities: { browserName: 'chrome' } }
    * driver { type: 'chromedriver', webDriverSession: '#(session)', start: false, webDriverUrl: '#(hub)' }
#  Background:
#    * configure driver = { type: 'chrome' }

  Scenario:
    * driver 'http://localhost:8080'
    * call read('called.feature')

