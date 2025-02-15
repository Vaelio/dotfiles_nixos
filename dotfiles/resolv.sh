#!/bin/sh



grep 'nameserver' /etc/resolv.conf | cut -d' ' -f2
