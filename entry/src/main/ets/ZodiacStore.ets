import { Zodiac } from './model/Zodiac';

export class ZodiacStore {
  private static instance: ZodiacStore;
  public zodiacDict: Record<string, Zodiac> = {}; // Global dictionary

  private constructor() {}

  public static getInstance(): ZodiacStore {
    if (!ZodiacStore.instance) {
      ZodiacStore.instance = new ZodiacStore();
    }
    return ZodiacStore.instance;
  }

  public setZodiacData(zodiacList: Zodiac[]): void {
    this.zodiacDict = zodiacList.reduce((dict, zodiac) => {
      dict[zodiac.emoji] = zodiac; // Use emoji as key
      return dict;
    }, {} as Record<string, Zodiac>);
  }

  public getZodiacData(): Record<string, Zodiac> {
    return this.zodiacDict;
  }
}