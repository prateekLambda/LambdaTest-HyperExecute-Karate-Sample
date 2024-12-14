Feature: Flaky Test Example

Scenario:
  * def urlBase = 'http://localhost:' + karate.start({ mock: 'mock.feature', pathPrefix: '/api' }).port
  * def retryCounter = karate.get('retryCounter') || 0
  * if (retryCounter < 1) karate.set('retryCounter', retryCounter + 1)
  * if (retryCounter < 1) karate.fail('Flaky failure on the first run')
  * call read('../api/simple/simple.feature')
