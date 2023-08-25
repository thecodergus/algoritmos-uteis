/**
 * @brief Executa uma função enquanto segura um mutex.
 * @tparam Func Tipo da função.
 * @param func Função a ser executada.
 * @return O resultado da função executada.
 */
template <typename Func>
auto execute_locked(std::mutex* mtx, Func func) -> decltype(func()) {
  std::lock_guard<std::mutex> lock(*mtx);
  return func();
}

/**
 * @brief Executa uma função enquanto segura um mutex.
 * @tparam Func Tipo da função.
 * @param func Função a ser executada.
 * @return O resultado da função executada.
 */
template <typename Func>
auto execute_locked(std::shared_ptr<std::shared_mutex> mtx, Func func) -> decltype(func()) {
  std::lock_guard<std::shared_mutex> lock(*mtx);
  return func();
}
/**
 * @brief Executa uma função enquanto segura um mutex recursivo.
 * @tparam Func Tipo da função.
 * @param func Função a ser executada.
 * @return O resultado da função executada.
 */
template <typename Func>
auto execute_locked_recursive(std::recursive_mutex* mtx_recursive, Func func) -> decltype(func()) {
  std::lock_guard<std::recursive_mutex> lock(*mtx_recursive);
  return func();
}