import os, json, numpy as np, math, logging as log, tensorflow as tf, multiprocessing as mp, glob, time
from tensorflow import keras
from concurrent.futures import ThreadPoolExecutor, ProcessPoolExecutor
from typing import Any, Literal, Union, Tuple, List, Dict
from itertools import product
from PIL import Image


class Keras:
    """
    Classe para carregar e manipular um modelo Keras, incluindo a normalização e inferência em imagens.
    """

    def __init__(self, model_path: str) -> None:
        """
        Inicializa a classe com o caminho do modelo e os parâmetros de obtenção de imagem.

        :param model_path: Caminho para o arquivo do modelo Keras.
        :param imageget_parameters: Caminho para o arquivo com os parâmetros de obtenção de imagem.
        """
        self.model_path: str = model_path

        if os.path.exists(self.model_path):
            self.model: keras.Model = keras.models.load_model(self.model_path)
        else:
            raise FileNotFoundError(f"Modelo não encontrado em {self.model_path}")

    def __process_tile(
        self, i, j, tile_x, tile_y, width, height, data
    ) -> tuple[tuple[int, int], np.ndarray]:
        """
        Processa um bloco da imagem, cortando-o de acordo com as coordenadas fornecidas.

        :param i, j: Índices do bloco.
        :param tile_x, tile_y: Tamanho do bloco.
        :param width, height: Dimensões da imagem.
        :param data: Dados da imagem.
        :return: Tupla com as coordenadas do bloco e os dados do bloco.
        """
        x_start = tile_x * i
        x_end = min(tile_x * (i + 1), width)
        y_start = tile_y * j
        y_end = min(tile_y * (j + 1), height)
        cropped_data = data[y_start:y_end, x_start:x_end, :]
        return (j, i), cropped_data

    def __divide_into_tiles(
        self, data, num_tiles_x, num_tiles_y
    ) -> dict[tuple[int, int], np.ndarray]:
        """
        Divide a imagem em blocos e processa cada bloco em paralelo.

        :param data: Dados da imagem.
        :param num_tiles_x, num_tiles_y: Número de blocos na horizontal e vertical.
        :return: Dicionário com os blocos da imagem.
        """
        height, width, _ = data.shape
        tile_x = width // num_tiles_x
        tile_y = height // num_tiles_y
        data_dict = {}

        with ThreadPoolExecutor() as executor:
            futures = [
                executor.submit(
                    self.__process_tile, i, j, tile_x, tile_y, width, height, data
                )
                for i, j in product(range(num_tiles_x), range(num_tiles_y))
            ]

            for future in futures:
                key, value = future.result()
                data_dict[key] = value

        return data_dict

    def __preprocess(self, data: np.ndarray) -> dict[tuple[int, int], np.ndarray]:
        """
        Divide a imagem em blocos de tamanho 500x500 e armazena os blocos em um dicionário.

        :param data: Imagem de entrada.
        :return: Dicionário contendo os blocos da imagem.
        """
        # Verificar se a imagem de entrada é válida
        if data is None or not data.size:
            log.warning("Imagem inválida fornecida.")
            return {}

        # Definir variáveis iniciais
        tile_size: Tuple[int, int] = (500, 500)
        tile_x, tile_y = tile_size
        height, width, _ = data.shape

        # Iterar através da imagem em blocos de 500x500
        num_tiles_x = math.ceil(width / tile_x)
        num_tiles_y = math.ceil(height / tile_y)

        return self.__divide_into_tiles(data, num_tiles_x, num_tiles_y)

    def inferir_data(
        self,
        data: np.ndarray,
    ) -> dict[tuple[int, int], np.ndarray]:
        """
        Inferir defeitos em uma imagem.

        :param data: Imagem de entrada.
        :return: Dicionário contendo os defeitos inferidos.
        """
        # Verificar se a imagem de entrada é válida
        if data is None or not data.size:
            log.warning("Imagem inválida fornecida.")
            return {}

        # Dividir a imagem em blocos
        data_dict = self.__preprocess(data)

        # Inferir defeitos
        result_dict = {}
        for key, value in data_dict.items():
            result_dict[key] = self.model.predict(
                x=np.expand_dims(value, axis=0),
                use_multiprocessing=True,
                workers=mp.cpu_count(),
                verbose=0,
            )

        return result_dict


class TensorFlow:
    def __init__(self, model_path: str) -> None:
        self.model_path: str = model_path
        if os.path.exists(self.model_path):
            self.model: tf.saved_model = tf.saved_model.load(self.model_path)
        else:
            raise FileNotFoundError(f"Modelo não encontrado em {self.model_path}")

    def __process_tile(
        self, i, j, tile_x, tile_y, width, height, data
    ) -> tuple[tuple[int, int], np.ndarray]:
        """
        Processa um bloco da imagem, cortando-o de acordo com as coordenadas fornecidas.

        :param i, j: Índices do bloco.
        :param tile_x, tile_y: Tamanho do bloco.
        :param width, height: Dimensões da imagem.
        :param data: Dados da imagem.
        :return: Tupla com as coordenadas do bloco e os dados do bloco.
        """
        x_start = tile_x * i
        x_end = min(tile_x * (i + 1), width)
        y_start = tile_y * j
        y_end = min(tile_y * (j + 1), height)
        cropped_data = data[y_start:y_end, x_start:x_end, :]
        return (j, i), cropped_data

    def __divide_into_tiles(
        self, data, num_tiles_x, num_tiles_y
    ) -> dict[tuple[int, int], np.ndarray]:
        """
        Divide a imagem em blocos e processa cada bloco em paralelo.

        :param data: Dados da imagem.
        :param num_tiles_x, num_tiles_y: Número de blocos na horizontal e vertical.
        :return: Dicionário com os blocos da imagem.
        """
        height, width, _ = data.shape
        tile_x = width // num_tiles_x
        tile_y = height // num_tiles_y
        data_dict = {}

        with ThreadPoolExecutor() as executor:
            futures = [
                executor.submit(
                    self.__process_tile, i, j, tile_x, tile_y, width, height, data
                )
                for i, j in product(range(num_tiles_x), range(num_tiles_y))
            ]

            for future in futures:
                key, value = future.result()
                data_dict[key] = value

        return data_dict

    def __preprocess(self, data: np.ndarray) -> dict[tuple[int, int], np.ndarray]:
        """
        Divide a imagem em blocos de tamanho 500x500 e armazena os blocos em um dicionário.

        :param data: Imagem de entrada.
        :return: Dicionário contendo os blocos da imagem.
        """
        # Verificar se a imagem de entrada é válida
        if data is None or not data.size:
            log.warning("Imagem inválida fornecida.")
            return {}

        # Definir variáveis iniciais
        tile_size: Tuple[int, int] = (500, 500)
        tile_x, tile_y = tile_size
        height, width, _ = data.shape

        # Iterar através da imagem em blocos de 500x500
        num_tiles_x = math.ceil(width / tile_x)
        num_tiles_y = math.ceil(height / tile_y)

        return self.__divide_into_tiles(data, num_tiles_x, num_tiles_y)

    def __normalize(self, data: np.ndarray) -> np.ndarray:
        """
        Normaliza os dados dividindo cada valor por 255.

        :param data: Array NumPy com os dados a serem normalizados.
        :return: Array NumPy com os dados normalizados.
        """
        normalize_chunk = lambda chunk: chunk / 255.0

        # Dividir os dados em partes iguais, dependendo do número de núcleos disponíveis
        chunks = np.array_split(data, os.cpu_count())

        # Processar cada parte em um processo separado
        with ProcessPoolExecutor() as executor:
            normalized_chunks = list(executor.map(normalize_chunk, chunks))

        # Concatenar os resultados
        return np.concatenate(normalized_chunks, axis=0)

    def inferir_data(self, data: np.ndarray) -> dict[tuple[int, int], np.ndarray]:
        """
        Inferir defeitos em uma imagem.

        :param data: Imagem de entrada.
        :return: Dicionário contendo os defeitos inferidos.
        """
        # Verificar se a imagem de entrada é válida
        if data is None or not data.size:
            log.warning("Imagem inválida fornecida.")
            return {}

        # Normalizar a imagem
        # data = self.__normalize(data)
        data = data / 255.0

        # Dividir a imagem em blocos
        data_dict = self.__preprocess(data)

        # Inferir defeitos
        result_dict = {}
        for key, value in data_dict.items():
            # Adicionando uma dimensão extra para representar o tamanho do lote
            value_expanded = np.expand_dims(value, axis=0)

            # Certificando-se de que o tipo de dados é float32
            value_float32 = value_expanded.astype(np.float32)

            # Fazendo a inferência
            result_dict[key] = self.model.signatures["serving_default"](
                tf.constant(value_float32, dtype=tf.float32)
            )

        return result_dict


if __name__ == "__main__":
    # modelo = Keras("data/best_model.h5")
    modelo = TensorFlow("data/best_model_tf")
    for item in glob.glob("data/*.png"):
        imagem_array = np.array(Image.open(item))
        start = time.time()
        modelo.inferir_data(imagem_array)
        print(f"{item} - {(time.time() - start):.2f}s")
