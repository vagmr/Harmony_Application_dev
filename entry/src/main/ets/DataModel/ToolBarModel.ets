class barItem{
  img:Resource | string
  text:string | Resource
  routerUrl?:string

  constructor(img:Resource | string,text:Resource | string,routerUrl?:string) {
        this.img = img
        this.text = text
        this.routerUrl = routerUrl
  }
}
class BarModel{
  private BarList = [
    new barItem($r("app.media.stateSvg"),"状态管理","pages/StateManagePage"),
    new barItem($r("app.media.homesvg"),"首页","pages/Index"),
    new barItem($r("app.media.kfzSvg"),"布局测试","pages/FruItShow/Home"),
    new barItem($r("app.media.animateSvg"),"动画测试","pages/AnimationTry")
  ]
  public  get(){
  return this.BarList
}
}
export  default  new BarModel()