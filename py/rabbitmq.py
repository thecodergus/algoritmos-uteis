import pika, logging as log
from typing import Optional, Callable

class RabbitMQ:
    def __init__(self, host: str, port: str | int, user: str, password: str, queue: str):
        self.host: str = host
        self.port: str | int = port
        self.queue: str = queue
        self.user: str = user
        self.password: str = password
        self.connection: Optional[pika.BlockingConnection] = None
        self.channel: Optional[pika.channel.Channel] = None
        self.__callback_function: Optional[Callable] = None

    def connect(self):
        try:
            credentials = pika.PlainCredentials(self.user, self.password)
            self.connection = pika.BlockingConnection(
                pika.ConnectionParameters(host=self.host, port=self.port, credentials=credentials)
            )
            self.channel = self.connection.channel()
            self.channel.queue_declare(queue=self.queue)
        except pika.exceptions.AMQPConnectionError:
            log.error("Erro de conexão AMQP.")
        except pika.exceptions.ChannelClosedByBroker:
            log.error("O canal foi fechado pelo broker.")
        except Exception as e:
            log.error(f"Erro ao conectar: {e}")

    def consume(self, callback: Callable):
        self.__callback_function = callback
        try:
            self.channel.basic_consume(queue=self.queue, on_message_callback=self.__callback, auto_ack=False)
            self.channel.start_consuming()
        except pika.exceptions.ConsumerCancelled:
            log.error("O consumidor foi cancelado.")
        except Exception as e:
            log.error(f"Erro ao consumir: {e}")

    def __callback(self, ch, method, properties, body):
        try:
            self.__callback_function(body)
            ch.basic_ack(delivery_tag=method.delivery_tag)
        except Exception as e:
            log.error(f"Erro no callback: {e}")
            ch.basic_nack(delivery_tag=method.delivery_tag)

    def close(self):
        try:
            self.connection.close()
        except pika.exceptions.ConnectionClosedByBroker:
            log.error("Conexão fechada pelo broker.")
        except Exception as e:
            log.error(f"Erro ao fechar a conexão: {e}")

    def __del__(self) -> None:
        self.close()