require "helper"
require "fluent/plugin/parser_groonga_log.rb"

class GroongaLogParserTest < Test::Unit::TestCase
  def setup
    Fluent::Test.setup
    @parser = create_driver({})
    @expected = {
      :year => 2017,
      :month => 7,
      :day => 19,
      :hour => 14,
      :minute => 41,
      :second => 5,
      :micro_second => 663978,
      :log_level => :notice,
      :context_id => "18c61700",
      :message => "spec:2:update:Object:32(type):8",
    }
    @parser.configure({})
  end

  def test_parse
    @parser.instance.parse('2017-07-19 14:41:05.663978|n|18c61700|spec:2:update:Object:32(type):8') { |time, record|
      assert_true(time.is_a?(Fluent::EventTime))
      assert_equal(@expected, record)
    }
  end

#  test "failure" do
#    flunk
#  end

  private

  def create_driver(conf)
    Fluent::Test::Driver::Parser.new(Fluent::Plugin::GroongaLogParser).configure(conf)
  end
end
