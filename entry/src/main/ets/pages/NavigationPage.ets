import router from '@ohos.router'
import { getLoveWord } from '../../request/methodApi'
import toolBarModel from "../DataModel/ToolBarModel"
import type { Data, wordType } from '../type/request/comon_res'

@Entry
@Component
struct NavigationPage {
  // @Builder
  // SubMenu() {
  //   Menu() {
  //     MenuItem({ content: "复制", labelInfo: "Ctrl+C" })
  //     MenuItem({ content: "粘贴", labelInfo: "Ctrl+V" })
  //   }
  // }
  @State wordList: Array<wordType> = []
  @State isShow: boolean = false
  @State showInfo: string = "你点了也没有用"
  getWords = async () => {
    try {
      let res = await getLoveWord()
      this.wordList.push(...res.data)
    } catch (e) {
      if (e.code = 2300006) {
        this.isShow = true
        this.showInfo = "网络连接失败"
        setTimeout(() => {
          this.isShow = false
        }, 1500)
      }
    }
    // console.log(JSON.stringify(this.wordList));
  }

  aboutToAppear() {
    this.getWords()

  }

  build() {
    Column() {
      Navigation() {
        if (this.isShow) {
          Column() {
            Text(this.showInfo).fontSize(24).fontColor("#ff3ab718")
          }
          .width("80%")
          .margin({ top: -60, bottom: 10 })
          .height(40)
          .backgroundColor("#ff0a0a0a")
          .justifyContent(FlexAlign.Center)
        }
        TextInput({ placeholder: 'search...' })
          .placeholderFont({ size: 20, weight: 400 })
          .width('90%')
          .height(45)
          .backgroundColor('#FFFFFF')
          .fontSize(24)
        List({ space: 12, initialIndex: 0 }) {
          ForEach(this.wordList, (item) => {
            ListItem() {
              Row() {
                Text(item.content)
                  .width('80%')
                  .fontSize(16)
                  .fontWeight(500)
              }
              .width("90%")
              .justifyContent(FlexAlign.Center)
              .height("12.5%")
              .backgroundColor('#FFFFFF')
              .borderRadius(24)
              .align(Alignment.Center)
            }.editable(true)
            .width("100%")
            .onClick(() => {
              this.isShow = true
              setTimeout(() => {
                this.isShow = false
              }, 1000)
            })
          })
        }
        .layoutWeight(1)
        .width('100%')
        .margin({ top: 12, bottom: 30 })
      }.title(this.NavigationTitle())
      .toolBar(this.NavigationBar())
    }
    .width('100%')
    .height('100%')
    .backgroundColor("#ccc")
  }

  @Builder NavigationTitle(title: string = "导航页面") {
    Row() {
      Text(title)
        .fontSize(30).height(30)
    }.width("100%").height(30).justifyContent(FlexAlign.Center)
  }
  //工具栏构建器
  @Builder NavigationBar() {
    Row() {
      ForEach(toolBarModel.get(), el => {
        Column({ space: 5 }) {
          Image(el.img)
            .width(40).height(40)
            .interpolation(ImageInterpolation.High)
            .fillColor("#d1d82767")
          Text(el.text).fontSize(20).fontColor(Color.Black)
        }.width("25%").height(90)
        .onClick(() => {
          if (el.routerUrl) {
            router.pushUrl({ url: el.routerUrl })
          }
        })
      })
    }
  }
}