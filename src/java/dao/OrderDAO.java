/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import model.Order;
import utils.DBUtils;

/**
 *
 * @author tvfep
 */
public class OrderDAO {

    public boolean createOrder(Order order) throws SQLException {
        String sql = "INSERT INTO [dbo].[tblOrders]\n"
                + "           ([orderID]\n"
                + "           ,[orderDate]\n"
                + "           ,[total]\n"
                + "           ,[userID]\n"
                + "           ,[status])\n"
                + "     VALUES\n"
                + "           (?,?,?,?,?)";
        Connection conn = null;
        PreparedStatement ps = null;
        boolean check = false;
        Date date = order.getOrderDate();
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd");
        String orderDate = formatter.format(date);

        try {

            conn = DBUtils.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, order.getOrderID());
            ps.setString(2, orderDate);
            ps.setDouble(3, order.getTotal());
            ps.setString(4, order.getUserID());
            ps.setString(5, order.getStatus());
            int checkInsert = ps.executeUpdate();
            if (checkInsert > 0) {
                check = true;
            }

        } catch (Exception e) {
        } finally {
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    public boolean checkDuplicate(String orderID) throws SQLException {
        String sql = "SELECT [orderID]\n"
                + "  FROM [dbo].[tblOrders] where orderID = ?";

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String duplicatedID = null;
        boolean check = true;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(sql);
                ps.setString(1, orderID);
                rs = ps.executeQuery();
                while (rs.next()) {
                    duplicatedID = rs.getString("orderID");
                }
                if (duplicatedID == null) {
                    check = false;
                }
            }

        } catch (Exception e) {
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;

    }

}
