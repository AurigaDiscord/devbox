#!/bin/bash

rabbitmq-plugins enable rabbitmq_management
rabbitmqctl add_user auriga auriga
rabbitmqctl set_user_tags auriga administrator
rabbitmqctl set_permissions -p '/' auriga ".*" ".*" ".*"
