require ["fileinto", "mailbox"];

if header :contains "X-Spam-Flag" "YES" {
        fileinto :create "Spam";
}