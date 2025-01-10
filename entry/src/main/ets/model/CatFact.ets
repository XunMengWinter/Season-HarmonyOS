// Define the CatFact and Translate interfaces
export interface CatFact {
  translate: Translate[];
  length: number;
  fact: string;
}

export interface Translate {
  dst: string;
  src: string;
}