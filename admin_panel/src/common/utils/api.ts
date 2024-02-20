import axios from "axios";
import qs from "qs";
import AppConsts from "../../library/appconsts";



import { requestErrorInterceptor, requestInterceptor, responseErrorInterceptor, responseInterceptor } from "./interceptors";
const http = axios.create({
  baseURL: AppConsts.remoteServiceBaseUrl,
  headers: { "Content-Type": "application/json" },
  timeout: 30000,
  paramsSerializer: (params) => {
    return qs.stringify(params, { encode: false });
  },
});


http.interceptors.request.use(requestInterceptor , requestErrorInterceptor)
http.interceptors.response.use(responseErrorInterceptor , responseInterceptor);
export default http;
