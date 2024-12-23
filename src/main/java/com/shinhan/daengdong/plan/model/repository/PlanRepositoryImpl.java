package com.shinhan.daengdong.plan.model.repository;

import lombok.extern.slf4j.Slf4j;
import org.apache.commons.dbcp2.BasicDataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

@Slf4j
@Repository
public class PlanRepositoryImpl implements PlanRepositoryInterface {

    @Autowired
    private BasicDataSource dataSource;

    @Override
    public List<String> findAllRegions() {
        log.info("DB Query [region_name]...");
        List<String> regions = new ArrayList<>();
        String sql = "SELECT region_name FROM regions";

        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet resultSet = ps.executeQuery()) {

            while (resultSet.next()) {
                regions.add(resultSet.getString("region_name"));
            }

        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Error fetching regions", e);
        }

        return regions;
    }
}
