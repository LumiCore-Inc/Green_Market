package com.green_market.servlets;

import org.apache.commons.dbcp2.BasicDataSource;
import org.json.simple.JSONObject;

import javax.json.Json;
import javax.json.JsonObjectBuilder;
import javax.servlet.RequestDispatcher;
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
import java.util.Objects;

import static com.green_market.config.Security.createJWT;
import static com.green_market.util.AESEncryption.decrypt;
import static com.green_market.util.JsonPasser.jsonPasser;

@WebServlet(name = "adminServlet", value = "/admin")
public class AdminServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        JsonObjectBuilder response = Json.createObjectBuilder();
        PrintWriter writer = resp.getWriter();
        resp.setContentType("application/json");

        String userName = req.getParameter("userName");
        String userPassword = req.getParameter("password");
        HttpSession session = req.getSession();
        RequestDispatcher dispatcher = null;

        try {
            BasicDataSource ds = (BasicDataSource) getServletContext().getAttribute("ds");
            Connection connection = ds.getConnection();
            PreparedStatement pstm = connection.prepareStatement("select * from admins where username=?");
            pstm.setObject(1, userName);
            ResultSet rst = pstm.executeQuery();

            while (rst.next()) {
                Integer id = rst.getInt(1);
                if (!Objects.equals(id, null)){
                    String string = rst.getString(4);
                    try {
                        String decrypt = decrypt(string);
                        if (userPassword.equals(decrypt)){

                            String jwt = createJWT("ADMIN", rst.getInt(1));

                            JsonObjectBuilder nestedObject = Json.createObjectBuilder();
                            nestedObject.add("jwt", jwt);
                            nestedObject.add("username", rst.getString(2));

                            response.add("data", nestedObject);
                            response.add("message", "success");
                            response.add("code", 200);

                            session.setAttribute("name", rst.getString(3));
                            session.setAttribute("jwt", jwt);
                            session.setAttribute("status", "Success");
                            dispatcher = req.getRequestDispatcher("adminHome.jsp");

                        }else {
                            response.add("message", "invalid username or password");
                            response.add("code", 404);
                            session.setAttribute("status", "Error");
                            session.setAttribute("message", "Invalid username or password");
                            dispatcher = req.getRequestDispatcher("login.jsp");
                        }
                        dispatcher.forward(req, resp);
                        connection.close();
                        return;

                    } catch (Exception e) {
                        throw new RuntimeException(e);
                    }
                }
            }
            response.add("message", "invalid username or password");
            response.add("code", 404);

            session.setAttribute("status", "Error");
            session.setAttribute("message", "Invalid username or password");
            dispatcher = req.getRequestDispatcher("login.jsp");
            dispatcher.forward(req, resp);
            connection.close();
        }catch (SQLException throwables) {
            throwables.printStackTrace();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
