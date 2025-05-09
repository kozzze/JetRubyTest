require 'minitest/autorun'
require_relative 'Cargo'

class CargoTest < Minitest::Test
  def setup
    @cargo = Cargo.allocate
    @cargo.instance_variable_set(:@from, 'TestFrom')
    @cargo.instance_variable_set(:@to, 'TestTo')
    @cargo.instance_variable_set(:@distance, 100)
  end

  def test_volume_calculation
    @cargo.instance_variable_set(:@lenght, 50)
    @cargo.instance_variable_set(:@width, 50)
    @cargo.instance_variable_set(:@height, 50)
    assert_in_delta 0.125, @cargo.calc_lovume, 0.001
  end

  def test_price_under_1m3
    @cargo.instance_variable_set(:@weigth, 5)
    @cargo.instance_variable_set(:@lenght, 50)
    @cargo.instance_variable_set(:@width, 50)
    @cargo.instance_variable_set(:@height, 50)
    assert_equal 100.0, @cargo.calculate_price
  end

  def test_price_over_1m3_light_weight
    @cargo.instance_variable_set(:@weigth, 9)
    @cargo.instance_variable_set(:@lenght, 120)
    @cargo.instance_variable_set(:@width, 100)
    @cargo.instance_variable_set(:@height, 100)
    assert_in_delta 1.2, @cargo.calc_lovume, 0.01
    assert_equal 200.0, @cargo.calculate_price
  end

  def test_price_over_1m3_heavy
    @cargo.instance_variable_set(:@weigth, 20)
    @cargo.instance_variable_set(:@lenght, 120)
    @cargo.instance_variable_set(:@width, 100)
    @cargo.instance_variable_set(:@height, 100)
    assert_in_delta 1.2, @cargo.calc_lovume, 0.01
    assert_equal 300.0, @cargo.calculate_price
  end
end