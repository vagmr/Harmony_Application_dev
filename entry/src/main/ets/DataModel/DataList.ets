//分离页面内的数据
class ExData{
  private  ExampleData = [
    '测试','测试','测试','测试','测试',
  ]
  public get(){
    return this.ExampleData
  }
}
export default  new ExData()