#include <cstdlib>
#include <string>

std::string get_env_or(const std::string& key, const std::string& default_value) {
  const char* val = std::getenv(key.c_str());
  if (!val) {
    return default_value;
  }

  return std::string(val);
}