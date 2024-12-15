import http from '@ohos.net.http';
import { CalendarDay } from '../model/CalendarDay';
import { BaseResult } from '../model/BaseResult';
import { JSON } from '@kit.ArkTS';

export class CalendarViewModel {
  calendarDays: Array<CalendarDay> = [];
  isLoading: boolean = false;
  error: string | null = null;

  async fetchCalendarDays() {
    this.isLoading = true;
    this.error = null;

    const url = 'https://icemono.oss-cn-hangzhou.aliyuncs.com/calendar/cat_2025.json';
    const httpRequest = http.createHttp();
    try {
      const response = await httpRequest.request(url, {
        method: http.RequestMethod.GET, // Correct RequestMethod enum
        header: { 'Content-Type': 'application/json' },
        readTimeout: 10000, // Timeout in milliseconds
      });

      // Check if response.result is valid and not null
      if (!response.result) {
        this.error = 'Empty response from server';
        console.error(this.error);
        return;
      }

      // Safely parse and cast to BaseResult<CalendarDay[]>
      const baseResult = JSON.parse(response.result.toString()) as BaseResult<CalendarDay[]>;
      if (baseResult.errorCode !== 0) {
        this.error = baseResult.msg || 'Unknown error from server';
        console.error(`Error from server: ${this.error}`);
        return;
      }

      // Map the fetched data into calendarDays
      this.calendarDays = (baseResult.data || []).map((item) => new CalendarDay(item));
    } catch (e) {
      // Handle any exceptions
      this.error = `Request failed: ${e.message || e}`;
      console.error(`Request error: ${this.error}`);
    } finally {
      this.isLoading = false;
    }
  }

}