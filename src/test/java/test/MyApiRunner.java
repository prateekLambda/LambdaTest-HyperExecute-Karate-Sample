package test;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import com.intuit.karate.junit5.Karate;

import static org.junit.jupiter.api.Assertions.assertEquals;

class MyApiRunner {
    @Karate.Test
    Karate testAll() {
        Results results = Runner.path(System.getProperty("FeaturePath"))
                .outputCucumberJson(true)
                .parallel(1);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
        return Karate.run(System.getProperty("FeaturePath"));


    }

}