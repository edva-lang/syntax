# frozen_string_literal: true

require 'json'
require 'logger'

module Pipeline
  class BackgroundWorker
    attr_reader :name, :queue, :logger

    def initialize(name:, concurrency: 2)
      @name = name
      @concurrency = concurrency
      @queue = Thread::Queue.new
      @logger = Logger.new($stdout)
    end

    def enqueue(payload)
      @queue << payload
      @logger.info("[#{@name}] Enqueued task: #{payload[:id]}")
    end

    def process_all
      tasks = []
      until @queue.empty?
        tasks << @queue.pop(true)
      end
      tasks.map { |task| "Processed: #{task[:action]}" }
    end
  end
end

worker = Pipeline::BackgroundWorker.new(name: 'indexer')
worker.enqueue(id: 101, action: 'rebuild_index')
puts worker.process_all
