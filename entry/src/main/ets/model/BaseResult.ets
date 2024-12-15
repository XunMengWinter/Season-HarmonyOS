export class BaseResult<T> {
  errorCode?: number;
  msg?: string;
  data?: T;

  constructor(json: BaseResult<T>) {
    this.errorCode = json.errorCode;
    this.msg = json.msg;
    this.data = json.data;
  }

  /**
   * Static method to parse a JSON string into a BaseResult instance.
   * @param jsonString The JSON string to parse
   * @returns A BaseResult instance or null in case of failure
   */
  static fromJSON<T>(jsonString: string): BaseResult<T> | null {
    try {
      const json: BaseResult<T> = JSON.parse(jsonString);
      return new BaseResult<T>(json);
    } catch (e) {
      console.error('Failed to parse JSON:', e);
      return null;
    }
  }
}