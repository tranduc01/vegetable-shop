package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import utils.DBUtils;

public class UserDAO {

    private static final String LOGIN = "SELECT fullname, roleID, address, birthday, phone, email, status FROM tblUsers WHERE userID = ? AND password = ?";

    public UserDTO checkLogin(String userID, String password) throws ClassNotFoundException, SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        UserDTO user = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(LOGIN);
                ps.setString(1, userID);
                ps.setString(2, password);
                rs = ps.executeQuery();
                if (rs.next()) {
                    String fullName = rs.getString("fullname");
                    String roleID = rs.getString("roleID");
                    String address = rs.getString("address");
                    String birthday = rs.getString("birthday");
                    String phone = rs.getString("phone");
                    String email = rs.getString("email");
                    String status = rs.getString("status");
                    
                    user = new UserDTO(userID, fullName, roleID, "", address, phone, birthday, status, email);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }finally{
            if(rs != null){
                rs.close();
            }
            if(ps != null){
                ps.close();
            }
            if(conn != null){
                conn.close();
            }
        }
        return user;
    }

}
