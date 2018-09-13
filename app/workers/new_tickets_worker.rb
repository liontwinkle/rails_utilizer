class NewTicketsWorker
  def perform
    TrainSearches::CheckTicketsLogic.instance.search
  end

  def enqueue_self
    return if Delayed::Job.exists?(handler: handler, locked_at: nil)
    Delayed::Job.enqueue NewTicketsWorker.new, run_at: 1.minute.from_now, priority: 0
  end

  def handler
    "--- !ruby/object:NewTicketsWorker {}\n"
  end

  def max_attempts
    3
  end

  def success(_job)
    enqueue_self
  end

  def error(_job, _exception)
    # Send me email
  end

  def failure(_job)
    # Send me email
  end
end
