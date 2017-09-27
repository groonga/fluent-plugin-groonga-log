require "helper"
require "fluent/plugin/parser_groonga_log.rb"

class GroongaLogParserTest < Test::Unit::TestCase
  def setup
    Fluent::Test.setup
    @parser = create_driver
    @parser.configure({})
  end

  def test_parse
    log = "2017-07-19 14:41:05.663978|n|18c61700|spec:2:update:Object:32(type):8"
    @parser.instance.parse(log) do |time, record|
      timestamp = Time.local(2017, 7, 19, 14, 41, 5, 663978)
      expected = {
        "year" => 2017,
        "month" => 7,
        "day" => 19,
        "hour" => 14,
        "minute" => 41,
        "second" => 5,
        "micro_second" => 663978,
        "log_level" => :notice,
        "context_id" => "18c61700",
        "message" => "spec:2:update:Object:32(type):8",
      }
      assert_equal([
                     Fluent::EventTime.from_time(timestamp),
                     expected,
                   ],
                   [time, record])
    end
  end

  private
  def create_driver
    Fluent::Test::Driver::Parser.new(Fluent::Plugin::GroongaLogParser)
  end
end
