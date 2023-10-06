#ifndef A29B8401_B370_4C39_B03A_14E2029598BE
#define A29B8401_B370_4C39_B03A_14E2029598BE

#include <condition_variable>
#include <mutex>
#include <queue>

template <typename T>
class ThreadSafeQueue {
 public:
  void push(const T& item) {
    std::lock_guard<std::mutex> lock(mutex_);
    queue_.push(item);
    cond_var_.notify_one();
  }

  T pop() {
    std::unique_lock<std::mutex> lock(mutex_);
    cond_var_.wait(lock, [this] { return !queue_.empty(); });
    T item = queue_.front();
    queue_.pop();
    return item;
  }

  bool isEmpty() {
    std::lock_guard<std::mutex> lock(mutex_);
    return queue_.empty();
  }

 private:
  std::queue<T> queue_;
  std::mutex mutex_;
  std::condition_variable cond_var_;
};

#endif /* A29B8401_B370_4C39_B03A_14E2029598BE */
