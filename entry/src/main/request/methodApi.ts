import { requestInstance } from './comRequest'


export  const getSaying = () => {
    return requestInstance(
      {url:"https://fakeapi.vagmrgpt.top/saying" })
}