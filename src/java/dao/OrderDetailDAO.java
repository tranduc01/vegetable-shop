/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import model.Cart;
import model.Product;
import utils.DBUtils;
import utils.RandomID;

/**
 *
 * @author tvfep
 */
public class OrderDetailDAO {

    public boolean createOrderDetails(String orderID, Cart cart) throws SQLException {
        String sql = "INSERT INTO [dbo].[tblOrderDetail]\n"
                + "           ([detailID]\n"
                + "           ,[price]\n"
                + "           ,[quantity]\n"
                + "           ,[orderID]\n"
                + "           ,[productID])\n"
                + "     VALUES\n"
                + "           (?,?,?,?,?)";
        Connection conn = null;
        PreparedStatement ps = null;
        boolean check = false;
        RandomID rd = new RandomID();

        try {
            conn = DBUtils.getConnection();
            ps = conn.prepareStatement(sql);
            String detailID;

            for (Product c : cart.getCart().values()) {
                detailID = "DET" + rd.getARandomID();
                ps.setString(1, detailID);
                ps.setDouble(2, c.getPrice());
                ps.setInt(3, c.getQuantity());
                ps.setString(4, orderID);
                ps.setString(5, c.getProductID());
                int checkInsert = ps.executeUpdate();
                if (checkInsert > 0) {
                    check = true;
                }
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
}
