// 导入路由
import router from '@ohos.router';
import {getSaying} from "../../request/methodApi"
import { Data, sayingType } from '../type/request/comon_res';

// 规范导航类型
class Navigation{
    public  Title:Resource | string
    public  Url:String
    public  params?:object
 
  constructor(Title:Resource | string,Url:String,params?:object) {
    this.Title = Title;
    this.Url = Url
    this.params = params
  }
}


@Entry
@Component
struct Index {
  // 声明状态变量
  @State message: string = 'Vagmr App'
  @State Saying:Resource= $r("app.string.Saying")
  @State randomText:string = "劝君莫忘少年志，曾许人间第一流"
  // 定义导航按钮集合
  private  navigationItem:Array<Navigation> = [
    new Navigation($r("app.string.ImagePcs") ,"pages/ImagePcs"),
    new Navigation($r("app.string.About"),"pages/About"),
    new Navigation($r("app.string.shopList"),"pages/shopList"),
    new Navigation($r("app.string.webView"),"pages/ShowWeb"),
    new Navigation("鸡汤语句","pages/TodoList",{text:"少年不知勤学早，老大方悔读书迟"}),
    new Navigation("导航页","pages/NavigationPage")
  ]
  getData = async() =>{
    const str = await getSaying();
    let res:Data<sayingType> = JSON.parse(str)
    setTimeout(() => {
      this.randomText = res.data.content
    },2000)
  }
aboutToAppear(){
    this.getData()
}
  build() {
    // 纵向主容器
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
         .stateStyles({
           normal:{
             .backgroundColor("#f13542")
           },pressed:{
             .backgroundColor("#ff8e474d")
           }
         })
      Column({space:8}){
        // 遍历渲染导航按钮
       ForEach(this.navigationItem,el=>{
         Button(el.Title).backgroundColor("#ff5fd0b4")
           .width(300).height(50).fontWeight(400)
           .fontSize(30).fontColor("#ffd81818")
           .stateEffect(true)
           // 点击后跳转到对应页面
           .onClick(() => {
           router.pushUrl({
             url:el.Url,
             params:el.params
           })
       })
        })
      }.height(460).width("100%").backgroundColor("#eee")
      .justifyContent(FlexAlign.SpaceEvenly)
      .alignItems(HorizontalAlign.Center)
      .borderRadius(5)
      if(this.randomText){
        Text(this.randomText).fontSize(20)
          .width(300).margin({top:40})
          .textAlign(TextAlign.Center)
          .height(65).backgroundColor("#ffe9e5e5")
          .padding(10).border({width:1,radius:5})
          .fontWeight(400).fontColor("#f13")
      }else{
        Text(this.Saying).fontSize(20)
          .width(300).margin({top:80})
          .textAlign(TextAlign.Center)
          .height(65).backgroundColor("#ffe9e5e5")
          .padding(10).border({width:1,radius:5})
          .fontWeight(400).fontColor("#f13")
      }

    }    
    .width("100%")
    .height("100%")
  }
}