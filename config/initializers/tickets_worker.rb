# Cron or HerokuScheduler should be used for it.
# But HerokuScheduler seems to not be supported on free dynos
# So, doing a bit of a hack - init a job, which would reenque itself on success
NewTicketsWorker.new.enqueue_self
