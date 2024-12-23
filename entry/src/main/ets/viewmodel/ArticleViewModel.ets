import http from '@ohos.net.http';
import { BaseResult } from '../model/BaseResult';
import { JSON } from '@kit.ArkTS';
import { Article } from '../model/Article';

export class ArticleViewModel {
  articleList: Article[] = [];
  isLoading: boolean = false;
  error: string | null = null;

  async getArticles() {
    this.isLoading = true;
    this.error = null;

    const url = 'https://maoxun.oss-cn-hangzhou.aliyuncs.com/fetch/cat_articles.json';
    const httpRequest = http.createHttp();
    try {
      const response = await httpRequest.request(url, {
        method: http.RequestMethod.GET, // Correct RequestMethod enum
        header: { 'Content-Type': 'application/json' },
        readTimeout: 10000, // Timeout in milliseconds
      });
      console.info("http result")
      // console.info(response.result.toString())
      // Check if response.result is valid and not null
      if (!response.result) {
        this.error = 'Empty response from server';
        console.error(this.error);
        return;
      }
      // Safely parse and cast to BaseResult<CalendarDay[]>
      const baseResult = JSON.parse(response.result.toString()) as BaseResult<Article[]>;
      this.articleList = baseResult.data!
    } catch (e) {
      // Handle any exceptions
      this.error = `Request failed: ${e.message || e}`;
      console.error(`Request error: ${this.error}`);
    } finally {
      this.isLoading = false;
    }
  }
}