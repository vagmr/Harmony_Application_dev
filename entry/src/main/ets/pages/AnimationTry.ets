// 第一个tab栏的内容
import http from '@ohos.net.http'
@Builder function  indexContent(){
  Column() {
    Text(this.title).fontSize(50)
      .margin({bottom:5})
    Column(){
      Text("劝君莫忘少年志，曾许人间第一流")
        .fontSize(30)
        .backgroundColor(Color.Black)
        .width(this.txtWidth).height(this.txtHeight).align(Alignment.Top)
        .textAlign(TextAlign.Center)
        .fontColor(Color.White)
      Button("点击按钮")
        .type(ButtonType.Normal)
        .margin({top:10}).padding(20)
        .onClick(() => {
          animateTo({
            duration:1500,
            onFinish: () =>{
              if (this.isPlay) {
                this.title = "动画播放结束"
              }else {
                this.title = "重新播放"
              }
            }
          },() =>{
            if (this.isPlay){
              this.txtWidth = "0%"
              this.txtHeight = 0
            }
            else {
              this.txtWidth = "60%"
              if (this.txtWidth == "60%") {
                this.txtHeight = 120
              }
            }
            this.isPlay = !this.isPlay
          })
        })
    }.height(400).width("80%")
    .border({width:3,radius:5})
    .margin({top:"10%"}).justifyContent(FlexAlign.Center)
    Row(){
      Image("https://vagmr-event.oss-cn-beijing.aliyuncs.com/24a071ab-fd58-4d9d-b393-05d2b5992bdd.jpg")
        .width(150).height(150)
        .clip(new  Circle({width:"100%",height:"100%"}))
        .rotate({
          x:1,
          y:1,
          z:1,
          angle:this.angle
        })
        .onClick(() => {
          animateTo({
            duration:2000,
            playMode:PlayMode.Alternate,
            curve:Curve.EaseOut
          },()=>{
            if(this.isRotate){
              this.angle = 0
            }else {
              this.angle = 360
            }
            this.isRotate = !this.isRotate
          })
        })
    }.height(200).width(200)
    .margin({top:10})
    .justifyContent(FlexAlign.Center)
    .border({width:2,radius:"50"})
  }
  .width('100%')
  .height('100%')
  .justifyContent(FlexAlign.Start)
  .alignItems(HorizontalAlign.Center)
}
// bar的构建器
@Builder function bar
(index: number, name: string, img?: Resource | string,
) {
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
  }.width("70%")
}

@Extend(Text) function  txtSty(color:string | Color = Color.Red){
  .width("80%")
  .border({width:2,radius:5})
  .height(50)
  .fontSize(28)
  .textAlign(TextAlign.Center)
  .margin({top:10})
  .fontColor(color)
  .padding(10)
  .fontWeight(600)
}

interface  poemApiType{
  code:number;
  message:string;
  data:{content:string,author:string,works:string}
}

interface  poemItem{
  id:number;
  content:string;
  author:string
}

let getPoem = async (size:number) =>{
  // 2. 常见http请求对象
  let httpReq = http.createHttp()
  // 3. 发起请求
   let res=   await httpReq.request('https://oiapi.net/API/Sentences',{
     expectDataType:http.HttpDataType.OBJECT,
   })
  let {data:{content,author}}= res.result as poemApiType
  let result:poemItem = {id:++size,content,author}
  return result
}
@Extend(Button) function listBtnSty(callback:Function){
  .type(ButtonType.Normal)
  .padding(10)
  .width("48%")
  .backgroundColor(Color.Black)
  .fontSize(20)
  .fontColor(Color.White)
  .height(50)
  .margin({right:10})
  .border({width:2,radius:5,color:Color.White})
  .onClick( () => callback())
}
@Builder function  listBtn({text,callback}:{text:string,callback:Function}){
  Button(text)
    .listBtnSty(callback)
}
enum flagType{
  unshift=0,
  push,
  shift,
  pop
}
let ope = async (poemList,flag:flagType) => {
  let sj =  await getPoem(poemList.length)
  if(flag == flagType.unshift){
    poemList.unshift(sj)
  }
  else if(flag == flagType.push){
    poemList.push(sj)
  }
  else if(flag == flagType.pop){
    poemList.pop(sj)
  }
  else if(flag == flagType.shift){
    poemList.shift(sj)
  }
}
// grid布局的构建器
@Builder function  listBuilder(){
List({space:15}){
    ForEach(this.poemList,(item:poemItem) => {
      ListItem() {
        poemItemC({ item: item })
      }.width("100%")
      .animation({duration:1330,playMode:PlayMode.Alternate
      ,curve:Curve.EaseIn})
    })
  ListItem(){
    Grid(){
      GridItem(){
    Button("添加到首位").listBtnSty(() =>{
      animateTo({duration:1200,playMode:PlayMode.Alternate},
        async () => {
          let sj =  await getPoem(this.poemList.length)
          this.poemList.unshift(sj)
        })
    })
      }.margin({bottom:10})
      GridItem(){
        listBtn({text:"添加到未尾",callback:
        () => ope(this.poemList,flagType.push)
        })
      }
      GridItem(){
        listBtn({text:"删除首位",callback:
        () => ope(this.poemList,flagType.shift)})
      }.margin({bottom:10})
      GridItem(){
        listBtn({text:"删除末尾",callback:
        () => ope(this.poemList,flagType.pop)})
      }
    }
    .layoutDirection(GridDirection.Row)
   .rowsTemplate("1fr 1fr")
    .width("96%").border({width:1,radius:5,color:"#f1345c"})
    .padding(10)
    .height(120)
  }.width("100%")
}
.layoutWeight(1)
  // .divider({strokeWidth:2,color:"#f1356d",startMargin:20
  // ,endMargin:20})
  .backgroundColor("#fff")
  .margin({top:5,bottom:10})
  .padding({top:10})
  .borderRadius(5)
}

//每一个grid项里面的内容
@Component
struct  poemItemC{
  item:poemItem = {} as poemItem
  build(){
    Column(){
      Text(this.item.content + "--" +this.item.author)
        .width("80%").border({width:2,radius:5})
        .padding(8)
        .height(70)
        .textAlign(TextAlign.Center)
    }
  }
}


 // 第二个tab栏的内容
@Component
struct  subContent{
  @State isShow:boolean = false
  @State imgWidth :string = "100%"
  @State imgHeight :  number  = 250
  @State isHit :  boolean  = false
  // // grid的控制器
  // scroller: Scroller = new Scroller()

@State poemList:Array<poemItem> =[
    {id:1,content:"天势围平野，河流入断山",author:"畅当"},
    {id:2,content:"寒声隐地，初听中夜入梧桐。",author:"叶梦得"},
    {id:3,content:"回首向来萧瑟处，归去，也无风雨也无晴",author:"苏轼"},
    {id:4,content:"竹树夹流水，孤城对远山。",author:"高适"}
  ]

  reset (){
    this.imgHeight = 250
    this.imgWidth = "100%"
    this.isHit = false
  }
  build(){
    Column(){
      Button(this.isShow ? "隐藏" : "显示")
        .margin({top:10}).width(100).height(35)
      .onClick(() => {
        animateTo({
          duration:900,
          curve:Curve.EaseOut,
          playMode:PlayMode.Alternate
        },() => {
          this.isShow = !this.isShow
        if(this.isHit){
          this.reset()
        }
        })
      })
      if(this.isShow){
        Column(){
         Column(){
           Image($r("app.media.JBWMAdX")).width(this.imgWidth)
             .height(this.imgHeight)
             .margin({top:10})
             .objectFit(ImageFit.Fill)
         }.width("80%").height(300)
          .margin({bottom:10})
          .backgroundColor("#ddd")
          .clip(new Rect({width:"100%",height:"100%",radius:10}))
          Text("陌猪是大笨蛋!!!")
            .txtSty()
          Button(this.isHit ? "打扁了，爽!!!": "一拳把陌猪打扁")
            .width(250).height(50)
            .fontSize(25).type(ButtonType.Normal)
            .margin({top:10})
            .onClick(() => {
            animateTo({
              duration:1300,
              curve:Curve.Sharp,
              playMode:PlayMode.Alternate
            },() => {
              this.imgWidth = "70%"
              this.imgHeight = 280
              this.isHit = true
            })
            })
        }
        .transition(
          {type:TransitionType.All,translate:{x:300,y:-200}
          ,rotate:{angle:360}})
      }
      listBuilder()

    }.width("100%").height("100%")
    .backgroundColor("#ccc")
  }
}

@Entry
@Component
struct AnimationTry {
  @State txtWidth :  string  = "0%"
  @State txtHeight :  number  = 0
  @State title: string =  "动画展示页面"
  @State isPlay: boolean = false
  // 角度
  @State angle: number = 0
  // 是否旋转
  @State isRotate: boolean = false
  @State currentIndex : number   = 0
  build() {
    Tabs({barPosition:BarPosition.End}){
      TabContent(){
        indexContent()
      }.tabBar(bar(0,"首屏",$r("app.media.homesvg")))
      TabContent(){
        subContent()
      }.tabBar(bar(1,"副屏",$r("app.media.pc")))
    }//非垂直显示
    .vertical(false)
    .barMode(BarMode.Fixed)
    .barWidth("100%")
    .barHeight(65)
    .animationDuration(500)
    .onChange((index: number) => {
      this.currentIndex = index
    })
  }
}