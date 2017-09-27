#
# Copyright 2017: Yasuhiro Horimoto<horimoto@clear-code.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require "fluent/plugin/parser"
require "groonga-log/parser"

module Fluent
  module Plugin
    class GroongaLogParser < Fluent::Plugin::Parser
      Fluent::Plugin.register_parser("groonga_log", self)

      def initialize
        super
        @mutex = Mutex.new
        @parser = GroongaLog::Parser.new
      end

      def configure(conf)
        super
      end

      def patterns
        {'format' => REGEXP}
      end

      def parse(text)
        @parser.parse(text) do |statistic|
          timestamp = statistic.delete("timestamp")
          event_time = Fluent::EventTime.from_time(timestamp)
          yield event_time, statistic
        end
      end
    end
  end
end
