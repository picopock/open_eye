import { AxiosRequestConfig } from '@ohos/axios';
import { DEFAULT_URL_PREFIX } from '../../constants/url';
import axios from './axios';

export class BaseService {
  urlPrefix: string = '';

  constructor(urlPrefix: string = DEFAULT_URL_PREFIX) {
    this.urlPrefix = urlPrefix;
  }

  getUri(config?: AxiosRequestConfig): string {
    const _config = {...config, url: `${this.urlPrefix}${config.url}`};
    return axios.getUri(_config);
  }

  prefixUrl(url: string): string {
    return `${this.urlPrefix}${url}`;
  }

  prefixConfigUrl<D>(config?: AxiosRequestConfig<D>): AxiosRequestConfig<D> {
    if(config?.url) {
      return {
        ...config,
        url: this.prefixUrl(config.url)
      }
    }

    return config;
  }

  request<T = any, R = T, D = any>(config: AxiosRequestConfig<D>): Promise<R> {
    const _config = this.prefixConfigUrl<D>(config);
    return axios.request<T, R, D>(_config);
  }

  get<T = any, R = T, D = any>(url: string, config?: AxiosRequestConfig<D>): Promise<R>{
    const _url = this.prefixUrl(url);
    const _config = this.prefixConfigUrl<D>(config);
    return axios.get<T, R, D>(_url, _config);
  }

  delete<T = any, R = T, D = any>(url: string, config?: AxiosRequestConfig<D>): Promise<R>{
    const _url = this.prefixUrl(url);
    const _config = this.prefixConfigUrl<D>(config);
    return axios.delete<T, R, D>(_url, _config);
  }

  head<T = any, R = T, D = any>(url: string, config?: AxiosRequestConfig<D>): Promise<R>{
    const _url = this.prefixUrl(url);
    const _config = this.prefixConfigUrl<D>(config);
    return axios.head<T, R, D>(_url, _config);
  }

  options<T = any, R = T, D = any>(url: string, config?: AxiosRequestConfig<D>): Promise<R>{
    const _url = this.prefixUrl(url);
    const _config = this.prefixConfigUrl<D>(config);
    return axios.options<T, R, D>(_url, _config);
  }

  post<T = any, R = T, D = any>(url: string, data?: D, config?: AxiosRequestConfig<D>): Promise<R>{
    const _url = this.prefixUrl(url);
    const _config = this.prefixConfigUrl<D>(config);
    return axios.post<T, R, D>(_url, data, _config);
  }

  put<T = any, R = T, D = any>(url: string, data?: D, config?: AxiosRequestConfig<D>): Promise<R>{
    const _url = this.prefixUrl(url);
    const _config = this.prefixConfigUrl<D>(config);
    return axios.put<T, R, D>(_url, data, _config);
  }

  patch<T = any, R = T, D = any>(url: string, data?: D, config?: AxiosRequestConfig<D>): Promise<R>{
    const _url = this.prefixUrl(url);
    const _config = this.prefixConfigUrl<D>(config);
    return axios.patch<T, R, D>(_url, data, _config);
  }

  postForm<T = any, R = T, D = any>(url: string, data?: D, config?: AxiosRequestConfig<D>): Promise<R>{
    const _url = this.prefixUrl(url);
    const _config = this.prefixConfigUrl<D>(config);
    return axios.postForm<T, R, D>(_url, data, _config);
  }

  putForm<T = any, R = T, D = any>(url: string, data?: D, config?: AxiosRequestConfig<D>): Promise<R>{
    const _url = this.prefixUrl(url);
    const _config = this.prefixConfigUrl<D>(config);
    return axios.putForm<T, R, D>(_url, data, _config);
  }

  patchForm<T = any, R = T, D = any>(url: string, data?: D, config?: AxiosRequestConfig<D>): Promise<R>{
    const _url = this.prefixUrl(url);
    const _config = this.prefixConfigUrl<D>(config);
    return axios.patchForm<T, R, D>(_url, data, _config);
  }
}