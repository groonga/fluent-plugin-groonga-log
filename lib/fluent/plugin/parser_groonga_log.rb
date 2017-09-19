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

module Fluent
  module Plugin
    class GroongaLogParser < Fluent::Plugin::Parser
      Fluent::Plugin.register_parser("groonga_log", self)
      REGEXP =
        /\A(?<year>\d{4})-(?<month>\d\d)-(?<day>\d\d) (?<hour>\d\d):(?<minutes>\d\d):(?<seconds>\d\d)\.(?<micro_seconds>\d+)\|(?<log_level>.)\|(?<context_id>.+?)\|(?<message>.*)/

      def initialize
        super
        @mutex = Mutex.new
      end

      def configure(conf)
        super
      end

      def patterns
        {'format' => REGEXP}
      end

      def parse(text)
        m = REGEXP.match(text)
        unless m
          yield nil, nil
          return
        end

        year = m['year']
        month = m['month']
        day = m['day']
        hour = m['hour']
        minutes = m['minutes']
        seconds = m['seconds']
        micro_seconds = m['micro_seconds']
        log_level = m['log_level']
        context_id = m['context_id']
        message = m['message']
        time = Fluent::Engine.now

        record = {
          "year" => year,
          "month" => month,
          "day" => day,
          "hour" => hour,
          "minutes" => minutes,
          "seconds" => seconds,
          "micro_seconds" => micro_seconds,
          "log_level" => log_level,
          "context_id" => context_id,
          "message" => message,
        }

        yield time, record
      end
    end
  end
end
