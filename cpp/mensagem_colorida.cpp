namespace messages {

//! Códigos de escape ANSI para cores
const std::string BLUE = "\033[1;34m";    //!< Cor azul
const std::string RED = "\033[1;31m";     //!< Cor vermelha
const std::string YELLOW = "\033[1;33m";  //!< Cor amarela
const std::string GREEN = "\033[1;32m";   //!< Cor verde
const std::string RESET = "\033[0m";      //!< Reset para cor padrão

//! Enumeração para definir os níveis das mensagens
enum class Level {
  INFO,     //!< Nível de informação
  WARNING,  //!< Nível de aviso
  ERROR,    //!< Nível de erro
  SUCCESS   //!< Nível de sucesso
};

/**
 * @brief Colore a mensagem de acordo com o nível fornecido.
 *
 * @param message Mensagem a ser colorida.
 * @param level Nível da mensagem (INFO, WARNING, ERROR).
 * @return std::string Mensagem colorida.
 */
std::string color_message(const std::string &message, Level level);

/**
 * @brief Exibe uma mensagem de informação no console.
 *
 * @param message Mensagem a ser exibida.
 */
void info(const std::string &message);

/**
 * @brief Exibe uma mensagem de aviso no console.
 *
 * @param message Mensagem a ser exibida.
 */
void warning(const std::string &message);

/**
 * @brief Exibe uma mensagem de erro no console.
 *
 * @param message Mensagem a ser exibida.
 */
void error(const std::string &message);

void success(const std::string &message);

}  // namespace messages

// Define um namespace para mensagens
namespace messages {

// Função que colore a mensagem de acordo com o nível fornecido
std::string color_message(const std::string &message, Level level) {
  std::string final_message;

  // Verifica o nível da mensagem para determinar a cor
  switch (level) {
    case Level::INFO:
      // Se for uma mensagem de informação, colore de azul
      final_message = BLUE + "[INFO] " + RESET + message;
      break;
    case Level::WARNING:
      // Se for uma mensagem de aviso, colore de amarelo
      final_message = YELLOW + "[WARNING] " + RESET + message;
      break;
    case Level::ERROR:
      // Se for uma mensagem de erro, colore de vermelho
      final_message = RED + "[ERROR] " + RESET + message;
      break;
    case Level::SUCCESS:
      // Se for uma mensagem de sucesso, colore de verde
      final_message = GREEN + "[SUCCESS] " + RESET + message;
      break;
  }

  // Retorna a mensagem colorida
  return final_message;
}

// Função para exibir mensagens de informação no console
void info(const std::string &message) { std::cerr << color_message(message, Level::INFO) << std::endl; }

// Função para exibir mensagens de aviso no console
void warning(const std::string &message) { std::cerr << color_message(message, Level::WARNING) << std::endl; }

// Função para exibir mensagens de erro no console
void error(const std::string &message) { std::cerr << color_message(message, Level::ERROR) << std::endl; }

void success(const std::string &message) { std::cerr << color_message(message, Level::SUCCESS) << std::endl; }

}  // namespace messages
