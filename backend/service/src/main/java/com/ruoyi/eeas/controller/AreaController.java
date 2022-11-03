package com.ruoyi.eeas.controller;

import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.enums.BusinessType;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 * 风险区域Controller
 */
@RestController
@RequestMapping("/area")
public class AreaController extends BaseController {
    public static List<String> area = new ArrayList<>();
    public static final String url = "jdbc:mysql://localhost:3306/eeas?serverTimezone=UTC&characterEncoding=utf-8&useSSL=false";
    public static final String username = "root";
    public static final String password = "root";

    /**
     * 读取风险区域
     */
    public static void getArea() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); //加载驱动，连接数据库
            Connection conn = DriverManager.getConnection(url, username, password);
            String select = "select 场所 from eeas_area where 日期 = '2022-01-08';"; //sql查询语句
            PreparedStatement statement = conn.prepareStatement(select);
            ResultSet rs = statement.executeQuery(select);
            while (rs.next()) {
                area.add(rs.getString(1));
            }

            /*
            String path = "service\\src\\main\\resources\\data\\eventData.xlsx";
            FileInputStream is = new FileInputStream(path);
            Workbook xwb = new XSSFWorkbook(is);
            for (int numSheet = 0; numSheet < xwb.getNumberOfSheets(); numSheet++) {
                Sheet sheet = xwb.getSheetAt(numSheet);
                if (sheet == null) {
                    continue;
                }
                // 循环row，如果第一行是字段，则 numRow = 1
                for (int numRow = 1; numRow <= sheet.getLastRowNum(); numRow++) {
                    Row row = sheet.getRow(numRow);
                    if (row == null) {
                        continue;
                    }
                    Cell cell = row.getCell(2);
                    if (cell == null) {
                        continue;
                    }
                    area.add(cell.getStringCellValue());
                }
            }
             */
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @PreAuthorize("@ss.hasPermi('data:area:list')")
    @Log(title = "风险区域", businessType = BusinessType.UPDATE)
    @GetMapping("/list")
    public List<String> putData() {
        getArea();
        return area;
    }

    public static void main(String[] args) {
        getArea();
        System.out.println(area);
    }
}
