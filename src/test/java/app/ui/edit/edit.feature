Feature:

  Background:
    * def session = { capabilities: { browserName: 'chrome' }, desiredCapabilities: { browserName: 'chrome' } }
    * driver { type: 'chromedriver', webDriverSession: '#(session)', start: false, webDriverUrl: '#(hub)' }
#  Background:
#    * configure driver = { type: 'chrome' }

  Scenario:
    * driver 'http://localhost:8080'
    * input('input[name=title]', 'Task One' + Key.ENTER)
    * waitFor('.border-bottom div').mouse().doubleClick()
    * waitFor('.border-bottom input').clear().input('Task Edit')
    * mouse('h1').click()
    * waitForText('.border-bottom', 'Task Edit')
