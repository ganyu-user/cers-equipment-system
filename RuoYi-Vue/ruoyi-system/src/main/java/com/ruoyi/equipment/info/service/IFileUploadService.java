package com.ruoyi.equipment.info.service;

import org.springframework.web.multipart.MultipartFile;

/**
 * 文件上传服务接口
 * 
 * @author ganyu
 */
public interface IFileUploadService 
{
    /**
     * 上传文件
     * 
     * @param file 上传的文件
     * @return 文件访问URL
     */
    String upload(MultipartFile file);

    /**
     * 上传文件到指定文件夹
     * 
     * @param file 上传的文件
     * @param folder 文件夹路径
     * @return 文件访问URL
     */
    String upload(MultipartFile file, String folder);
}
