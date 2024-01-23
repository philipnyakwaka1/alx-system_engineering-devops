-- creates a replica user that can connect from any host
CREATE USER IF NOT EXISTS 'replica_user'@'%';
GRANT REPLICATION SLAVE ON *.* TO 'replica_user'@'%';
GRANT SELECT ON mysql.user TO 'holberton_user'@'localhost';
FLUSH PRIVILEGES;
