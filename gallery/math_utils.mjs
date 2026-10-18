/**
 * ES Module math utilities.
 */

export const EPSILON = 1e-9;

export function clamp(val, min, max) {
  return Math.min(Math.max(val, min), max);
}

export function lerp(start, end, t) {
  return start + (end - start) * clamp(t, 0, 1);
}

export default class Statistics {
  constructor(samples = []) {
    this.samples = [...samples];
  }

  mean() {
    if (this.samples.length === 0) return 0;
    const sum = this.samples.reduce((acc, curr) => acc + curr, 0);
    return sum / this.samples.length;
  }
}
