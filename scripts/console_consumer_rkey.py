#!/usr/bin/env python3

import sys
import uuid
import pika


EXCHANGE = "auriga.topic"


def consume_callback(chan, method, properties, payload):
    print(payload.decode('utf-8'))


def parse_args():
    if len(sys.argv) < 2:
        print("Usage: '{0} parsed' to process messages with key auriga.parsed".format(sys.argv[0]))
        sys.exit(0)

    return sys.argv[1]

def main():
    arg_key = parse_args()

    connection = pika.BlockingConnection(pika.ConnectionParameters(host='auriga-devbox'))
    chan = connection.channel()

    key = "auriga.{0}".format(arg_key)
    queue = "{0}.console-{1}".format(EXCHANGE, uuid.uuid1())
    chan.queue_declare(queue=queue, auto_delete=True)
    chan.queue_bind(exchange=EXCHANGE, queue=queue, routing_key=key)

    chan.basic_consume(consume_callback, queue=queue, no_ack=True)

    chan.start_consuming()


if __name__ == "__main__":
    main()
