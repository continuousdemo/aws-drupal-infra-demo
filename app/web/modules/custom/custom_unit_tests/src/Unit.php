<?php

namespace Drupal\custom_unit_tests;

/**
 * Defines a Unit class.
 */
class Unit {
  /**
   * Length of the unit.
   *
   * @var int
   */
  private $length = 0;

  /**
   * Set the length of unit.
   *
   * @param int $length
   *   Length of the unit.
   */
  public function setLength(int $length) {
    $this->length = $length;
  }

  /**
   * Get the length of unit.
   *
   * @return int
   *   The length of the unit.
   */
  public function getLength() {
    return $this->length;
  }

}
