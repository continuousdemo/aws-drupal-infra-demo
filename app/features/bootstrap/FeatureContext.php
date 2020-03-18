<?php

use Behat\Behat\Context\Context;
use Behat\MinkExtension\Context\RawMinkContext;
use Behat\Behat\Hook\Scope\AfterScenarioScope;
use Behat\Testwork\Hook\Scope\BeforeSuiteScope;

/**
 * Defines application features from the specific context.
 */
class FeatureContext extends RawMinkContext implements Context {

  /**
   * Initializes context.
   *
   * Every scenario gets its own context instance.
   * You can also pass arbitrary arguments to the
   * context constructor through behat.yml.
   */
  public function __construct() {
  }

  /**
   * Check if email related error message is displayed.
   *
   * @Then I should see an error message
   */
  public function iShouldSeeAnErrorMessage() {
    $this->assertSession()->pageTextMatches("/The email address .+ is not valid\./ui");
  }

  /**
   * Cleanup Snapshot directory.
   *
   * @BeforeSuite
   */
  public static function cleanupSnapshot(BeforeSuiteScope $scope) {
    if (!file_exists('../logs/screenshots')) {
      mkdir('../logs/screenshots', 0777, TRUE);
    }
    else {
      $screenshots = glob('../logs/screenshots/*.png');
      if ($screenshots) {
        foreach ($screenshots as $screenshot) {
          unlink($screenshot);
        }
      }
    }
  }

  /**
   * Create a snapshot for debugging purpose.
   *
   * @AfterScenario @javascript
   */
  public function doSnapshot(AfterScenarioScope $scope) {
    $file_name = '../logs/screenshots/' . basename($scope->getFeature()->getFile()) . '-' . $scope->getScenario()->getTitle() . '.png';
    if (!$scope->getTestResult()->isPassed()) {
      $image = $this->getSession()->getScreenshot();
      file_put_contents($file_name, $image);
    }
  }

  /**
   * Print screen as text for debugging purpose.
   *
   * @AfterScenario
   */
  public function printScreen(AfterScenarioScope $scope) {
    if (!$scope->getTestResult()->isPassed()) {
      $screen = $this->getSession()->getPage()->getText();
      throw new \Exception($screen);
    }
  }

}
