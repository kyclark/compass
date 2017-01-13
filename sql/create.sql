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

drop table if exists client_phone;
create table client_phone (
  client_phone_id int unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
  client_id int unsigned not null,
  phone varchar(50),
  type varchar(50),
  foreign key (client_id) references client (client_id) on delete cascade
) ENGINE=InnoDB;

drop table if exists race;
create table race_id (
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
  ethnicity_id unsigned int default null,
  race_id unsigned int default null,
  residency_id unsigned int default null,
  gender_id unsigned int default null,
  education_level_id unsigned int default null,
  marital_status_id unsigned int default null,
  case_num int unsigned not null default 0,
  first_name varchar(100) DEFAULT NULL,
  last_name varchar(100) DEFAULT NULL,
  aka varchar(100) default null,
  dob date default null,
  is_homeless enum('Y', 'N') default 'N',
  is_disabled enum('Y', 'N') default 'N',
  is_employed enum('Y', 'N') default 'N',
  original_date_service date default null,
  email varchar(255) default null,
  notes text,
  KEY last_name (last_name),
  foreign key (case_worker_id) references case_worker (case_worker_id) on delete cascade,
  foreign key (gender_id) references gender (gender_id) on delete cascade,
  foreign key (ethnicity_id) references ethnicity (ethnicity_id) on delete cascade,
  foreign key (residency_id) references residency (residency_id) on delete cascade,
  foreign key (education_level_id) references education_level (education_level_id) on delete cascade,
  PRIMARY KEY (client_id)
) ENGINE=InnoDB;

drop table if exists employment;
create table employment (
  employment_id int unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
  person_id int unsigned NOT NULL,
  employer varchar(100),
  income double(10,2),
  start_date date,
  end_date date,
  foreign key (person_id) references person (person_id) on delete cascade
) ENGINE=InnoDB;

# Alimony, Employment
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
  foreign key (person_id) references person (person_id) on delete cascade
  start_date date,
  end_date date,
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

drop table if exists household_member_type;
create table household_member_type (
  household_member_type_id int unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
  household_name varchar(100)
) ENGINE=InnoDB;
# Head, Dependent

drop table if exists household_member;
create table household_member (
  household_member_id int unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
  household_member_type_id int unsigned default null,
  household_id int unsigned NOT NULL,
  person_id int unsigned NOT NULL,
  foreign key (household_member_id) references household_member_type (household_member_type_id) on delete cascade,
  foreign key (household_id) references household (household_id) on delete cascade,
  foreign key (person_id) references person (person_id) on delete cascade
) ENGINE=InnoDB;

drop table if exists household_to_program;
create table household_to_program (
  household_to_program_id int unsigned NOT NULL AUTO_INCREMENT primary key,
  household_id int unsigned NOT NULL,
  program_id int unsigned NOT NULL,
  entry_date date default null,
  exit_date date default null,
  foreign key (household_id) references household (household_id) on delete cascade,
  foreign key (program_id) references program (program_id) on delete cascade
) ENGINE=InnoDB;

# WIC, SNAP, DES Childcare, SSDI
drop table if exists benefit;
create table benefit (
  benefit_id int unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
  benefit_name varchar(50)
) ENGINE=InnoDB;

drop table if exists household_benefit;
create table household_benefit (
  household_benefit_id int unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
  household_id int unsigned NOT NULL,
  benefit_id int unsigned NOT NULL,
  start_date date,
  end_date date,
  foreign key (household_id) references household (household_id) on delete cascade,
  foreign key (benefit_id) references benefit (benefit_id) on delete cascade
) ENGINE=InnoDB;
