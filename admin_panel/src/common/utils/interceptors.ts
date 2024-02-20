import { error } from "console"

export const requestInterceptor = (config:any)=>{
    localStorage.setItem("token" , "shumen istedi deye muallim yazdi")
    const token = localStorage.getItem("token")
    if(token) {
        config.headers["RADFE203"] = `Bearer ${token}`
    }
    return config
}

export const requestErrorInterceptor = (error:any) =>{
    return Promise.reject(error)
}

export const responseInterceptor = (response: any) =>{
    response
}

export const responseErrorInterceptor = (error:any)=>{
if(error.response.status === 401){
    localStorage.removeItem("token")
}
return Promise.reject(error)
}