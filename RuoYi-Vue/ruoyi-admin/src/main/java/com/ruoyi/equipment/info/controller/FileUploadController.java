package com.ruoyi.equipment.info.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.equipment.info.service.IFileUploadService;

/**
 * 文件上传Controller
 * 
 * @author ganyu
 */
@RestController
@RequestMapping("/system/equipment/upload")
public class FileUploadController extends BaseController
{
    @Autowired
    private IFileUploadService fileUploadService;

    /**
     * 上传设备图片
     */
    @PostMapping("/image")
    public AjaxResult uploadImage(MultipartFile file)
    {
        if (file.isEmpty())
        {
            return error("上传文件不能为空");
        }
        
        try
        {
            String url = fileUploadService.upload(file, "equipment/images");
            AjaxResult ajax = AjaxResult.success();
            ajax.put("url", url);
            ajax.put("fileName", url);
            return ajax;
        }
        catch (Exception e)
        {
            return error("上传失败: " + e.getMessage());
        }
    }
}
