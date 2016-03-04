<%@page language="java" import="java.sql.*" %>
<% DriverManager.registerDriver(new com.microsoft.sqlserver.jdbc.SQLServerDriver()); %>

<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <title>Class Roster</title>
    </head>
    <body>
        <h1>Display all students that currently taking or have taken the class.</h1>
        
        <div style = "width:100%">
        
            <div style = "float:left; width:20%;">
                <%-- -------- Include menu HTML code -------- --%>
                <jsp:include page="menu.html" />                
            </div>
        
            <div style = "float:left; width: 80%;">
        
        <%!
        public class ClassRoster {
            String URL = "jdbc:sqlserver://MR_HE\\SQLEXPRESS;databaseName=cse132b";
            String USERNAME = "sahmed123";
            String PASSWORD = "sahmed123";

            Connection connection = null;
            PreparedStatement pstmt = null;
            ResultSet resultSet = null;
PreparedStatement pstmt1 = null;
            ResultSet resultSet1 = null;
            public ClassRoster(){
                
                try {
                    connection = DriverManager.getConnection(URL, USERNAME,PASSWORD);
                    pstmt = connection.prepareStatement(

"select s.ssn, s.id as studentid, s.firstname, s.middlename, s.lastname, s.residency, s.enrollment, p.course_number as coursenumber, p.section_id as sectionid, p.grade_type as gradetype, p.units, p.term from pastclass p, student s where p.course_number = ? and p.student_id = s.id union select s.ssn, s.id as studentid, s.firstname, s.middlename, s.lastname, s.residency, s.enrollment, se.coursenumber, se.sectionid, se.gradetype, se.units, se.term from studentEnrollment se, student s where se.COURSENUMBER = ? and s.id = se.studentid"
);


                        pstmt1 = connection.prepareStatement(
                        "select * from class where course_title = ?"
                        );
                } catch (SQLException e){
                    e.printStackTrace();
                }

            }

            public ResultSet getStudents(String TITLE){
                try{
                    pstmt.setString(1, TITLE);
                                        pstmt.setString(2, TITLE);
                    resultSet = pstmt.executeQuery();
                } catch (SQLException e){
                    e.printStackTrace();
                }

                return resultSet;

            }

             public ResultSet getClass(String TITLE){
                try{
                    pstmt1.setString(1, TITLE);
                    resultSet1 = pstmt1.executeQuery();
                } catch (SQLException e){
                    e.printStackTrace();
                }

                return resultSet1;

            }
        }
        %>


        <%
            String coursetitle = new String();

            if(request.getParameter("title") != null){
                coursetitle = request.getParameter("title");
            }
            ClassRoster course = new ClassRoster();
            ResultSet courseinfo = course.getClass(coursetitle);
        %>
    <table border="1">
    <tbody>
    <tr>
    <td>Course Title </td>
    <td>Section ID </td>
    <td>Term</td>
    <td>Instructor</td>
    <td>Enrolled</td>
    <td>Seats</td>
    <td>Waitlist</td>

    </tr>
        <%



                while (courseinfo.next()){ %>
    <tr>
    <td><%= courseinfo.getString("course_title") %></td>
    <td><%= courseinfo.getString("section_id") %></td>

    <td><%= courseinfo.getString("term") %></td>
    <td><%= courseinfo.getString("instructor") %></td>
    <td><%= courseinfo.getInt("enrolled") %></td>
    <td><%= courseinfo.getInt("seats") %></td>
    <td><%= courseinfo.getInt("waitlist") %></td>


    </tr>
        <% } %>
    </tbody>


    </table>

    </br>
        <%
            String courseTitle = new String();

            if(request.getParameter("title") != null){
                courseTitle = request.getParameter("title");
            }

            ClassRoster stdstudents = new ClassRoster();
            ResultSet students = stdstudents.getStudents(courseTitle);
        %>
        <table border="1">
            <tbody>
                <tr>
                    <td>Student ID</td>
    <td>SSN</td>
                    <td>First Name</td>
                    <td>Middle Name</td>
                    <td>Last Name</td>
    <td>Residency</td>
    <td>Enrollment</td>
    <td>Course Number</td>
    <td>Section ID</td>
    <td>Term</td>
                    <td>Grade Option</td>
                    <td>Units</td>
                </tr>
                <% while (students.next()){ %>
                <tr>
                    <td><%= students.getString("studentid") %></td>
    <td><%= students.getString("ssn") %></td>

    <td><%= students.getString("firstname") %></td>
                    <td><%= students.getString("middlename") %></td>
                    <td><%= students.getString("lastname") %></td>
    <td><%= students.getString("residency") %></td>
    <td><%= students.getString("enrollment") %></td>
    <td><%= students.getString("coursenumber") %></td>
    <td><%= students.getString("sectionid") %></td>
    <td><%= students.getString("term") %></td>

                    <td><%= students.getString("gradetype") %></td>
                    <td><%= students.getString("units") %></td>
                </tr>
                <% } %>
            </tbody>
        </table>
        
        </div>
        </div>
    </body>
</html>
