<img height="100" alt="hyperexecute_logo" src="https://user-images.githubusercontent.com/1688653/159473714-384e60ba-d830-435e-a33f-730df3c3ebc6.png">

HyperExecute is a smart test orchestration platform to run end-to-end Selenium tests at the fastest speed possible. HyperExecute lets you achieve an accelerated time to market by providing a test infrastructure that offers optimal speed, test orchestration, and detailed execution logs.

The overall experience helps teams test code and fix issues at a much faster pace. HyperExecute is configured using a YAML file. Instead of moving the Hub close to you, HyperExecute brings the test scripts close to the Hub!

* <b>HyperExecute HomePage</b>: https://www.lambdatest.com/hyperexecute
* <b>Lambdatest HomePage</b>: https://www.lambdatest.com
* <b>LambdaTest Support</b>: [support@lambdatest.com](mailto:support@lambdatest.com)

To know more about how HyperExecute does intelligent Test Orchestration, do check out [HyperExecute Getting Started Guide](https://www.lambdatest.com/support/docs/getting-started-with-hyperexecute/)

[<img alt="Try it now" width="200 px" align="center" src="images/Try it Now.svg" />](https://hyperexecute.lambdatest.com/?utm_source=github&utm_medium=repository&utm_content=java&utm_term=testng)


## Gitpod

Follow the below steps to run Gitpod button:

1. Click '**Open in Gitpod**' button (You will be redirected to Login/Signup page).
2. Login with Lambdatest credentials and it will be redirected to Gitpod editor in new tab and current tab will show hyperexecute dashboard.

[<img alt="Run in Gitpod" width="200 px" align="center" src="images/Gitpod.svg" />](https://hyperexecute.lambdatest.com/hyperexecute/jobs?type=gitpod&framework=Karate)
---
<!---If logged in, it will be redirected to Gitpod editor in new tab where current tab will show hyperexecute dashboard.

If not logged in, it will be redirected to Login/Signup page and simultaneously redirected to Gitpod editor in a new tab where current tab will show hyperexecute dashboard.

If not signed up, you need to sign up and simultaneously redirected to Gitpod in a new tab where current tab will show hyperexecute dashboard.--->


# How to run Selenium automation tests on HyperExecute (using Karate framework)

* [Pre-requisites](#pre-requisites)
   - [Download HyperExecute CLI](#download-hyperexecute-cli)
   - [Configure Environment Variables](#configure-environment-variables)

* [Auto-Split Execution with Karate](#auto-split-execution-with-testng)
   - [Core](#core)
   - [Pre Steps and Dependency Caching](#pre-steps-and-dependency-caching)
   - [Post Steps](#post-steps)
   - [Artifacts Management](#artifacts-management)
   - [Test Execution](#test-execution)

* [Matrix Execution with Karate](#matrix-execution-with-testng)
   - [Core](#core-1)
   - [Pre Steps and Dependency Caching](#pre-steps-and-dependency-caching-1)
   - [Post Steps](#post-steps-1)
   - [Artifacts Management](#artifacts-management-1)
   - [Test Execution](#test-execution-1)

* [Secrets Management](#secrets-management)
* [Navigation in Automation Dashboard](#navigation-in-automation-dashboard)

# Pre-requisites

Before using HyperExecute, you have to download HyperExecute CLI corresponding to the host OS. Along with it, you also need to export the environment variables *LT_USERNAME* and *LT_ACCESS_KEY* that are available in the [LambdaTest Profile](https://accounts.lambdatest.com/detail/profile) page.

## Download HyperExecute CLI

HyperExecute CLI is the CLI for interacting and running the tests on the HyperExecute Grid. The CLI provides a host of other useful features that accelerate test execution. In order to trigger tests using the CLI, you need to download the HyperExecute CLI binary corresponding to the platform (or OS) from where the tests are triggered:

Also, it is recommended to download the binary in the project's parent directory. Shown below is the location from where you can download the HyperExecute CLI binary:

* Mac: https://downloads.lambdatest.com/hyperexecute/darwin/hyperexecute
* Linux: https://downloads.lambdatest.com/hyperexecute/linux/hyperexecute
* Windows: https://downloads.lambdatest.com/hyperexecute/windows/hyperexecute.exe

## Configure Environment Variables

Before the tests are run, please set the environment variables LT_USERNAME & LT_ACCESS_KEY from the terminal. The account details are available on your [LambdaTest Profile](https://accounts.lambdatest.com/detail/profile) page.

For macOS:

```bash
export LT_USERNAME=LT_USERNAME
export LT_ACCESS_KEY=LT_ACCESS_KEY
```

For Linux:

```bash
export LT_USERNAME=LT_USERNAME
export LT_ACCESS_KEY=LT_ACCESS_KEY
```

For Windows:

```bash
set LT_USERNAME=LT_USERNAME
set LT_ACCESS_KEY=LT_ACCESS_KEY
```

## Auto-Split Execution with Karate

Auto-split execution mechanism lets you run tests at predefined concurrency and distribute the tests over the available infrastructure. Concurrency can be achieved at different levels - file, module, test suite, test, scenario, etc.

For more information about auto-split execution, check out the [Auto-Split Getting Started Guide](https://www.lambdatest.com/support/docs/getting-started-with-hyperexecute/#smart-auto-test-splitting)

### Core

Auto-split YAML file (*yaml/testng_hyperexecute_autosplit_sample.yaml*) in the repo contains the following configuration:

```yaml
globalTimeout: 150
testSuiteTimeout: 150
testSuiteStep: 150
```

Global timeout, testSuite timeout, and testSuite timeout are set to 150 minutes.
 
The *runson* key determines the platform (or operating system) on which the tests are executed. Here we have set the target OS as Linux.

```yaml
runson: linux
```

Auto-split is set to true in the YAML file.

```yaml
 autosplit: true
```

*retryOnFailure* is set to true, instructing HyperExecute to retry failed command(s). The retry operation is carried out till the number of retries mentioned in *maxRetries* are exhausted or the command execution results in a *Pass*. In addition, the concurrency (i.e. number of parallel sessions) is set to 4.

```yaml
retryOnFailure: true
maxRetries: 5
concurrency: 4
```

### Pre Steps and Dependency Caching

Dependency caching is enabled in the YAML file to ensure that the package dependencies are not downloaded in subsequent runs. The first step is to set the Key used to cache directories. The directory *m2_cache_dir* is created in the project's root directory.

```yaml
env:
  CACHE_DIR: m2_cache_dir

# Dependency caching for Windows
cacheKey: '{{ checksum "pom.xml" }}'
cacheDirectories:
  - $CACHE_DIR
```

Steps (or commands) that must run before the test execution are listed in the *pre* run step. In the example, the Maven packages are downloaded in the *m2_cache_dir*. To prevent test execution at the *pre* stage, the *maven.test.skip* parameter is set to *true* so that only packages are downloaded and no test execution is performed.

```yaml
pre:
  - mvn -Dmaven.repo.local=$CACHE_DIR -Dmaven.test.skip=true clean install
```

### Post Steps

Steps (or commands) that need to run after the test execution are listed in the *post* step. In the example, we *cat* the contents of *yaml/testng_hyperexecute_autosplit_sample.yaml*

```yaml
post:
  - curl http://localhost:8080/__admin/stop
```

The *testDiscovery* directive contains the command that gives details of the mode of execution, along with detailing the command that is used for test execution. Here, we are fetching the list of class names that would be further passed in the *testRunnerCommand*

```yaml
testDiscovery:
  type: raw
  mode: static
  command: snooper  --targetOs=win --featureFilePaths=src/test/java/app --frameWork=java  | sed 's/:.*//' | uniq
```

Running the above command on the terminal will give a list of scenarios present in the *feature* files:

    src/test/java/app/api/call/call-data-four.feature
    src/test/java/app/api/call/call-data-one.feature
    src/test/java/app/api/call/call-data-single.feature
    src/test/java/app/api/call/call-data-two.feature
    src/test/java/app/api/call/call-data.feature
    src/test/java/app/api/call/call-four.feature
    src/test/java/app/api/call/call-one.feature

The *testRunnerCommand* contains the command that is used for triggering the test. The output fetched from the *testDiscoverer* command acts as an input to the *testRunner* command.

```yaml
testRunnerCommand: mvn `-Dmaven.repo.local=$CACHE_DIR `-Dtest=$test
```

### Artifacts Management

The *mergeArtifacts* directive (which is by default *false*) is set to *true* for merging the artifacts and combing artifacts generated under each task.

The *uploadArtefacts* directive informs HyperExecute to upload artifacts [files, reports, etc.] generated after task completion. In the example, *path* consists of a regex for parsing the sure-fire (i.e. *target/surefire-reports/html*) directory that contains the HTML test reports.

```yaml
mergeArtifacts: true

uploadArtefacts:
  - name: ExecutionSnapshots
    path:
      - target/
```

HyperExecute also facilitates the provision to download the artifacts on your local machine. To download the artifacts, click on Artifacts button corresponding to the associated TestID.

<img width="1425" alt="testng_autosplit_artifacts_1" src="https://user-images.githubusercontent.com/1688653/160457854-5730c0bd-9ce0-483d-b727-f10f148c1c11.png">

Now, you can download the artifacts by clicking on the Download button as shown below:

<img width="1425" alt="testng_autosplit_artefacts_2" src="https://user-images.githubusercontent.com/1688653/160457858-be8f3e89-fe85-4f24-b8ad-5e9570321b3c.png">

### Test Execution

The CLI option *--config* is used for providing the custom HyperExecute YAML file (i.e. *Hyperexecute.yaml* for Linux).

#### Execute Karate tests using Autosplit mechanism on Linux platform

Run the following command on the terminal to trigger the tests in Java files with HyperExecute platform set to Windows. The *--download-artifacts* option is used to inform HyperExecute to download the artifacts for the job. The *--force-clean-artifacts* option force cleans any existing artifacts for the project.

```bash
./hyperexecute --config Hyperexecute.yaml --force-clean-artifacts --download-artifacts
```


Visit [HyperExecute Automation Dashboard](https://automation.lambdatest.com/hyperexecute) to check the status of execution

<img width="1414" alt="testng_autosplit_execution" src="https://user-images.githubusercontent.com/1688653/160457854-5730c0bd-9ce0-483d-b727-f10f148c1c11.png">

Shown below is the execution screenshot when the YAML file is triggered from the terminal:

<img width="1412" alt="testng_autosplit_cli1_execution" src="https://user-images.githubusercontent.com/1688653/159758845-acae3fbe-c04f-4c0d-8c20-af39affcc3cd.png">

<img width="1408" alt="testng_autosplit_cli2_execution" src="https://user-images.githubusercontent.com/1688653/159758849-dd181170-b31a-4589-80ac-e0592122a0c9.png">

