
/**
 * 转换图片链接，img 前添加前缀 ali-
 */
export const imageUrlFormat = (url = '') => {
  return url.replace(/^(https?:\/\/)img\.(.*)$/, "$1ali-img.$2");
}