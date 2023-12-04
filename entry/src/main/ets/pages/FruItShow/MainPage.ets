// bar的构建器
import router from '@ohos.router'
import { FoodInfo } from '../../type/FruitShowType/FruitType'

@Builder function bar
(index: number, name: string, img?: Resource | string,
 options: { width: string } = { width: "70%" }) {
  Column() {
    if (img) {
      Image(img)
        .width(30).height(30).fillColor("#cc096b88")
    }
    Text(name)
      .fontColor(this.currentIndex === index ? "#f1356d" : Color.Black)
      .fontSize(this.currentIndex === index ? 20 : 16)
      .fontWeight(this.currentIndex === index ? 500 : 400)
      .margin({ top: 5, bottom: 1 })
    Divider()
      .strokeWidth(4)
      .color('#007DFF')
      .opacity(this.currentIndex === index ? 1 : 0)
      .margin({ bottom: 4 })
  }.width(options.width)
}
// bar的内容组件
@Component
struct barContent {
  // 记录现在的索引值
  @State currentIndex: number = 0
  scroller: Scroller = new Scroller()
  private categories: Array<{
    id: number,
    name: string
  }> =
    [{ id: 0, name: "全部" }, { id: 1, name: '蔬菜' }, { id: 2, name: '水果' }, { id: 3, name: '坚果' }, {
      id: 4,
      name: '海鲜'
    }]
  private foods: Array<FoodInfo> = [
    {
      id: 0,
      name: '番茄',
      kk: 15,
      category: 1,
      img: $r('app.media.tomato'),
      rl: 10,
      yy:22,
      zf: 34
    },
    {
      id: 1,
      name: '核桃',
      kk: 646,
      category: 3,
      img: $r('app.media.walnut'),
      rl: 654,  // Calories in kcal per 100g
      yy: 15.2, // Nutrition in grams per 100g
      zf: 65.2  // Fat in grams per 100g
    },
    {
      id: 2,
      name: '黄瓜',
      kk: 16,
      category: 2,
      img: $r('app.media.cucumber'),
      rl: 15,   // Calories in kcal per 100g
      yy: 0.7,  // Nutrition in grams per 100g
      zf: 0.2   // Fat in grams per 100g
    },
    {
      id: 3,
      name: '蓝莓',
      kk: 57,
      category: 2,
      img: $r('app.media.blueberry'),
      rl: 57,   // Calories in kcal per 100g
      yy: 0.7,  // Nutrition in grams per 100g
      zf: 0.3   // Fat in grams per 100g
    },
    {
      id: 4,
      name: '螃蟹',
      kk: 97,
      category: 4,
      img: $r('app.media.crab'),
      rl: 87,   // Calories in kcal per 100g
      yy: 18,   // Nutrition in grams per 100g
      zf: 1.5   // Fat in grams per 100g
    },
    {
      id: 5,
      name: '冰淇淋',
      kk: 150,
      category: 5,
      img: $r('app.media.icecream'),
      rl: 207,  // Calories in kcal per 100g
      yy: 3,    // Nutrition in grams per 100g
      zf: 11    // Fat in grams per 100g
    },
    {
      id: 6,
      name: '洋葱',
      kk: 40,
      category: 1,
      img: $r('app.media.onion'),
      rl: 40,   // Calories in kcal per 100g
      yy: 1.1,  // Nutrition in grams per 100g
      zf: 0.1   // Fat in grams per 100g
    },
    {
      id: 7,
      name: '蘑菇',
      kk: 20,
      category: 1,
      img: $r('app.media.mushroom'),
      rl: 22,   // Calories in kcal per 100g
      yy: 3.1,  // Nutrition in grams per 100g
      zf: 0.3   // Fat in grams per 100g
    },
    {
      id: 8,
      name: '猕猴桃',
      kk: 61,
      category: 2,
      img: $r('app.media.kiwi'),
      rl: 61,   // Calories in kcal per 100g
      yy: 1.1,  // Nutrition in grams per 100g
      zf: 0.5   // Fat in grams per 100g
    },
    {
      id: 9,
      name: '火龙果',
      kk: 55,
      category: 2,
      img: $r('app.media.pitaya'),
      rl: 60,   // Calories in kcal per 100g
      yy: 9,    // Nutrition in grams per 100g
      zf: 0.6   // Fat in grams per 100g
    },
    {
      id: 10,
      name: '草莓',
      kk: 32,
      category: 2,
      img: $r('app.media.strawberry'),
      rl: 32,   // Calories in kcal per 100g
      yy: 2,    // Nutrition in grams per 100g
      zf: 0.3   // Fat in grams per 100g
    },
    {
      id: 11,
      name: '牛油果',
      kk: 171,
      category: 2,
      img: $r('app.media.avocado'),
      rl: 160,  // Calories in kcal per 100g
      yy: 2,    // Nutrition in grams per 100g
      zf: 15    // Fat in grams per 100g
    },
  ]

  build() {
    Tabs({ barPosition: BarPosition.Start }) {
      ForEach(this.categories, (el, index) => {
        TabContent() {
          Grid(this.scroller) {
            ForEach(
              // 根据类别过滤数组
                el.id == 0 ? this.foods : this.foods.filter(item => item.category == el.id)
              , el => {
              GridItem() {
                FoodItem({ food: el })
              }
            })
          }.layoutDirection(GridDirection.Row)
          .columnsTemplate("1fr 1fr")
          .columnsGap(6)
          .rowsGap(6)
        }.tabBar(bar(index, el.name))
      })
    }
    .vertical(false)
    .barMode(BarMode.Fixed)
    .barWidth("100%")
    .barHeight(50)
    .animationDuration(200)
    .onChange((index: number) => {
      this.currentIndex = index
    })
  }
}

// 每一个grid项
@Component
struct FoodItem {
  private food: FoodInfo

  build() {
    Column() {
      Image(this.food.img).width('100%').height(152).backgroundColor('#f1f3f5').objectFit(ImageFit.Contain)
      Row() {
        Text(this.food.name).fontSize(16).fontColor(0x3E3E3E)
        Blank()
        Text(this.food.kk + ' 千卡').fontSize(16).fontColor(0x3E3E3E)
      }
      .width('100%')
      .height(32)
      .backgroundColor('#e5e5e5')
      .padding({ left: 12, right: 12 })
    }
    .clip(new Rect({ width: '100%', height: '100%', radius: 6 }))
    .onClick(() => {
      console.log(JSON.stringify(this.food))
      //跳转传参
      router.pushUrl({
        url:"pages/FruItShow/Detail",
        params:this.food
      })
    })
  }
}

@Entry
@Component
struct MainPage {
  // 记录现在的索引值
  @State currentIndex: number = 0

  build() {
    // tab栏
    Tabs({ barPosition: BarPosition.End }) {
      // 点击tab栏时显示的内容
      TabContent() {
        barContent()
      }.tabBar(bar(0, "首页", $r("app.media.homesvg")))

      TabContent() {
        Column() {
          Text("还在开发中.......").fontSize(35)
            Button("返回首页")
              .onClick(() => {
                router.pushUrl({url:"pages/Index"})
              }).width("60%")
              .height(40)
        }.width("80%").height("40%")
        .justifyContent(FlexAlign.End)
        .alignItems(HorizontalAlign.Center)
      }
      .tabBar(bar(1, "记录", "https://vagmr-event.oss-cn-beijing.aliyuncs.com/bb377ee6-a14f-4227-84e9-5cd2df2b40d3.svg"))
    }
    //非垂直显示
    .vertical(false)
    .barMode(BarMode.Fixed)
    .barWidth("100%")
    .barHeight(65)
    .animationDuration(200)
    .onChange((index: number) => {
      this.currentIndex = index
    })
  }
}
