import pika
from dataclasses import dataclass, field
from datetime import datetime
import numpy as np
import logging as log
from functools import partial
import msgpack as msg


@dataclass
class ImagensInferidas:
    camera_origem: str
    width: int
    height: int
    type_image: str
    part_id: str
    produto_id: str
    encoder: float
    data_hora: datetime
    imagem_data: bytes
    imagem_array: np.ndarray = field(init=False)

    def __post_init__(self):
        self.imagem_array = np.frombuffer(self.imagem_data, dtype=np.uint8).reshape(
            (self.height, self.width)
        )


class RabbitMQ:
    def __init__(
        self, host: str = "localhost", port: str | int = 15672, queue: str = "my_queue"
    ) -> None:
        self.host: str = host
        self.port: str | int = port
        self.queue: str = queue
        self.connection: pika.BlockingConnection = pika.BlockingConnection(
            pika.ConnectionParameters(host=self.host, port=port, retry_delay=5)
        )
        self.channel: pika.BlockingChannel = self.connection.channel()
        self.channel.queue_declare(queue=self.queue)

    def __callback(
        self, callback: callable, ch, method, properties, body: bytes
    ) -> None:
        try:
            novo_dado = ImagensInferidas(*msg.unpackb(body))
            callback(novo_dado)
            ch.basic_ack(delivery_tag=method.delivery_tag)
        except Exception as e:
            ch.basic_reject(delivery_tag=method.delivery_tag, requeue=True)
            log.error(f"Erro ao processar mensagem: {e}")

    def consume(self, callback: callable) -> None:
        fn = partial(
            self.__callback,
            callback,
        )

        self.channel.basic_consume(queue=self.queue, on_message_callback=fn)
        log.info(" [*] Aguardando por mensagens. Para sair pressione CTRL+C")
        self.channel.start_consuming()
