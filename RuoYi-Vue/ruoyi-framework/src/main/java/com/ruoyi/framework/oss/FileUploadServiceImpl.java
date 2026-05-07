package com.ruoyi.framework.oss;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.ruoyi.common.config.RuoYiConfig;
import com.ruoyi.common.utils.file.FileUploadUtils;
import com.ruoyi.equipment.info.service.IFileUploadService;

/**
 * 文件上传服务实现类
 * 
 * @author ganyu
 */
@Service
public class FileUploadServiceImpl implements IFileUploadService 
{
    @Autowired(required = false)
    private AliyunOssUtil aliyunOssUtil;

    @Override
    public String upload(MultipartFile file) 
    {
        return upload(file, "equipment");
    }

    @Override
    public String upload(MultipartFile file, String folder) 
    {
        try 
        {
            if (RuoYiConfig.isOssEnabled() && aliyunOssUtil != null) 
            {
                return aliyunOssUtil.upload(file, folder);
            } 
            else 
            {
                return FileUploadUtils.upload(RuoYiConfig.getUploadPath(), file);
            }
        } 
        catch (IOException e) 
        {
            throw new RuntimeException("文件上传失败: " + e.getMessage(), e);
        }
    }
}
