# Cron or HerokuScheduler should be used for it.
# But HerokuScheduler seems to not be supported on free dynos
# So, doing a bit of a hack - init a job, which would reenque itself on success
Rails.logger.info 'INITIALIZING WORKER'
NewTicketsWorker.new.enqueue_self if ActiveRecord::Base.connection.table_exists? 'delayed_jobs'
