import { sayingType, wordType } from '../ets/type/request/comon_res'
import { requestInstance } from './comRequest'


export  const getSaying = () => {
  return  requestInstance<sayingType>(
    {url:"https://fakeapi.vagmrgpt.top/saying" })
}
export const getLoveWord = () => {
  return requestInstance<wordType[]>
  ({url:"https://fakeapi.vagmrgpt.top/wordlist"})
}