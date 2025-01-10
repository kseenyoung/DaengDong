package com.shinhan.daengdong.util.awsS3;

import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.ObjectMetadata;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.UUID;

@Service
public class S3Service {

    private final String BUCKET_NAME = "daengdong-bucket";

    @Autowired
    private AmazonS3 amazonS3;

    public String uploadFile(MultipartFile file) throws IOException {
        try {
            String fileName = generateFileName(file.getOriginalFilename());
            ObjectMetadata metadata = new ObjectMetadata();
            metadata.setContentLength(file.getSize());
            metadata.setContentType(file.getContentType());

            amazonS3.putObject(BUCKET_NAME, fileName, file.getInputStream(), metadata);
            return amazonS3.getUrl(BUCKET_NAME, fileName).toString();
        } catch (Exception e) {
            e.printStackTrace();
            throw new IOException("S3 업로드 실패: " + e.getMessage());
        }

    }

    private String generateFileName(String originalFilename) {
        return UUID.randomUUID().toString() + "_" + originalFilename;
    }
}
