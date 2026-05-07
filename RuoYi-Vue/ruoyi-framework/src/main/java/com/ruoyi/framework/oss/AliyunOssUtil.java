package com.ruoyi.framework.oss;

import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.util.Date;
import java.util.UUID;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import com.aliyun.oss.OSS;
import com.aliyun.oss.OSSException;
import com.aliyun.oss.model.CannedAccessControlList;
import com.aliyun.oss.model.ObjectMetadata;
import com.aliyun.oss.model.PutObjectRequest;
import com.ruoyi.common.exception.FileUploadException;
import com.ruoyi.framework.config.AliyunOssConfig;

/**
 * 阿里云OSS工具类
 * 
 * @author ganyu
 */
@Component
public class AliyunOssUtil
{
    @Autowired
    private OSS ossClient;

    @Autowired
    private AliyunOssConfig ossConfig;

    /**
     * 上传文件到OSS
     * 
     * @param file 上传的文件
     * @return 文件访问URL
     */
    public String upload(MultipartFile file) throws IOException
    {
        return upload(file, "");
    }

    /**
     * 上传文件到OSS
     * 
     * @param file 上传的文件
     * @param folder 文件夹路径
     * @return 文件访问URL
     */
    public String upload(MultipartFile file, String folder) throws IOException
    {
        try (InputStream inputStream = file.getInputStream())
        {
            String originalFilename = file.getOriginalFilename();
            String extension = originalFilename.substring(originalFilename.lastIndexOf("."));
            String fileName = UUID.randomUUID().toString().replace("-", "") + extension;

            String objectName;
            if (folder != null && !folder.isEmpty())
            {
                objectName = folder + "/" + fileName;
            }
            else
            {
                objectName = fileName;
            }

            ObjectMetadata metadata = new ObjectMetadata();
            metadata.setContentLength(file.getSize());
            metadata.setContentType(file.getContentType());

            PutObjectRequest putObjectRequest = new PutObjectRequest(
                    ossConfig.getBucketName(), objectName, inputStream, metadata);

            ossClient.putObject(putObjectRequest);

            ossClient.setObjectAcl(ossConfig.getBucketName(), objectName, CannedAccessControlList.PublicRead);

            return getFileUrl(objectName);
        }
        catch (OSSException e)
        {
            throw new FileUploadException("上传文件到OSS失败: " + e.getMessage());
        }
    }

    /**
     * 获取文件访问URL
     * 
     * @param objectName 对象名称
     * @return 文件URL
     */
    public String getFileUrl(String objectName)
    {
        if (ossConfig.getCustomDomain() != null && !ossConfig.getCustomDomain().isEmpty())
        {
            return ossConfig.getCustomDomain() + "/" + objectName;
        }

        return "https://" + ossConfig.getBucketName() + "." + ossConfig.getEndpoint().replace("http://", "").replace("https://", "") + "/" + objectName;
    }

    /**
     * 获取文件临时访问URL（带签名，适用于私有Bucket）
     * 
     * @param objectName 对象名称
     * @param expiration 过期时间（秒）
     * @return 带签名的URL
     */
    public String getSignedUrl(String objectName, long expiration)
    {
        Date expirationDate = new Date(System.currentTimeMillis() + expiration * 1000);
        URL url = ossClient.generatePresignedUrl(ossConfig.getBucketName(), objectName, expirationDate);
        return url.toString();
    }

    /**
     * 删除OSS上的文件
     * 
     * @param objectName 对象名称
     */
    public void deleteFile(String objectName)
    {
        try
        {
            ossClient.deleteObject(ossConfig.getBucketName(), objectName);
        }
        catch (OSSException e)
        {
            throw new FileUploadException("删除OSS文件失败: " + e.getMessage());
        }
    }

    /**
     * 判断文件是否存在
     * 
     * @param objectName 对象名称
     * @return 是否存在
     */
    public boolean doesObjectExist(String objectName)
    {
        return ossClient.doesObjectExist(ossConfig.getBucketName(), objectName);
    }
}
