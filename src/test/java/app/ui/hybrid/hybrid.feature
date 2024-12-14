Feature:

  Background:
    * def session = { capabilities: { browserName: 'chrome' }, desiredCapabilities: { browserName: 'chrome' } }
    * driver { type: 'chromedriver', webDriverSession: '#(session)', start: false, webDriverUrl: '#(hub)' }
#  Background:
#    * configure driver = { type: 'chrome' }

  Scenario:
    * driver 'http://localhost:8080'
    * def find = read('find.js')
    * input('input[name=title]', 'One' + Key.ENTER)
    * def id = waitUntil(() => find('One'))
    * print 'created id:', id

    * url 'http://localhost:8080/api/todos'
    * path id
    * method get
    * status 200
    * match response == { id: '#(id)', title: 'One', complete: false }
