// DateUtil.ts
class DateUtil {
  static getDateStamp(date: Date): string {
    const year = date.getFullYear().toString();
    const month = (date.getMonth() + 1).toString().padStart(2, '0');
    const day = date.getDate().toString().padStart(2, '0');
    return `${year}${month}${day}`;
  }

  static getDateFromStamp(datestamp: string): Date{
    const year = parseInt(datestamp.substring(0, 4));
    const month = parseInt(datestamp.substring(4, 6)) - 1; // JavaScript 的月份从 0 开始
    const day = parseInt(datestamp.substring(6, 8));
    return new Date(year, month, day);
  }

  static openCalendar(datestamp: string) {
    // Implement calendar opening logic
  }
}

export default DateUtil;