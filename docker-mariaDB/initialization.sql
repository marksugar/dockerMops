DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.db WHERE Db LIKE 'test%';
DROP DATABASE test;
UPDATE mysql.user SET password = password('abc123') WHERE user = 'root';
CREATE DATABASE jumpserver charset='utf8';
GRANT ALL PRIVILEGES ON jumpserver.* To 'jumpserver'@'%' IDENTIFIED BY 'password';
flush privileges;
