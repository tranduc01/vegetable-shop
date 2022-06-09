package dao;

import model.Product;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import utils.DBUtils;

public class ProductDAO {

    private static final String GETALLPRODUCTSADMIN = "select productID, productName, image, price, quantity, categoryID, importDate, usingDate, status from tblProduct";
    private static final String GETALLPRODUCTSUSER = "select productID, productName, image, price, quantity, categoryID, importDate, usingDate from tblProduct where status = 'Available' and ? < usingDate";

    private static final String GETPRODUCTSBYNAME = "select productID, productName, image, price, quantity, categoryID, importDate, usingDate from tblProduct where productName like ?";
    private static final String ADDPRODUCT = "INSERT INTO tblProduct(productID, productName, image, price, quantity, categoryID, importDate, usingDate, status) VALUES (?,?,?,?,?,?,?,?,?)";
    private static final String DELETE = "UPDATE tblProduct SET status = ? WHERE productID = ?";
    private static final String GETPRODUCTBYID = "select productName, image, price, quantity, categoryID, importDate, usingDate, status from tblProduct where productID = ?";
    private static final String UPDATE = "UPDATE [dbo].[tblProduct]\n"
            + "   SET [productID] = ? \n"
            + "      ,[productName] = ? \n"
            + "      ,[image] = ? \n"
            + "      ,[price] = ? \n"
            + "      ,[quantity] = ? \n"
            + "      ,[categoryID] = ? \n"
            + "      ,[importDate] = ? \n"
            + "      ,[usingDate] = ?  \n"
            + "      ,[status] = ?  \n"
            + " WHERE productID = ? ";

    public List<Product> getAllProducts() throws SQLException {

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        List<Product> listProduct = new ArrayList<>();
        try {
            long millis = System.currentTimeMillis();
            java.sql.Date date = new java.sql.Date(millis);
            conn = DBUtils.getConnection();
            ps = conn.prepareStatement(GETALLPRODUCTSUSER);
            ps.setDate(1, date);
            rs = ps.executeQuery();

            while (rs.next()) {

                String productID = rs.getString("productID");
                String productName = rs.getString("productName");
                String image = rs.getString("image");
                double price = Double.parseDouble(rs.getString("price"));
                int quantity = Integer.parseInt(rs.getString("quantity"));
                String categoryID = rs.getString("categoryID");
                String importDate = rs.getString("importDate");
                String usingDate = rs.getString("usingDate");
                Product product = new Product(productID, productName, image, price, quantity, categoryID, importDate, usingDate);
                listProduct.add(product);
            }

        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
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
        return listProduct;

    }

    public List<Product> getAllProductsAdmin() throws SQLException {

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        List<Product> listProduct = new ArrayList<>();
        try {
            conn = DBUtils.getConnection();
            ps = conn.prepareStatement(GETALLPRODUCTSADMIN);
            rs = ps.executeQuery();

            while (rs.next()) {
                String productID = rs.getString("productID");
                String productName = rs.getString("productName");
                String image = rs.getString("image");
                double price = Double.parseDouble(rs.getString("price"));
                int quantity = Integer.parseInt(rs.getString("quantity"));
                String categoryID = rs.getString("categoryID");
                String importDate = rs.getString("importDate");
                String usingDate = rs.getString("usingDate");
                String status = rs.getString("status");
                Product product = new Product(productID, productName, image, price, quantity, categoryID, importDate, usingDate, status);
                listProduct.add(product);
            }

        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
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
        return listProduct;

    }

    
    //search
    public List<Product> getProductByName(String search) throws SQLException {
        List<Product> listProducts = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(GETPRODUCTSBYNAME);
                ps.setString(1, "%" + search + "%");
                rs = ps.executeQuery();
                while (rs.next()) {
                    String productID = rs.getString("productID");
                    String productName = rs.getString("productName");
                    String image = rs.getString("image");
                    double price = Double.parseDouble(rs.getString("price"));
                    int quantity = Integer.parseInt(rs.getString("quantity"));
                    String categoryID = rs.getString("categoryID");
                    String importDate = rs.getString("importDate");
                    String usingDate = rs.getString("usingDate");
                    Product product = new Product(productID, productName, image, price, quantity, categoryID, importDate, usingDate);
                    listProducts.add(product);
                }
            }

        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
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
        return listProducts;
    }

    public boolean addProduct(Product product) throws SQLException, ClassNotFoundException {
        boolean check = false;

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(ADDPRODUCT);
                ps.setString(1, product.getProductID());
                ps.setString(2, product.getProductName());
                ps.setString(3, product.getImage());
                ps.setDouble(4, product.getPrice());
                ps.setInt(5, product.getQuantity());
                ps.setString(6, product.getCategoryID());
                ps.setString(7, product.getImportDate());
                ps.setString(8, product.getUsingDate());
                ps.setString(9, product.getStatus());

                int checkUpdate = ps.executeUpdate();
                if (checkUpdate > 0) {
                    check = true;
                }
            }
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

    public boolean deleteAProduct(String productID) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            ps = conn.prepareStatement(DELETE);
            ps.setString(1, "Unavailable");
            ps.setString(2, productID);

            int checkDelete = ps.executeUpdate();
            if (checkDelete > 0) {
                check = true;
            }

        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
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

    public boolean updateProduct(Product product) throws SQLException {
        boolean check = false;

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(UPDATE);
                ps.setString(1, product.getProductID());
                ps.setString(2, product.getProductName());
                ps.setString(3, product.getImage());
                ps.setDouble(4, product.getPrice());
                ps.setInt(5, product.getQuantity());
                ps.setString(6, product.getCategoryID());
                ps.setString(7, product.getImportDate());
                ps.setString(8, product.getUsingDate());
                ps.setString(9, product.getStatus());
                ps.setString(10, product.getProductID());

                int checkUpdate = ps.executeUpdate();
                if (checkUpdate > 0) {
                    check = true;
                }
            }
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
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

    public Product getProductById(String productID) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        Product product = new Product();
        try {
            conn = DBUtils.getConnection();
            ps = conn.prepareStatement(GETPRODUCTBYID);
            ps.setString(1, productID);
            rs = ps.executeQuery();
            while (rs.next()) {
                int quantity = rs.getInt("quantity");
                String categoryID = rs.getString("categoryID");
                String importDate = rs.getString("importDate");
                String usingDate = rs.getString("usingDate");
                String image = rs.getString("image");
                double price = rs.getDouble("price");
                String productName = rs.getString("productName");
                String status = rs.getString("status");
                product = new Product(productID, productName, image, price, quantity, categoryID, importDate, usingDate, status);
            }

        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
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
        return product;
    }

    public int getProductQuantity(String productID) throws SQLException {
        String sql = "select quantity from tblProduct where productID =?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        int quantity = 0;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(sql);
                ps.setString(1, productID);
                rs = ps.executeQuery();
                while (rs.next()) {
                    quantity = rs.getInt("quantity");
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
        return quantity;
    }

    public boolean updateProductQuantity(String productID, int quantity) throws SQLException {
        String sql = "UPDATE [dbo].[tblProduct]\n"
                + " SET [quantity] = ? \n"
                + " WHERE productID = ? ";

        Connection conn = null;
        PreparedStatement ps = null;
        boolean check = false;
        int newQuantity = 0;
        try {
            newQuantity = getProductQuantity(productID) - quantity;
            conn = DBUtils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(sql);
                ps.setInt(1, newQuantity);
                ps.setString(2, productID);
                int checkUpdate = ps.executeUpdate();
                if (checkUpdate > 0) {
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

    public boolean checkDuplicateID(String productID) throws SQLException {
        String CHECKDUPLICATEID = "select productID from tblProduct where productID = ?";

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        boolean check = true;
        String checkID = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(CHECKDUPLICATEID);
                ps.setString(1, productID);
                rs = ps.executeQuery();
                while (rs.next()) {
                    checkID = rs.getString("productID");
                }
                if (checkID == null) {
                    check = false;
                }
            }

        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
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

    public List<Product> getAllProductsUSPagging(int page, int PAGE_SIZE) throws SQLException {
        String sql = "select productID, productName, image, price, quantity, categoryID, importDate, usingDate "
                + "from tblProduct where status = 'Available' and ? < usingDate  order by productID\n"
                + "offset (?-1)*? row fetch next ? rows only";

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<Product> listProduct = new ArrayList<>();
        try {
            long millis = System.currentTimeMillis();
            java.sql.Date date = new java.sql.Date(millis);
            conn = DBUtils.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setDate(1, date);
            ps.setInt(2, page);
            ps.setInt(3, PAGE_SIZE);
            ps.setInt(4, PAGE_SIZE);
            rs = ps.executeQuery();
            while (rs.next()) {

                String productID = rs.getString("productID");
                String productName = rs.getString("productName");
                String image = rs.getString("image");
                double price = Double.parseDouble(rs.getString("price"));
                int quantity = Integer.parseInt(rs.getString("quantity"));
                String categoryID = rs.getString("categoryID");
                String importDate = rs.getString("importDate");
                String usingDate = rs.getString("usingDate");
                Product product = new Product(productID, productName, image, price, quantity, categoryID, importDate, usingDate);
                listProduct.add(product);
            }

        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
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
        return listProduct;
    }

    public int getTotalProducts() throws SQLException {
        String sql = "select COUNT(productID) from tblProduct where status = 'Available' and ? < usingDate";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            long millis = System.currentTimeMillis();
            java.sql.Date date = new java.sql.Date(millis);
            conn = DBUtils.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setDate(1, date);
            rs = ps.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }

        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
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
        return 0;
    }

}
