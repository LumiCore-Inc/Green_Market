package com.green_market.servlets;

import com.green_market.entities.Product;
import com.green_market.entities.ProductHasImage;
import org.apache.commons.dbcp2.BasicDataSource;

import javax.json.Json;
import javax.json.JsonArrayBuilder;
import javax.json.JsonObjectBuilder;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Objects;

@WebServlet(name = "productServlet", value = "/product")
public class ProductServlet extends HttpServlet {

    @Override// get product
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String httpMethod = String.valueOf(req.getAttribute("method"));
        if (httpMethod.equals("GET")){
            doGet(req, resp);
        }
    }
    @Override// get product
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        JsonObjectBuilder response = Json.createObjectBuilder();
        PrintWriter writer = resp.getWriter();
        resp.setContentType("application/json");

        try {
            BasicDataSource ds = (BasicDataSource) getServletContext().getAttribute("ds");
            Connection connection = ds.getConnection();

            String productId = req.getParameter("productId");

            String httpMethod = String.valueOf(req.getAttribute("method"));
            if (httpMethod.equals("GET")){
                productId = null;
            }

            PreparedStatement pstm = null;
            if (Objects.equals(productId, null)) {
                pstm = connection.prepareStatement("select * from products");
            } else {
                pstm = connection.prepareStatement("select * from products where id=?");
                pstm.setObject(1, productId);
            }

            ResultSet rst = pstm.executeQuery();
            HttpSession session = req.getSession();
            RequestDispatcher dispatcher = null;


            DecimalFormat df = new DecimalFormat("0.00");
            if (Objects.equals(productId, null)) {
                ArrayList<Product> productList = new ArrayList<>();
                while (rst.next()) {

                    pstm = connection.prepareStatement("select * from product_has_images where product_id=?");
                    pstm.setObject(1, rst.getInt(1));

                    ResultSet resultSet = pstm.executeQuery();
                    JsonArrayBuilder images = Json.createArrayBuilder();

                    ArrayList<ProductHasImage> productHasImages = new ArrayList<>();
                    while (resultSet.next()) {

                        ProductHasImage productHasImage = new ProductHasImage(
                                resultSet.getInt(1),
                                resultSet.getString(2)
                        );

                        productHasImages.add(productHasImage);
                    }

                    Product product = new Product(
                            rst.getInt(1),
                            rst.getString(2),
                            rst.getDouble(3),
                            rst.getDouble(4),
                            rst.getInt(5),
                            rst.getString(6),
                            rst.getInt(7),
                            productHasImages
                    );

                    productList.add(product);
                }
//                response.add("data", products);
//                response.add("message", "success");
//                response.add("code", 200);
                session.setAttribute("status", "Success");
                session.setAttribute("message", "");
                req.setAttribute("listTodo", productList);
                dispatcher = req.getRequestDispatcher("product.jsp");
                dispatcher.forward(req, resp);
                connection.close();
            } else {

                Product product = null;
                while (rst.next()) {
//                    product.add("id", );
//                    product.add("name", );
//                    product.add("price", df.format(rst.getDouble(3)));
//                    product.add("ratings", rst.getDouble(4));
//                    product.add("description", rst.getString(6));
//                    product.add("qty", rst.getInt(7));

                    pstm = connection.prepareStatement("select * from product_has_images where product_id=?");
                    pstm.setObject(1, rst.getInt(1));

                    ResultSet resultSet = pstm.executeQuery();

                    ArrayList<ProductHasImage> productHasImages = new ArrayList<>();
                    while (resultSet.next()) {

                        ProductHasImage productHasImage = new ProductHasImage(
                                resultSet.getInt(1),
                                resultSet.getString(2)
                        );

                        productHasImages.add(productHasImage);
                    }

                    product = new Product(
                            rst.getInt(1),
                            rst.getString(2),
                            rst.getDouble(3),
                            rst.getDouble(4),
                            rst.getInt(5),
                            rst.getString(6),
                            rst.getInt(7),
                            productHasImages
                    );
                }


                if (Objects.equals(product , null)) {
                    response.add("message", "product not exist");
                    response.add("code", 400);
                    resp.setStatus(400);
                    connection.close();
                } else {
//                    response.add("data", (JsonValue) product);
//                    response.add("message", "success");
//                    response.add("code", 200);

                    req.setAttribute("product", product);
                    session.setAttribute("status", "Success");
                    session.setAttribute("message", "");
                    connection.close();
                    dispatcher = req.getRequestDispatcher("productDetails.jsp");
                    dispatcher.forward(req, resp);
                }
            }

            connection.close();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        } catch (ServletException e) {
            throw new RuntimeException(e);
        }
    }
}
