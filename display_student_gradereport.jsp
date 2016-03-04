<%@page language="java" import="java.sql.*" %>
        <% DriverManager.registerDriver(new com.microsoft.sqlserver.jdbc.SQLServerDriver()); %>

<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <title>Student's Grade Report</title>
    </head>
    <body>
        <h1>Display the student's classes and GPA</h1>
        
        <div style = "width:100%">
        
        <div style = "float:left; width:20%;">
            <%-- -------- Include menu HTML code -------- --%>
            <jsp:include page="menu.html" />                
        </div>
        
        <div style = "float:left; width: 80%;">
        <%!
        public class GradeReport {
            String URL = "jdbc:sqlserver://MR_HE\\SQLEXPRESS;databaseName=cse132b";
            String USERNAME = "sahmed123";
            String PASSWORD = "sahmed123";

            Connection connection = null;
            PreparedStatement pstmt_classes = null;
            PreparedStatement pstmt_gpa = null;
            PreparedStatement pstmt_cgpa = null;
            ResultSet rs_classes = null;
            ResultSet rs_gpa = null;
            ResultSet rs_cgpa = null;

            public GradeReport(){
                
                try {
                    connection = DriverManager.getConnection(URL, USERNAME,PASSWORD);
                    
                    pstmt_classes = connection.prepareStatement(
                        "SELECT a.section_id, a.course_title, a.instructor, b.term, b.grade_type, b.units, b.grade_received"
                        + " FROM class a, pastclass b"
                        + " WHERE b.student_id = ?"
                        + " AND b.section_id = a.section_id"
                        + " ORDER BY b.term");
                    
                    pstmt_gpa = connection.prepareStatement(
                            "SELECT b.term, AVG(t.value)"
                            + " FROM pastclass b, gradeconversion t"
                            + " WHERE b.student_id = ?"
                            + " AND b.grade_received = t.lettergrade"
                            + " GROUP BY b.term");
                        
                    pstmt_cgpa = connection.prepareStatement(
                            "SELECT AVG(t.value)" +
                            "FROM pastclass b, gradeconversion t" +
                            " WHERE b.student_id = ?" +
                            " AND b.grade_received = t.lettergrade");
                } catch (SQLException e){
                    e.printStackTrace();
                }

            }

            public ResultSet getClasses(String ID){
                try{
                    pstmt_classes.setString(1, ID);
                    rs_classes = pstmt_classes.executeQuery();
                } catch (SQLException e){
                    e.printStackTrace();
                }

                return rs_classes;
            }
            
            public ResultSet getGPA(String ID){
                try{
                    pstmt_gpa.setString(1, ID);
                    rs_gpa = pstmt_gpa.executeQuery();
                } catch (SQLException e){
                    e.printStackTrace();
                }

                return rs_gpa;
            }
            
            public ResultSet getCumulativeGPA(String ID){
                try{
                    pstmt_cgpa.setString(1, ID);
                    rs_cgpa = pstmt_cgpa.executeQuery();
                } catch (SQLException e){
                    e.printStackTrace();
                }

                return rs_cgpa;
            }
        }
        %>
        
        <%
            String studentID = new String();

            if(request.getParameter("ID") != null){
                studentID = request.getParameter("ID");
            }

            GradeReport stdreport = new GradeReport();
            ResultSet classes = stdreport.getClasses(studentID);
            ResultSet gpa = stdreport.getGPA(studentID);
            ResultSet cgpa = stdreport.getCumulativeGPA(studentID);
        %>
        <table border="1">
            <tbody>
                <tr>
                    <td>Section ID</td>
                    <td>Course Title</td>
                    <td>Instructor</td>
                    <td>Term</td>
                    <td>Grade</td>
                    <td>Units</td>
                    <td>Grade Received</td>
                </tr>
                <% while (classes.next()){ %>
                <tr>
                    <td><%= classes.getString("section_id") %></td>
                    <td><%= classes.getString("course_title") %></td>
                    <td><%= classes.getString("instructor") %></td>
                    <td><%= classes.getString("term") %></td>
                    <td><%= classes.getString("grade_type") %></td>
                    <td><%= classes.getString("units") %></td>
                    <td><%= classes.getString("grade_received") %></td>
                </tr>
                <% } %>
            </tbody>
        </table>
        
        <table border="1">
            <tbody>
                <tr>
                    <td>Term</td>
                    <td>GPA</td>
                </tr>
                <% while (gpa.next()){ %>
                <tr>
                    <td><%= gpa.getString("term") %></td>
                    <td><%= gpa.getDouble(2) %></td>
                </tr>
                <% } %>
            </tbody>
        </table>
        
        <table border="1">
            <tbody>
                <tr>
                    <td>Cumulative GPA</td>
                </tr>
                <% while (cgpa.next()){ %>
                <tr>
                    <td><%= cgpa.getDouble(1) %></td>
                </tr>
                <% } %>
            </tbody>
        </table>
        
        </div>
        </div>
    </body>
</html>