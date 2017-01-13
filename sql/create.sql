SET foreign_key_checks=0;

drop table if exists program;
create table program (
  program_id int unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
  program_name varchar(100)
) ENGINE=InnoDB;

# CASA, HST, Alvord Court, Glenstone, Downtown Motor

drop table if exists case_worker;
create table case_worker (
  case_worker_id int unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name varchar(100)
) ENGINE=InnoDB;

drop table if exists case_worker_to_client;

drop table if exists race;
create table race (
  race_id int unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
  race varchar(50)
) ENGINE=InnoDB;

drop table if exists ethnicity;
create table ethnicity (
  ethnicity_id int unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
  ethnicity varchar(50)
) ENGINE=InnoDB;

# White
# Hispanic

drop table if exists education_level;
create table education_level (
  education_level_id int unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
  level varchar(50)
) ENGINE=InnoDB;

# Male, Female, Transgender Male, Transgender Female, Do Not Identify
drop table if exists gender;
create table gender (
  gender_id int unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
  gender varchar(50)
) ENGINE=InnoDB;

# Native Documented Undocumented
drop table if exists residency;
create table residency (
  residency_id int unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
  residency varchar(50)
) ENGINE=InnoDB;

drop table if exists marital_status;
create table marital_status (
  marital_status_id int unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
  marital_status varchar(50)
) ENGINE=InnoDB;

drop table if exists person;
create table person (
  person_id int unsigned NOT NULL AUTO_INCREMENT,
  case_worker_id int unsigned default null,
  ethnicity_id int unsigned default null,
  race_id int unsigned default null,
  residency_id int unsigned default null,
  gender_id int unsigned default null,
  education_level_id int unsigned default null,
  marital_status_id int unsigned default null,
  case_num int unsigned not null default 0,
  first_name varchar(100) DEFAULT NULL,
  last_name varchar(100) DEFAULT NULL,
  aka varchar(100) default null,
  dob date default null,
  is_disabled enum('Y', 'N') default 'N',
  is_employed enum('Y', 'N') default 'N',
  homeless_at_entry enum('Y', 'N') default 'N',
  opened_bank_account enum('Y', 'N') default 'N',
  debt_load int unsigned default 0,
  entry_date date default null,
  monthly_employment_income_at_entry int unsigned default 0,
  monthly_employment_income_at_exit int unsigned default 0,
  notes text,
  KEY last_name (last_name),
  foreign key (case_worker_id) references case_worker (case_worker_id) on delete cascade,
  foreign key (gender_id) references gender (gender_id) on delete cascade,
  foreign key (marital_status_id) references marital_status (marital_status_id) on delete cascade,
  foreign key (ethnicity_id) references ethnicity (ethnicity_id) on delete cascade,
  foreign key (race_id) references race (race_id) on delete cascade,
  foreign key (residency_id) references residency (residency_id) on delete cascade,
  foreign key (education_level_id) references education_level (education_level_id) on delete cascade,
  PRIMARY KEY (person_id)
) ENGINE=InnoDB;

# Alimony, Employment, WIC, SNAP, DES Childcare, SSDI
drop table if exists income_type;
create table income_type (
  income_type_id int unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
  income_type varchar(50)
) ENGINE=InnoDB;

drop table if exists income;
create table income (
  income_id int unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
  income_type_id int unsigned NOT NULL,
  person_id int unsigned NOT NULL,
  foreign key (income_type_id) references income_type (income_type_id) on delete cascade,
  foreign key (person_id) references person (person_id) on delete cascade,
  start_date date,
  end_date date
) ENGINE=InnoDB;

drop table if exists household;
create table household (
  household_id int unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
  household_name varchar(100),
  street varchar(100) default null,
  city varchar(100) default null,
  state varchar(100) default null,
  zip varchar(100) default null,
  notes text
) ENGINE=InnoDB;

drop table if exists household_member;
create table household_member (
  household_member_id int unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
  household_member_type_id int unsigned default null,
  household_id int unsigned NOT NULL,
  person_id int unsigned NOT NULL,
  is_head tinyint default '0',
  foreign key (household_member_id) references household_member_type (household_member_type_id) on delete cascade,
  foreign key (household_id) references household (household_id) on delete cascade,
  foreign key (person_id) references person (person_id) on delete cascade
) ENGINE=InnoDB;

drop table if exists person_to_program;
create table person_to_program (
  person_to_program_id int unsigned NOT NULL AUTO_INCREMENT primary key,
  person_id int unsigned NOT NULL,
  program_id int unsigned NOT NULL,
  entry_date date default null,
  exit_date date default null,
  foreign key (person_id) references person (person_id) on delete cascade,
  foreign key (program_id) references program (program_id) on delete cascade
) ENGINE=InnoDB;

drop table if exists debt_payment;
create table debt_payment (
  debt_payment_id int unsigned NOT NULL AUTO_INCREMENT primary key,
  person_id int unsigned NOT NULL,
  amount int unsigned default 0,
  payment_date date default null,
  foreign key (person_id) references person (person_id) on delete cascade
) ENGINE=InnoDB;
