// Asynchronous task queue with concurrency control

class AsyncQueue {
  constructor(concurrency = 4) {
    this.concurrency = concurrency;
    this.running = 0;
    this.queue = [];
  }

  enqueue(taskFn) {
    return new Promise((resolve, reject) => {
      this.queue.push({ taskFn, resolve, reject });
      this.dequeue();
    });
  }

  async dequeue() {
    if (this.running >= this.concurrency || this.queue.length === 0) {
      return;
    }

    this.running++;
    const { taskFn, resolve, reject } = this.queue.shift();

    try {
      const result = await taskFn();
      resolve(result);
    } catch (err) {
      reject(err);
    } finally {
      this.running--;
      this.dequeue();
    }
  }
}

module.exports = { AsyncQueue };
