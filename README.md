# Running acceptance tests in Drupal

This repository documents my first steps on how to run acceptance tests in Drupal using [bhat](https://behat.org/) (Gherkin-Style php testing framework for business expectations).

## Setup in a local DDEV environment

### Prerequisites

Install a new Drupal instance. You can find detailed instructions in the [quickstart section of the DDEV documentation](https://ddev.readthedocs.io/en/latest/users/quickstart/).

### Modules/packages/tools

When using acceptance testing in Drupal thes libraries/packages come into play:

- [behat - php testing framework for business expectations](https://behat.org/)
- [mink - open source browser controller/emulator for web applications](https://mink.behat.org/en/latest/)
- [behat Drupal extension - contains step definitions for common drupal scenarios](https://behat-drupal-extension.readthedocs.io/en/stable/intro.html)
    - installs behat and mink, tests can be run on the console
- [behat UI](https://www.drupal.org/project/behat_ui)
    - Graphical UI for running the tests in Drupal
    - installs behat, mink and behat drupal extension

### Example: installation using behat ui

In this example we use behat ui to install the graphical ui for behat tests as well as all other components (behat, mink, behat drupal extensions). This allows to both run tests from the shell as well as using the graphical UI. 

I will also performi UI tests using the behat framework in combination with a selenium web driver. There are some scenarios where UI tests are helpful/valuable. However, it is highly recommended to respect the test pyramid and use behat primarily for testing business expectations (without testing the UI). Tests that are independent from the UI are less likely to change than UI tests.

Note: In this example the composer commands are being run from outside of the Drupal container. Therefore the commands start with `ddev composer require` instead of `composer require`. As an alternative you can *ssh* into the container using `ddev ssh` and then run the composer commands directly (`composer require` instead of `ddev composer require`).

- Open a new terminal window
- Change into the folder of your newly created Drupal DDEV instance
- Install *behat UI*: `ddev composer require drupal/behat_ui`
- Install additional tools:
    - *behat html formatter* to generate a test results report in HTML: `ddev composer require --dev emuse/behat-html-formatter`
    - *behat screenshot* in order to capture screenshots: `ddev composer require --dev drevops/behat-screenshot`
- Install tools for browser automation/UI tests
    - Install selenium driver for browser automation: `ddev composer require behat/mink-selenium2-driver --dev`
    - Copy the following yaml files into your `.ddev` folder (e.g. `my-drupal9-site/.ddev`) in order to run a selenium container when using your local ddev installation: 
        - [docker-compose.selenium.yaml](.ddev/docker-compose.selenium.yaml)
        - [docker-compose.override.yaml](.ddev/docker-compose.override.yaml)
- Restart your ddev instance so that your newly configured selenium container will also run: `ddev restart`
- *ssh* into your container: `ddev ssh`
- Initialize behat: `behat --init` (this will create a folder features where you can store your tests)
- Close the *ssh* connection: `exit`
- Copy the *sample feature* (`sample.feature`) into the features folder (e.g. `my-drupal9-site/features`)

### Run the test on the shell

- *ssh* into the container: `ddev ssh`
- Run the test using the console output (default when using the provided `behat.yml` is the html formatter): `behat --format pretty`
