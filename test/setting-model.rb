require "cutest"
require "ohm"
require "./settings-ohm"

setup do
	Ohm.connect(:db => 5)
end

prepare do
	Ohm.flush
end

test "new setting has nil data" do
	assert_equal Setting[:testing], nil
end

test "trying to create setting _not_ using symbol as identifier returns false" do
	assert_equal Setting["string"], false
	assert_equal Setting[1], false
	assert_equal Setting[1.1], false
end

test "return the data after creating new setting using assignment (string)" do
	test_data = "string"
	assert_equal Setting[:data] = test_data, test_data
	assert Setting[:data].is_a? String
end


test "return the data after creating new setting using assignment (integer)" do
	test_data = 23
	assert_equal Setting[:data] = test_data, test_data
	assert Setting[:data].kind_of? Integer
end


test "return the data after creating new setting using assignment (float)" do
	test_data = 4.2
	assert_equal Setting[:data] = test_data, test_data
	assert Setting[:data].is_a? Float
end

test "return the data after creating new setting using assignment (false)" do
	test_data = false
	assert_equal Setting[:data] = test_data, test_data
	assert Setting[:data].is_a? FalseClass
end

test "return the data after creating new setting using assignment (true)" do
	test_data = true
	assert_equal Setting[:data] = test_data, test_data
	assert Setting[:data].is_a? TrueClass
end

test "retrieve formerly saved setting (string)" do
	test_string = "string"
	Setting[:string] = test_string
	assert_equal Setting[:string], test_string
end

test "retrieve formerly saved setting (integer)" do
	test_int = 42
	Setting[:int] = test_int
	assert_equal Setting[:int], test_int
end

test "retrieve formerly saved setting (float)" do
	test_float = 23.23
	Setting[:float] = test_float
	assert_equal Setting[:float], test_float
end

test "retrieve formerly saved setting (true)" do
	test_true = true
	Setting[:true] = test_true
	assert_equal Setting[:true], test_true
end

test "retrieve formerly saved setting (false)" do
	test_false = false
	Setting[:false] = test_false
	assert_equal Setting[:false], test_false
end

test "lookup setting, return object instead of contained data" do
	assert Setting[:data, true].is_a? Setting
end