#ifndef B7531CEB_511A_44BE_AF37_C958B309142F
#define B7531CEB_511A_44BE_AF37_C958B309142F
#include <iostream>
#include <string>

namespace messages {
// Códigos de escape ANSI para cores
const std::string BLUE = "\033[1;34m";
const std::string RED = "\033[1;31m";
const std::string YELLOW = "\033[1;33m";
const std::string RESET = "\033[0m";

enum class Level { INFO, WARNING, ERROR };

std::string color_message(const std::string &message, Level level);

void info(const std::string &message);
void warning(const std::string &message);
void error(const std::string &message);

}  // namespace messages


#endif /* B7531CEB_511A_44BE_AF37_C958B309142F */

#include "messages.hpp"

namespace messages {
std::string color_message(const std::string &message, Level level) {
  std::string final_message;

  switch (level) {
    case Level::INFO:
      final_message = BLUE + "[INFO] " + RESET + message;
      break;
    case Level::WARNING:
      final_message = YELLOW + "[WARNING] " + RESET + message;
      break;
    case Level::ERROR:
      final_message = RED + "[ERROR] " + RESET + message;
      break;
  }

  return final_message;
}

void info(const std::string &message) { std::cout << color_message(message, Level::INFO) << std::endl; }
void warning(const std::string &message) { std::cout << color_message(message, Level::WARNING) << std::endl; }
void error(const std::string &message) { std::cout << color_message(message, Level::ERROR) << std::endl; }

}  // namespace messages
