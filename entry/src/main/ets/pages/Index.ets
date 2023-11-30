import router from '@ohos.router';
import {getMethod} from "../../request/requestMethod"

class Navigation{
    public  Title:Resource
    public  Url:String
 
  constructor(Title:Resource,Url:String) {
    this.Title = Title;
    this.Url = Url
  }
}

@Entry
@Component
struct Index {
  @State message: string = 'Vagmr App'
  @State Saying:Resource = $r("app.string.Saying")
  private  navigationItem:Array<Navigation> = [
    new Navigation($r("app.string.ImagePcs") ,"pages/ImagePcs"),
    new Navigation($r("app.string.About"),"pages/About"),
   new Navigation($r("app.string.shopList"),"pages/shopList"),
  new Navigation($r("app.string.webView"),"pages/ShowWeb")
  ]

  build() {
    Column() {
      Text(`${this.message}`)
        .width("300vp")
        .height("60vp")
        .fontColor("#d51515")
        .textAlign(TextAlign.Center)
        .textCase(TextCase.UpperCase)
        .fontSize("40fp")
        .fontWeight(FontWeight.Bold)
        .fontFamily("微软雅黑")
      Divider().vertical(false).color("#333").margin({bottom:30})
        Text("项目起始页，这是一切的起点").fontSize(24)
          .fontColor(Color.White).margin({left:10,bottom:50})
          .padding(10).backgroundColor("#f13542")
          .border({width:2,radius:5,style:BorderStyle.Solid})
          .onClick(() => {
            getMethod()
          })
      Column({space:8}){
       ForEach(this.navigationItem,el=>{
         Button(el.Title).backgroundColor("#ff5fd0b4")
           .width(300).height(50).fontWeight(400)
           .fontSize(30).fontColor("#ffd81818")
           .stateEffect(true).onClick(() => {
           router.pushUrl({
             url:el.Url
           })
       })
        })
      }.height(400).width("100%").backgroundColor("#eee")
      .justifyContent(FlexAlign.SpaceEvenly)
      .alignItems(HorizontalAlign.Center)
      .borderRadius(5)
      Text(this.Saying).fontSize(20)
        .width(300).margin({top:80})
        .textAlign(TextAlign.Center)
        .height(65).backgroundColor("#ffe9e5e5")
        .padding(10).border({width:1,radius:5})
        .fontWeight(400).fontColor("#f13")
    }    
    .width("100%")
    .height("100%")
  }
}