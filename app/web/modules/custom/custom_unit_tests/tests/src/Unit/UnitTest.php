<?php

namespace Drupal\Tests\custom_unit_tests\Unit;

use Drupal\Tests\UnitTestCase;
use Drupal\custom_unit_tests\Unit;

/**
 * Simple test to ensure that asserts pass.
 *
 * @group custom_unit_tests
 */
class UnitTest extends UnitTestCase {
  /**
   * Unit instance.
   *
   * @var \Drupal\custom_unit_tests\Unit
   */
  protected $unit;

  /**
   * Before a test method is run, setUp() is invoked.
   *
   * Create new unit object.
   */
  public function setUp() {
    $this->unit = new Unit();
  }

  /**
   * @covers Drupal\custom_unit_tests\Unit::setLength
   */
  public function testSetLength() {
    $this->assertEquals(0, $this->unit->getLength());
    $this->unit->setLength(9);
    $this->assertEquals(9, $this->unit->getLength());
  }

  /**
   * @covers Drupal\custom_unit_tests\Unit::getLength
   */
  public function testGetLength() {
    $this->unit->setLength(9);
    $this->assertNotEquals(10, $this->unit->getLength());
  }

}
