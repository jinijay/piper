
---------------------------------------- job ----------------------------------------

drop table if exists job cascade;

create table job (
  id                       varchar(256) not null primary key,
  status                   varchar(256) not null,
  current_task             int          not null,
  pipeline_id              varchar(256) not null,
  label                    varchar(256)     null,
  create_time              timestamp    not null,
  start_time               timestamp        null,
  end_time                 timestamp        null,
  priority                 int          not null,
  inputs                   jsonb        not null,
  webhooks                 jsonb        not null,
  outputs                  jsonb        not null,
  parent_task_execution_id varchar(256)
);

------------------------------- job_webhook_delivery --------------------------------

drop table if exists job_webhook_delivery cascade;

create table job_webhook_delivery (
  id            varchar(256) not null primary key,
  job_id        varchar(256) not null references job(id),
  webhook_index int          not null,
  create_time   timestamp    not null default current_timestamp,
  payload       jsonb        not null,
  status_code   int          not null
);

create index on job (create_time);
create index on job (status);

---------------------------------- task_execution -----------------------------------

drop table if exists task_execution cascade;

create table task_execution (
  id                   varchar(256) not null primary key,
  parent_id            varchar(256)     null,
  status               varchar(256) not null,
  progress             int not          null,
  job_id               varchar(256) not null,
  create_time          timestamp    not null,
  start_time           timestamp        null,
  end_time             timestamp        null,
  serialized_execution jsonb        not null,
  priority             int          not null,
  task_number          int          not null
);

create index on task_execution (job_id);

-------------------------------------- context --------------------------------------

drop table if exists context cascade;

create table context (
  id                 varchar(256) not null primary key,
  stack_id           varchar(256) not null,
  create_time        timestamp    not null,
  serialized_context jsonb        not null
);

create index on context (stack_id);

-------------------------------------- counter --------------------------------------

drop table if exists counter cascade;

create table counter (
  id          varchar(256) not null primary key,
  create_time timestamp    not null,
  value       bigint       not null
);
