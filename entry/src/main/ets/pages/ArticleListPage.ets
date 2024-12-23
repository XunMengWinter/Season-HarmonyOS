import router from '@ohos.router';
import { Article } from '../model/Article';
import { ArticleViewModel } from '../viewmodel/ArticleViewModel';
import common from '@ohos.app.ability.common';
import BrowserUtil from '../net/BrowserUtil';

@Entry
@Component
struct ArticleListPage {
  @State viewModel: ArticleViewModel = new ArticleViewModel();

  build() {
    Stack() {
      List({ space: 8 }) {
        ForEach(this.viewModel.articleList, (article: Article, index: number) => {
          if (article.type === 'article') {
            ArticleRow({ article })
              .onClick(() => {
                // let context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext;
                // BrowserUtil.startBrowsableAbility(context, article.url);
                router.pushUrl({
                  url: 'pages/BrowserPage',
                  params: {
                    title: article.title,
                    url: article.url,
                  },
                })
              })
          } else {
            ManualRow({ article })
              .onClick(() => {
                // let context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext;
                // BrowserUtil.startBrowsableAbility(context, article.url);
                router.pushUrl({
                  url: 'pages/BrowserPage',
                  params: {
                    title: article.title,
                    url: article.url,
                  },
                })
              })
          }
        });
      }
      .margin({
        top: 48
      })
      .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.BOTTOM])

      Stack() {
        // 顶部标题和返回按钮
        Row() {
          Text('←')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .padding({ left: 16, right: 16 })
            .onClick(() => {
              router.back(); // 返回逻辑
            });

          Text('养猫知识')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .flexGrow(1)
            .textAlign(TextAlign.Center);

          Text('←')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .padding({ left: 16, right: 16 })
            .opacity(0)
        }
        .padding({ top: 16 })
        .width('100%');
      }
    }
    .align(Alignment.Top)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.BOTTOM])
    .onAppear(() => {
      if (this.viewModel.articleList.length < 5) {
        this.viewModel.getArticles();
      }
    });
  }
}

@Component
struct ManualRow {
  @Prop article: Article;
  private imageRadius: number = 12;

  build() {
    Row({ space: 16 }) {
      // 文章封面
      Image(this.article.cover)
        .width(100)
        .height(100)
        .backgroundColor('#e0e0e0')
        .borderRadius(10)
        .clip(true)

      // 文章标题和发布时间
      Column({ space: 8 }) {
        Text(this.article.title)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .maxLines(2);
        Text(this.article.pbDate)
          .fontSize(12)
          .fontColor(Color.Gray);
      }
      .alignItems(HorizontalAlign.Start)
      .flexGrow(1)

      // 导航箭头
      Text('→')
        .fontSize(16)
        .fontColor(Color.Gray);
    }
    .width('90%') // 减去 margin 的左右总宽度
    .padding(16)
    .borderRadius(16)
    .clip(true)
    .shadow({
      color: '#5888',
      radius: 8,
      offsetX: 0,
      offsetY: 4,
    })
    .margin('5%');
  }
}

@Component
struct ArticleRow {
  @Prop article: Article;

  build() {
    Column({ space: 16 }) {
      // 图片
      Image(this.article.cover)
        .width('100%')
        .height(200)
        .backgroundColor('#e0e0e0')
        .clip(true)

      // 标题
      Text(this.article.title)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .padding({ left: 16, right: 16, bottom: 8 });
    }
    .borderRadius(16)
    .clip(true)
    .shadow({
      color: '#5888',
      radius: 8,
      offsetX: 0,
      offsetY: 4,
    })
    .margin(16);
  }
}
