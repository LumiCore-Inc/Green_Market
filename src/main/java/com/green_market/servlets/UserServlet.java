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
import java.sql.*;
import java.util.Date;
import java.util.Objects;

import static com.green_market.config.Security.createJWT;
import static com.green_market.util.AESEncryption.decrypt;
import static com.green_market.util.AESEncryption.encrypt;
import static com.green_market.util.EmailSender.sendEmail;
import static com.green_market.util.JsonPasser.jsonPasser;

@WebServlet(name = "userServlet", value = "/user")
public class UserServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String action = req.getParameter("action");
        if (action.equals("login")){
            userLogin(req, resp);
            System.out.println("AWA");
        }else if (action.equals("register")){
            userRegister(req, resp);
        }
    }

    private void userRegister(HttpServletRequest req, HttpServletResponse resp)throws IOException{
        JsonObjectBuilder response = Json.createObjectBuilder();
        PrintWriter writer = resp.getWriter();
        resp.setContentType("application/json");

        JSONObject json = jsonPasser(req);

        try {
            BasicDataSource ds = (BasicDataSource) getServletContext().getAttribute("ds");
            Connection connection = ds.getConnection();
            PreparedStatement pstm = connection.prepareStatement("select * from users where username=?");
            pstm.setObject(1 , json.get("username").toString());
            ResultSet rst = pstm.executeQuery();

            while (rst.next()) {
                Integer id = rst.getInt(1);
                if (!Objects.equals(id, null)){
                    response.add("message", "username already exist");
                    response.add("code", 404);

                    writer.print(response.build());
                    writer.close();
                    connection.close();
                    return;
                }
            }

        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }

        String username = json.get("username").toString();
        String firstName = json.get("firstName").toString();
        String lastName = json.get("lastName").toString();
        String tp = json.get("tp").toString();
        String address = json.get("address").toString();
        String password = json.get("password").toString();
        String email = json.get("email").toString();

        try {
            BasicDataSource ds = (BasicDataSource) getServletContext().getAttribute("ds");
            Connection connection = ds.getConnection();
            PreparedStatement pstm = connection.prepareStatement("insert into users values(?,?,?,?,?,?,?,?)");
            pstm.setObject(1, 0);
            pstm.setObject(2, username);
            pstm.setObject(3, firstName);
            pstm.setObject(4, lastName);
            pstm.setObject(5, tp);
            pstm.setObject(6, address);
            pstm.setObject(7, encrypt(password));
            pstm.setObject(8, email);
            int i = pstm.executeUpdate();


            if (i > 0) {
                response.add("message", "success");
                response.add("code", 201);

                String content = "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\"><html xmlns=\"http://www.w3.org/1999/xhtml\"><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\"><meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\"><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"><link rel=\"preconnect\" href=\"https://fonts.googleapis.com\"><link rel=\"preconnect\" href=\"https://fonts.gstatic.com\" crossorigin><link href=\"https://fonts.googleapis.com/css2?family=Averia+Serif+Libre:wght@400;700&family=Work+Sans:wght@400;500;600;700&display=swap\" rel=\"stylesheet\"></head><body><center class=\"wrapper\" style=\"width: 100%;table-layout: fixed;background-color: #F7F7F7;padding-bottom: 60px;\"><table class=\"main\" width=\"100%\" style=\"border-spacing: 0;background-color: #ffffff;margin: 0 auto;width: 100%;max-width: 600px;font-family: 'Work Sans', sans-serif;color: #004236;\"> <tr><td style=\"padding: 0;\"><table width=\"100%\" style=\"border-spacing: 0;\"><tr><td style=\"text-align: center; padding: 35px 20px 10px; color: #004236;\"><a><img src=\"https://firebasestorage.googleapis.com/v0/b/tea-pro-399418.appspot.com/o/tea-pro%2Flogo%2Ftea-pro-logo_01.png?alt=media&token=cd8a3691-57b8-47a6-b0bd-b29d0c5275e5\" width=\"105px\" border=\"0\" title=\"Green_Market\" style=\"border: 0;\"></a><p style=\"font-family: 'Averia Serif Libre', sans-serif; padding: 10px; font-size:20px; font-weight: 700;\">Registration Confirmation</p></td></tr></table></td></tr><tr><td style=\"padding: 0 20px 10px;\"><table width=\"100%\" style=\"border-spacing: 0;\"><tr><td style=\"text-align: left; padding: 15px;\"><p style=\"font-family: 'Work Sans', sans-serif; font-size: 16px; font-weight: bold; margin-top: 0;\">Hi "+json.get("username").toString()+"</p><p style=\"font-family: 'Work Sans', sans-serif; font-size: 14px; margin-top: 0;\">Welcome to our platform! Your registration was successful.</p></td></tr></table></td></tr></table></td></tr><tr><td style=\"padding: 15px 20px 0;\"><table width=\"100%\" style=\"border-spacing: 0;\"><tr><td style=\"text-align: left; padding: 15px;\"><p style=\"font-family: 'Work Sans', sans-serif; line-height: 23px; font-size: 14px; margin-top: 0;\"></p></td></tr></table></td></tr><tr><td style=\"padding: 0;\"><table width=\"100%\" \" style=\"border-spacing: 0;\"><tr><td style=\"text-align: center; padding: 0 20px; color: #004236;\"><p style=\"font-family: 'Work Sans', sans-serif; padding: 10px; font-size: 14px; font-weight: bold; margin-top: 0;\">Green Market</p></td></tr></table><table width=\"100%\" style=\"border-spacing: 0;\"><tr><td style=\"text-align: center; padding: 0 20px; color: #A3A3A3;\"><p style=\"font-family: 'Work Sans', sans-serif; padding: 10px; font-size: 12px;\">You are receiving this email because you Registration in Green Market.</p></td></tr></table></td></tr></table></center></body></html>";


                sendEmail(email, "Welcome To Green Market",content);
                writer.print(response.build());
            }
            connection.close();
            writer.close();
        } catch (Exception throwables) {
            throwables.printStackTrace();
        }
    }

    private void userLogin(HttpServletRequest req, HttpServletResponse resp)throws IOException {
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
            PreparedStatement pstm = connection.prepareStatement("select * from users where username=?");
            pstm.setObject(1, userName);
            ResultSet rst = pstm.executeQuery();

            while (rst.next()) {
                Integer id = rst.getInt(1);
                if (!Objects.equals(id, null)){
                    String password = rst.getString(7);
                    try {
                        String decrypt = decrypt(password);
                        if (userPassword.equals(decrypt)){

                            String jwt = createJWT("USER", rst.getInt(1));


                            JsonObjectBuilder nestedObject = Json.createObjectBuilder();
                            nestedObject.add("jwt", jwt);
                            nestedObject.add("name", rst.getString(3) +" "+rst.getString(4));

                            response.add("data", nestedObject);
                            response.add("message", "success");
                            response.add("code", 200);

                            session.setAttribute("name", rst.getString(3));
                            session.setAttribute("jwt", jwt);
                            session.setAttribute("status", "Success");
                            dispatcher = req.getRequestDispatcher("index.jsp");

                            String content = "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\"><html xmlns=\"http://www.w3.org/1999/xhtml\"><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\"><meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\"><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"><link rel=\"preconnect\" href=\"https://fonts.googleapis.com\"><link rel=\"preconnect\" href=\"https://fonts.gstatic.com\" crossorigin><link href=\"https://fonts.googleapis.com/css2?family=Averia+Serif+Libre:wght@400;700&family=Work+Sans:wght@400;500;600;700&display=swap\" rel=\"stylesheet\"></head><body><center class=\"wrapper\" style=\"width: 100%;table-layout: fixed;background-color: #F7F7F7;padding-bottom: 60px;\"><table class=\"main\" width=\"100%\" style=\"border-spacing: 0;background-color: #ffffff;margin: 0 auto;width: 100%;max-width: 600px;font-family: 'Work Sans', sans-serif;color: #004236;\"> <tr><td style=\"padding: 0;\"><table width=\"100%\" style=\"border-spacing: 0;\"><tr><td style=\"text-align: center; padding: 35px 20px 10px; color: #004236;\"><a><img src=\"https://firebasestorage.googleapis.com/v0/b/tea-pro-399418.appspot.com/o/tea-pro%2Flogo%2Ftea-pro-logo_01.png?alt=media&token=cd8a3691-57b8-47a6-b0bd-b29d0c5275e5\" width=\"105px\" border=\"0\" title=\"Green_Market\" style=\"border: 0;\"></a><p style=\"font-family: 'Averia Serif Libre', sans-serif; padding: 10px; font-size:20px; font-weight: 700;\">Login Notification !</p></td></tr></table></td></tr><tr><td style=\"padding: 0 20px 10px;\"><table width=\"100%\" style=\"border-spacing: 0;\"><tr><td style=\"text-align: left; padding: 15px;\"><p style=\"font-family: 'Work Sans', sans-serif; font-size: 16px; font-weight: bold; margin-top: 0;\">Hi "+userName+"</p><p style=\"font-family: 'Work Sans', sans-serif; font-size: 14px; margin-top: 0;\">This is a notification to let you know that you have successfully logged into our system at "+ new Timestamp(new Date().getTime()) +". If this login was not authorized, please contact us immediately.</p></td></tr></table></td></tr></table></td></tr><tr><td style=\"padding: 15px 20px 0;\"><table width=\"100%\" style=\"border-spacing: 0;\"><tr><td style=\"text-align: left; padding: 15px;\"><p style=\"font-family: 'Work Sans', sans-serif; line-height: 23px; font-size: 14px; margin-top: 0;\"></p></td></tr></table></td></tr><tr><td style=\"padding: 0;\"><table width=\"100%\" \" style=\"border-spacing: 0;\"><tr><td style=\"text-align: center; padding: 0 20px; color: #004236;\"><p style=\"font-family: 'Work Sans', sans-serif; padding: 10px; font-size: 14px; font-weight: bold; margin-top: 0;\">Green Market</p></td></tr></table><table width=\"100%\" style=\"border-spacing: 0;\"><tr><td style=\"text-align: center; padding: 0 20px; color: #A3A3A3;\"><p style=\"font-family: 'Work Sans', sans-serif; padding: 10px; font-size: 12px;\">You are receiving this email because you login in to the Green Market.</p></td></tr></table></td></tr></table></center></body></html>";

                            sendEmail(rst.getString(8), "Login Success",content);
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
//            response.add("message", "invalid username or password");
//            response.add("code", 404);
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
