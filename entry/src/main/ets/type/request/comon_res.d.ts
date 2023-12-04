//标准返回模式
export  interface Data<T> {
  code: string
  msg: string
  data: T
}
//返回值类型
export  interface sayingType{
  id:number
  content:string
}
export  interface  wordType{
  code:number
  content:string
}