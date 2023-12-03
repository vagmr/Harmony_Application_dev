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
    new barItem($r("app.media.state"),"状态管理","pages/StateManagePage"),
    new barItem($r("app.media.home"),"首页","pages/Index"),
    new barItem($r("app.media.kfz"),"开发中"),
  ]
  public  get(){
  return this.BarList
}
}
export  default  new BarModel()