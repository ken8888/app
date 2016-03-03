<%@page language="java" import="java.sql.*" %>
<% DriverManager.registerDriver(new com.microsoft.sqlserver.jdbc.SQLServerDriver()); %>

<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <title>Student's classes</title>
    </head>
    <body>
        <h1>Display the classes currently taken by student</h1>
        
        <div style = "width:100%">
        
            <div style = "float:left; width:20%;">
                <%-- -------- Include menu HTML code -------- --%>
                <jsp:include page="menu.html" />                
            </div>
        
            <div style = "float:left; width: 80%;">
        
        <%!
        public class Studentsclasses {
            String URL = "jdbc:sqlserver://MR_HE\\SQLEXPRESS;databaseName=cse132b";
            String USERNAME = "sahmed123";
            String PASSWORD = "sahmed123";

            Connection connection = null;
            PreparedStatement pstmt = null;
             PreparedStatement pstmt1 = null;


            ResultSet resultSet = null;

            public Studentsclasses(){
                
                try {
                    connection = DriverManager.getConnection(URL, USERNAME,PASSWORD);
                    pstmt = connection.prepareStatement(
                        "SELECT a.section_id, a.course_title, a.instructor, a.term, a.enrolled, a.seats, a.waitlist, b.gradetype, b.units"
                        + " FROM class a, studentenrollment b"
                        + " WHERE b.studentid = ?"
                        + " AND b.term = 'Winter 2016'"
                        + " AND b.sectionid = a.section_id");
                } catch (SQLException e){
                    e.printStackTrace();
                }
            }


            public ResultSet getClasses(String ID){
                try{
                    pstmt.setString(1, ID);
                    resultSet = pstmt.executeQuery();
                } catch (SQLException e){
                    e.printStackTrace();
                }

                return resultSet;

            }
               public void studentInfo(){
                try{
                    connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
                    pstmt1 = connection.prepareStatement(
                        "select * from student s where s.id =  ?");
                   }catch(SQLException e){
                        e.printStackTrace();
                                        }
               }
                 public ResultSet getStudentInfo(String ID){
                 try{
                 studentInfo();
                    pstmt1.setString(1, ID);
                    resultSet = pstmt1.executeQuery();
                } catch (SQLException e){
                    e.printStackTrace();
                }

                return resultSet;

            }

        }
        %>

        <%
            String studentid = new String();

            if(request.getParameter("ID") != null){
                studentid = request.getParameter("ID");
            }
            Studentsclasses student = new Studentsclasses();
            ResultSet studentInfo = student.getStudentInfo(studentid);
        %>
    <table border="1">
    <tbody>
    <tr>
    <td>SSN</td>
    <td>Student ID</td>
    <td>First Name</td>
    <td>Middle Name</td>
    <td>Last Name</td>
    <td>Residency</td>
    <td>Enrollment</td>

    </tr>
        <%



                while (studentInfo.next()){ %>
    <tr>
    <td><%= studentInfo.getInt("ssn") %></td>
    <td><%= studentInfo.getString("id") %></td>
    <td><%= studentInfo.getString("firstname") %></td>
    <td><%= studentInfo.getString("middlename") %></td>
    <td><%= studentInfo.getString("lastname") %></td>
    <td><%= studentInfo.getString("residency") %></td>
    <td><%= studentInfo.getString("enrollment") %></td>


    </tr>
        <% } %>
    </tbody>


    </table>

    </br>
        <%
            String studentID = new String();

            if(request.getParameter("ID") != null){
                studentID = request.getParameter("ID");
            }
            Studentsclasses stdclasses = new Studentsclasses();
            ResultSet classes = stdclasses.getClasses(studentID);
        %>
        <table border="1">
            <tbody>
                <tr>
                    <td>Section ID</td>
                    <td>Course Title</td>
                    <td>Instructor</td>
                    <td>Term</td>
                    <td>Enrolled</td>
                    <td>Seats</td>
                    <td>Waitlist</td>
                    <td>Units</td>
    <td>Grade Type</td>

    </tr>
                <%



                while (classes.next()){ %>
                <tr>
                    <td><%= classes.getString("section_id") %></td>
                    <td><%= classes.getString("course_title") %></td>
                    <td><%= classes.getString("instructor") %></td>
                    <td><%= classes.getString("term") %></td>
                    <td><%= classes.getString("enrolled") %></td>
                    <td><%= classes.getString("seats") %></td>
                    <td><%= classes.getString("waitlist") %></td>
                    <td><%= classes.getString("units") %></td>
    <td><%= classes.getString("gradetype") %></td>

    </tr>
                <% } %>
            </tbody>
        </table>


        </div>
        </div>
    </body>
</html>
