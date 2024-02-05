ALTER SYSTEM SET max_worker_processes = 64;
/* Restart server here*/
SET max_parallel_workers = 64;
SET max_parallel_workers_per_gather = 64;
