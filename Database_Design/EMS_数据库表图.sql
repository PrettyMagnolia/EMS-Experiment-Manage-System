CREATE TABLE `assistant`  (
  `assistant` bigint NOT NULL COMMENT '助教ID',
  `name` varchar(255) NULL COMMENT '助教姓名',
  `gender` tinyint(1) NULL COMMENT '助教性别',
  `email` varchar(255) NULL COMMENT '助教邮箱',
  `phone` varchar(10) NULL COMMENT '助教手机号',
  PRIMARY KEY (`assistant`)
);

CREATE TABLE `class`  (
  `class_id` bigint NOT NULL COMMENT '班级ID',
  `course_id` bigint NOT NULL COMMENT '班级所属课程ID',
  `capacity` int NULL COMMENT '班级容量',
  `time` datetime NULL COMMENT '班级时段',
  PRIMARY KEY (`class_id`)
);

CREATE TABLE `course`  (
  `course_id` bigint NOT NULL COMMENT '课程ID',
  `name` varchar(255) NULL COMMENT '课程名称',
  `introduction` varchar(1000) NULL COMMENT '课程简介',
  `create_time` datetime NULL COMMENT '课程创建时间',
  PRIMARY KEY (`course_id`)
);

CREATE TABLE `experiment`  (
  `experiment_id` bigint NOT NULL COMMENT '实验ID',
  `course_id` bigint NOT NULL COMMENT '实验所属课程ID',
  `name` varchar(255) NULL COMMENT '实验名称',
  `introduction` varchar(1000) NULL COMMENT '实验简介',
  `create_time` datetime NULL COMMENT '实验创建时间',
  `deadline` datetime NULL COMMENT '实验截止时间',
  PRIMARY KEY (`experiment_id`)
);

CREATE TABLE `notice`  (
  `notice_id` bigint NOT NULL COMMENT '公告ID',
  `teacher_id` bigint NOT NULL COMMENT '公告发布教师ID',
  `course_id` bigint NOT NULL COMMENT '公告所属课程ID',
  `title` varchar(255) NULL COMMENT '公告标题',
  `content` longtext NULL COMMENT '公告内容',
  `create_time` datetime NULL COMMENT '公告创建时间',
  PRIMARY KEY (`notice_id`)
);

CREATE TABLE `report`  (
  `report_id` bigint NOT NULL COMMENT '报告ID',
  `experiment_id` bigint NOT NULL COMMENT '报告所属实验ID',
  `student_id` bigint NOT NULL COMMENT '报告所属学生ID',
  `teacher_id` bigint NOT NULL COMMENT '报告批阅老师ID',
  `assistant_id` bigint NULL COMMENT '报告批阅助教ID',
  `content` longtext NULL COMMENT '报告内容',
  `upload_time` datetime NULL COMMENT '报告提交时间',
  `score` float NULL COMMENT '报告分数\r\n',
  PRIMARY KEY (`report_id`)
);

CREATE TABLE `resource`  (
  `resource_id` bigint NOT NULL COMMENT '资源ID',
  `teacher_id` bigint NOT NULL COMMENT '资料上传教师ID',
  `course_id` bigint NOT NULL COMMENT '资料所属课程ID',
  `type` int NULL COMMENT '资料类型',
  `file_size` int NULL COMMENT '文件大小',
  `file_name` varchar(255) NULL COMMENT '文件名称',
  `file_path` varchar(255) NULL COMMENT '文件存储路径',
  PRIMARY KEY (`resource_id`)
);

CREATE TABLE `student`  (
  `student_id` bigint NOT NULL COMMENT '学生ID',
  `name` varchar(255) NULL COMMENT '学生姓名',
  `gender` tinyint(1) NULL COMMENT '学生性别',
  `email` varchar(255) NULL COMMENT '学生邮箱',
  `phone` varchar(32) NULL COMMENT '学生手机号',
  PRIMARY KEY (`student_id`)
);

CREATE TABLE `student_conduct_experiment`  (
  `experiment_id` bigint NOT NULL COMMENT '实验ID',
  `student_id` bigint NOT NULL COMMENT '学生ID',
  PRIMARY KEY (`experiment_id`, `student_id`)
);

CREATE TABLE `student_join_class`  (
  `class_id` bigint NOT NULL COMMENT '班级ID',
  `student_id` bigint NOT NULL COMMENT '学生ID',
  `grade` float NULL COMMENT '学生课程的成绩',
  PRIMARY KEY (`class_id`, `student_id`)
);

CREATE TABLE `teacher`  (
  `teacher_id` bigint NOT NULL COMMENT '教师ID',
  `name` varchar(255) NULL COMMENT '教师姓名',
  `gender` tinyblob NULL COMMENT '教师性别',
  `email` varchar(255) NULL COMMENT '教师邮箱',
  `phone` varchar(10) NULL COMMENT '教师手机号',
  PRIMARY KEY (`teacher_id`)
);

CREATE TABLE `teacher_teach_course`  (
  `teacher_id` bigint NOT NULL COMMENT '教师ID',
  `course_id` bigint NOT NULL COMMENT '课程ID',
  `level` tinyint NULL COMMENT '教师在此门课程中的等级',
  PRIMARY KEY (`teacher_id`, `course_id`)
);

ALTER TABLE `class` ADD CONSTRAINT `fk_class_course_1` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`);
ALTER TABLE `experiment` ADD CONSTRAINT `fk_experiment_course_1` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`);
ALTER TABLE `notice` ADD CONSTRAINT `fk_notice_teacher_1` FOREIGN KEY (`teacher_id`) REFERENCES `teacher` (`teacher_id`);
ALTER TABLE `notice` ADD CONSTRAINT `fk_notice_course_1` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`);
ALTER TABLE `report` ADD CONSTRAINT `fk_report_experiment_1` FOREIGN KEY (`experiment_id`) REFERENCES `experiment` (`experiment_id`);
ALTER TABLE `report` ADD CONSTRAINT `fk_report_teacher_1` FOREIGN KEY (`teacher_id`) REFERENCES `teacher` (`teacher_id`);
ALTER TABLE `report` ADD CONSTRAINT `fk_report_student_1` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`);
ALTER TABLE `report` ADD CONSTRAINT `fk_report_assistant_1` FOREIGN KEY (`assistant_id`) REFERENCES `assistant` (`assistant`);
ALTER TABLE `resource` ADD CONSTRAINT `fk_resource_teacher_1` FOREIGN KEY (`teacher_id`) REFERENCES `teacher` (`teacher_id`);
ALTER TABLE `resource` ADD CONSTRAINT `fk_resource_course_1` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`);
ALTER TABLE `student_conduct_experiment` ADD CONSTRAINT `fk_student_conduct_experiment_student_1` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`);
ALTER TABLE `student_conduct_experiment` ADD CONSTRAINT `fk_student_conduct_experiment_experiment_1` FOREIGN KEY (`experiment_id`) REFERENCES `experiment` (`experiment_id`);
ALTER TABLE `student_join_class` ADD CONSTRAINT `fk_student_join_class_class_1` FOREIGN KEY (`class_id`) REFERENCES `class` (`class_id`);
ALTER TABLE `student_join_class` ADD CONSTRAINT `fk_student_join_class_student_1` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`);
ALTER TABLE `teacher_teach_course` ADD CONSTRAINT `fk_teacher_teach_course_teacher_1` FOREIGN KEY (`teacher_id`) REFERENCES `teacher` (`teacher_id`);
ALTER TABLE `teacher_teach_course` ADD CONSTRAINT `fk_teacher_teach_course_course_1` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`);

