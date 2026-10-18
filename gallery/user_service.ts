export type Role = 'admin' | 'editor' | 'viewer';

export interface UserProfile {
  readonly id: string;
  name: string;
  email: string;
  role: Role;
  tags: string[];
  createdAt: Date;
}

export type ApiResponse<T> =
  | { success: true; data: T; timestamp: number }
  | { success: false; error: string; code: number };

export class UserService {
  private cache: Map<string, UserProfile> = new Map();

  public async fetchUser(id: string): Promise<ApiResponse<UserProfile>> {
    if (this.cache.has(id)) {
      return { success: true, data: this.cache.get(id)!, timestamp: Date.now() };
    }

    try {
      const response = await fetch(`/api/users/${encodeURIComponent(id)}`);
      if (!response.ok) {
        return { success: false, error: response.statusText, code: response.status };
      }
      const data: UserProfile = await response.json();
      this.cache.set(id, data);
      return { success: true, data, timestamp: Date.now() };
    } catch (err: unknown) {
      const message = err instanceof Error ? err.message : 'Unknown error';
      return { success: false, error: message, code: 500 };
    }
  }
}
