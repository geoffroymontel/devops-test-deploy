DELETE FROM mysql.user WHERE user = "";
DELETE FROM mysql.db WHERE Db LIKE 'test%';
FLUSH PRIVILEGES;
