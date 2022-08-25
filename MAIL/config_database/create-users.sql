INSERT INTO `maildb`.`virtual_domains`
(`id` ,`name`)
VALUES
('1', 'mes-b2.ephec-ti.be');

INSERT INTO `maildb`.`virtual_users`
(`id`, `domain_id`, `password` , `email`, `maildir`)
VALUES
('1', '1', ENCRYPT('pass_Eli', CONCAT('$6$', SUBSTRING(SHA(RAND()), -16))), 'eliott@mes-b2.ephec-ti.be', 'mes-b2.ephec-ti.be/eliott/');

INSERT INTO `maildb`.`virtual_users`
(`id`, `domain_id`, `password` , `email`, `maildir`)
VALUES
('3', '1', ENCRYPT('pass_Bap', CONCAT('$6$', SUBSTRING(SHA(RAND()), -16))), 'baptiste@mes-b2.ephec-ti.be', 'mes-b2.ephec-ti.be/baptiste/');

INSERT INTO `maildb`.`virtual_users`
(`id`, `domain_id`, `password` , `email`, `maildir`)
VALUES
('4', '1', ENCRYPT('pass_B2B', CONCAT('$6$', SUBSTRING(SHA(RAND()), -16))), 'b2b@mes-b2.ephec-ti.be', 'mes-b2.ephec-ti.be/b2b/');

INSERT INTO `maildb`.`virtual_users`
(`id`, `domain_id`, `password` , `email`, `maildir`)
VALUES
('5', '1', ENCRYPT('pass_Contact', CONCAT('$6$', SUBSTRING(SHA(RAND()), -16))), 'contact@mes-b2.ephec-ti.be', 'mes-b2.ephec-ti.be/contact/');
