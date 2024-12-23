export class ZodiacRange {
  zodiac: string; // The name of the zodiac sign
  emoji: string;
  startMonth: number; // The starting month of the zodiac range
  startDay: number; // The starting day of the zodiac range
  endMonth: number; // The ending month of the zodiac range
  endDay: number; // The ending day of the zodiac range

  constructor(
    zodiac: string,
    emoji: string,
    startMonth: number,
    startDay: number,
    endMonth: number,
    endDay: number,
  ) {
    this.zodiac = zodiac;
    this.emoji = emoji
    this.startMonth = startMonth;
    this.startDay = startDay;
    this.endMonth = endMonth;
    this.endDay = endDay;
  }
}