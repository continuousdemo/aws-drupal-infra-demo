<?php

namespace Drupal\custom_unit_tests\Controller;

use Drupal\Core\Controller\ControllerBase;

/**
 * Returns responses for custom_unit_tests routes.
 */
class CustomUnitTestsController extends ControllerBase {

  /**
   * Builds the response.
   */
  public function build() {

    $build['content'] = [
      '#type' => 'item',
      '#markup' => $this->t('It works!'),
    ];

    return $build;
  }

}
