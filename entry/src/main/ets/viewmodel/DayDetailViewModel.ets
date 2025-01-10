import http from '@ohos.net.http';
import { JSON } from '@kit.ArkTS';
import { CatFact } from '../model/CatFact';

export class DayDetailViewModel {
  catFact?: CatFact;
  isLoading: boolean = false;
  error: string | null = null;

  fetchCatFact(): void {
    console.info("Fetching cat fact...");
    const url = 'https://zzz.pet:3000/cat-fact';
    const httpRequest = http.createHttp();

    httpRequest.request(url, {
      method: http.RequestMethod.GET,
      header: { 'Content-Type': 'application/json' },
      readTimeout: 10000, // 10-second timeout
    })
      .then((response) => {
        if (response.result) {
          console.info("Cat fact fetched successfully:", response.result);
          // Parse the response and update the knowledge list
          this.catFact = JSON.parse(response.result.toString()) as CatFact;
        } else {
          console.error("Empty response from server.");
        }
      })
  }
}