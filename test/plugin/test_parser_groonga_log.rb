require "helper"
require "fluent/plugin/parser_groonga_log.rb"

class GroongaLogParserTest < Test::Unit::TestCase
  def setup
    Fluent::Test.setup
    @parser = create_driver({})
    @expected = {
      "year" => "2017",
      "month" => "07",
      "day" => "19",
      "hour" => "14",
      "minutes" => "41",
      "seconds" => "05",
      "micro_seconds" => "663978",
      "log_level" => "n",
      "context_id" => "18c61700",
      "message" => "spec:2:update:Object:32(type):8",
    }
    @parser.configure({})
  end

  def test_parse
    @parser.instance.parse('2017-07-19 14:41:05.663978|n|18c61700|spec:2:update:Object:32(type):8') { |record|
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
