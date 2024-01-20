package com.green_market.servlets;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.*;

@WebServlet("/upload")
@MultipartConfig
public class FileUploadServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get the file part from the request
            Part filePart = request.getPart("file");

            // Get the filename from the file part
            String fileName = getSubmittedFileName(filePart);

            // Specify the directory to save the file (inside WEB-INF)
            String uploadDir = getServletContext().getRealPath("/img/uploads/");

            // Create the directory if it doesn't exist
            File uploadDirFile = new File(uploadDir);
            if (!uploadDirFile.exists()) {
                uploadDirFile.mkdir();
            }

            // Specify the file path
            String filePath = uploadDir + File.separator + fileName;

            // Save the file to the specified path
            try (InputStream fileContent = filePart.getInputStream();
                 OutputStream out = new FileOutputStream(new File(filePath))) {

                int read;
                final byte[] bytes = new byte[1024];
                while ((read = fileContent.read(bytes)) != -1) {
                    out.write(bytes, 0, read);
                }

                // Return the file path as a response
                response.getWriter().write("http://localhost:8080/img/uploads/"+fileName);
            }

        } catch (Exception e) {
            response.getWriter().write("Error: " + e.getMessage());
        }
    }

    private String getSubmittedFileName(Part part) {
        for (String content : part.getHeader("content-disposition").split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }
}