import { requestInstance } from "./comRequest"
export  const getMethod = async () => {
    const res:any = await requestInstance(
        {url:"http://localhost:3000/api/quotes"
        })
console.log(res)
}
