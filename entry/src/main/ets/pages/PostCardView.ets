import { CalendarDay } from '../model/CalendarDay'

@Entry
@Component
struct PostCardView {
  @Prop post: CalendarDay

  private cardPadding: number = 24
  private dateSpacing: number = 12

  build() {
    Column({ space: 0 }) {
      // Image Section
      Image(this.post.imageUrl)
        .width('100%')
        .aspectRatio(1.5) // Scales the image
        .objectFit(ImageFit.Cover)
        .clip(CircleClip(this.cardPadding))
        .backgroundColor(Color.Gray)

      // Post Details Section
      Column({ space: 8 }) {
        // Title and Date Row
        Row({ space: this.dateSpacing }) {
          Column({ space: 8 }) {
            Text(this.post.title)
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Black)

            if (this.post.subtitle && this.post.subtitle !== '') {
              Text(this.post.subtitle)
                .fontSize(16)
                .fontColor(Color.Gray)
            }
          }.flexGrow(1)

          Text(this.post.day)
            .fontSize(36)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
        }

        // Description and Month Row
        Row({ space: this.dateSpacing }) {
          if (this.post.desc && this.post.desc !== '') {
            Text(this.post.desc)
              .fontSize(16)
              .fontColor(Color.Black)
          }

          Blank()

          Text(this.post.month)
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .fontFamily('Rounded')
            .fontColor(Color.Black)
        }
      }
      .padding(this.cardPadding)
      .backgroundColor(Color.White)
      .clip(CircleClip(this.cardPadding / 2))
      .shadow({ radius: this.cardPadding / 2, color: Color.Gray, offsetX: 0, offsetY: 4 })      .padding({ left: this.cardPadding, right: this.cardPadding })
    }
    .width('90%')
    .backgroundColor('#F7F8FA') // Background color for the card
    .borderRadius(this.cardPadding)
    .padding(this.cardPadding)
  }
}

function CircleClip(cardPadding: number): boolean {
  throw new Error('Function not implemented.')
}

function Spacer() {
  throw new Error('Function not implemented.')
}

export { PostCardView }
