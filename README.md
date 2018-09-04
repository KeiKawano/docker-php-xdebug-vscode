# How to start php debug server

1. Specify your local ip address

    ```sh
    # linux, macOS
    ip a

    # Windows
    ipconfig
    ```

2. Modify IP address in docker-compose.yml file

3. Run docker

    ```sh
    docker-compose up
    ```

    output messages look like...

    ```sh
    Recreating phpdebug_php-debug_1 ...
    Recreating phpdebug_php-debug_1 ... done
    Attaching to phpdebug_php-debug_1
    php-debug_1  | httpd: Could not reliably determine the server's fully qualified domain name, using 172.17.0.3 for ServerNam
    ```

4. Access with browser

    - Linux
       access <http://172.17.0.3/phpinfo.php>

    - macOS
       access <http://localhost/phpinfo.php>

## References

[Docker lamp setups](https://github.com/nickistre/docker-lamp/tree/centos-6.6)

[Debug your PHP in Docker with Intellij/PHPStorm and Xdebug](https://gist.github.com/chadrien/c90927ec2d160ffea9c4)

[TROUBLESHOOT: Docker - Rpmdb checksum is invalid](https://medium.com/@fkei/docker-rpmdb-checksum-is-invalid-dcdpt-pkg-checksums-xxxx-amzn1-u-%E5%AF%BE%E5%87%A6%E6%B3%95-289b8c58d4a3)
