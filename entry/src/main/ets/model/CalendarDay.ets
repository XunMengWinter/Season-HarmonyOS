import { ZodiacRange } from "./ZodiacRange"
import { hilog } from "@kit.PerformanceAnalysisKit"

export class CalendarDay {
  title: string = ''
  subtitle?: string
  desc?: string
  day: string = ''
  month: string = ''
  datestamp: string = ''
  lunar: string = ''
  weekday: number = 0
  solarTerm?: string
  holiday?: string
  imageUrl: string = ''
  // weekStr: string = ""
  zodiac: string = ""

  constructor(data: Partial<CalendarDay>) {
    // Assign properties manually
    this.title = data.title || ''
    this.subtitle = data.subtitle
    this.desc = data.desc
    this.day = data.day || ''
    this.month = data.month || ''
    this.datestamp = data.datestamp || ''
    this.lunar = data.lunar || ''
    this.weekday = data.weekday || 0
    this.solarTerm = data.solarTerm
    this.holiday = data.holiday
    this.imageUrl = data.imageUrl || ''
    // this.weekStr = CalendarDay.getWeekStr(data.weekday || 0)
    this.zodiac = CalendarDay.getZodiacSign(data.datestamp || "")
  }

  get weekStr(): string {
    console.info('Getting weekStr for weekday:', this.weekday); // Debug weekday value
    const weekdays = ['', '星期一', '星期二', '星期三', '星期四', '星期五', '星期六', '星期天'];
    return weekdays[this.weekday] || '未知';
  }

  getSimpleStr(): string {
    return `${this.datestamp.substring(0, 4)} - ${this.datestamp.substring(4, 6)} - ${this.datestamp.substring(6)}`
  }

  static getWeekStr(weekday: number): string {
    console.log(weekday + "")
    const weekdays = ['', '星期一', '星期二', '星期三', '星期四', '星期五', '星期六', '星期天']
    return weekdays[weekday]
  }

  static getLunar(lunar: string): string {
    return lunar.split(' ').pop() || ''
  }

  static getZodiacSign(datestamp: string): string {
    if (datestamp.length !== 8) {
      console.warn('Invalid datestamp format, expected YYYYMMDD');
      return 'Unknown';
    }

    const year = parseInt(datestamp.substring(0, 4), 10);
    const month = parseInt(datestamp.substring(4, 6), 10);
    const day = parseInt(datestamp.substring(6, 8), 10);

    if (isNaN(year) || isNaN(month) || isNaN(day)) {
      console.warn('Invalid date components in datestamp');
      return 'Unknown';
    }

    const zodiacRanges: Array<ZodiacRange> = [
      new ZodiacRange('aquarius', 1, 20, 2, 18),
      new ZodiacRange('pisces', 2, 19, 3, 20),
      new ZodiacRange('aries', 3, 21, 4, 19),
      new ZodiacRange('taurus', 4, 20, 5, 20),
      new ZodiacRange('gemini', 5, 21, 6, 21),
      new ZodiacRange('cancer', 6, 22, 7, 22),
      new ZodiacRange('leo', 7, 23, 8, 22),
      new ZodiacRange('virgo', 8, 23, 9, 22),
      new ZodiacRange('libra', 9, 23, 10, 23),
      new ZodiacRange('scorpio', 10, 24, 11, 22),
      new ZodiacRange('sagittarius', 11, 23, 12, 21),
      new ZodiacRange('capricornus', 12, 22, 1, 19)
    ];

    for (let i = 0; i < zodiacRanges.length; i++) {
      const range = zodiacRanges[i];
      const isWithinRange =
        (month === range.startMonth && day >= range.startDay) ||
          (month === range.endMonth && day <= range.endDay);

      if (isWithinRange) {
        return range.zodiac;
      }
    }

    return 'Unknown';
  }
}