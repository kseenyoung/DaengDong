package com.shinhan.daengdong.util.awsS3;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

@Slf4j
@RestController
@RequestMapping("/api/s3")
public class S3Controller {

    @Autowired
    private S3Service s3Service;

    @PostMapping("/upload")
    public String uploadFile(@RequestParam("file") MultipartFile file) {
        try {
            log.info("file: " + file);
            String fileUrl = s3Service.uploadFile(file);
            return fileUrl;
        } catch (IOException e) {
            e.printStackTrace();
            return "파일 업로드 중 에러발생" + e.getMessage();
        }
    }
}
