CREATE DATABASE IF NOT EXISTS `tangerine_testing`;

GRANT ALL ON `tangerine_testing`.* to tangerine_user identified by 'tangerine_pass';
GRANT ALL ON `tangerine_testing`.* to tangerine_user@localhost identified by 'tangerine_pass';