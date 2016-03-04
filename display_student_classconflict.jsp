<%@page language="java" import="java.sql.*" %>
<% DriverManager.registerDriver(new com.microsoft.sqlserver.jdbc.SQLServerDriver()); %>

<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <title>Class Conflicts</title>
    </head>
    <body>
        <h1>Display all class conflicts for a student</h1>
        
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

            public ClassRoster(){
                
                try {
                    connection = DriverManager.getConnection(URL, USERNAME,PASSWORD);
                    pstmt = connection.prepareStatement(
                    	"SELECT DISTINCT b.course_title, b2.course_title, b.section_id, b2.section_id"

                        + " FROM studentEnrollment a, class b, classMeeting c, weeklymeeting w, class b2, classMeeting c2, weeklymeeting w2"

                        + " WHERE a.studentid = ?"
                        + " AND a.SECTIONID = b.section_id"

                        + " AND b.term = 'WI2016'"
                        + " AND b.course_title != b2.course_title"
                        + " AND b.section_id = c.sectionid"
                        + " AND c.meetingid = w.meetingid"

                        + " AND b2.term = 'WI2016'"
                        + " AND b2.section_id = c2.sectionid"
                        + " AND c2.meetingid = w2.meetingid"
                        
                        + " AND w.day = w2.day"
                        + " AND ((w.start_time > w2.start_time AND w.start_time < w2.end_time) OR (w.end_time > w2.start_time AND w.end_time < w2.end_time) OR (w.start_time >= w2.start_time AND w.end_time <= w2.end_time))"
                        );
                } catch (SQLException e){
                    e.printStackTrace();
                }
            }

            public ResultSet getStudents(String ID){
                try{
                    pstmt.setString(1, ID);
                    resultSet = pstmt.executeQuery();
                } catch (SQLException e){
                    e.printStackTrace();
                }
                return resultSet;
            }
        }
        %>

        <%
            String courseTitle = new String();

            if(request.getParameter("ID") != null){
                courseTitle = request.getParameter("ID");
            }

            ClassRoster stdstudents = new ClassRoster();
            ResultSet students = stdstudents.getStudents(courseTitle);
        %>

        <table border="1">
            <tbody>
                <tr>
                    <td>Class Enrolled</td>
                    <td>Section ID</td>
                    <td>Conflicts With</td>
                    <td>Section ID</td>
                </tr>

                <% while (students.next()){ %>
                <tr>
                    <td><%= students.getString(1) %></td>
                    <td><%= students.getString(3) %></td>
                    <td><%= students.getString(2) %></td>
                    <td><%= students.getString(4) %></td>
                </tr>
                <% } %>
            </tbody>
        </table>

        </div>
        </div>
    </body>
</html>