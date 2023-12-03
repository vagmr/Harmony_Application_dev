import router from '@ohos.router'
import { getLoveWord } from '../../request/methodApi'
import  toolBarModel from "../DataModel/ToolBarModel"
import { Data, wordType } from '../type/comon_res'


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
  @State  wordList:Array<wordType> = []
  @State isShow:boolean = false
  getWords   = async() =>{
      let resStr = await getLoveWord()
      const res: Data<wordType[]> = JSON.parse(resStr)
      this.wordList.push(...res.data)
    // console.log(JSON.stringify(this.wordList));
  }
  aboutToAppear(){
      this.getWords()
  }
  build() {
    Column() {
      Navigation(){
     if(this.isShow){
       Column(){
         Text("你点了也没有用").fontSize(24).fontColor("#ff3ab718")
       }.width("80%").margin({top:-60,bottom:10}).height(40)
       .backgroundColor("#ff0a0a0a")
       .justifyContent(FlexAlign.Center)
     }
        TextInput({ placeholder: 'search...' })
          .placeholderFont({size:20,weight:400})
          .width('90%')
          .height(45)
          .backgroundColor('#FFFFFF')
         .fontSize(24)
        List({ space: 12, initialIndex: 0 }) {
          ForEach(this.wordList, (item) => {
            ListItem() {
              Text( item.content)
                .width('90%')
                .height(72)
                .backgroundColor('#FFFFFF')
                .borderRadius(24)
                .fontSize(16)
                .fontWeight(500)
                .textAlign(TextAlign.Center)
            }.editable(true)
            .onClick(() => {
            this.isShow = true
              setTimeout(() => {
                this.isShow = false
              },1000)
            })
          })
        }
        .height(500)
        .width('100%')
        .margin({ top: 12, left: '10%' })
      }.title(this.NavigationTitle())
        .toolBar(this.NavigationBar())
    }
    .width('100%')
    .height('100%')
    .backgroundColor("#F1F1F1")
  }

  @Builder NavigationTitle(title: string = "导航页面") {
    Row() {
      Text(title)
        .fontSize(30).height(30)
    }.width("100%").height(30).justifyContent(FlexAlign.Center)
  }
  //工具栏构建器
  @Builder NavigationBar(){
    Row(){
      ForEach(toolBarModel.get(),el => {
        Column({space:5}){
          Image(el.img).width(40).height(40)
          Text(el.text).fontSize(20).fontColor("#ff2f7f64")
        }.width(130).height(100)
        .onClick(() => {
          if(el.routerUrl){
            router.pushUrl({url:el.routerUrl})
          }
        })
      })
    }
  }
}