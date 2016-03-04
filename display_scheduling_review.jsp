<%@page language="java" import="java.sql.*" %>
<% DriverManager.registerDriver(new com.microsoft.sqlserver.jdbc.SQLServerDriver()); %>

<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <title>Review Session Scheduling</title>
    </head>
    <body>
        <h1>Display the options for a review session</h1>
        
        <div style = "width:100%">
        
            <div style = "float:left; width:20%;">
                <%-- -------- Include menu HTML code -------- --%>
                <jsp:include page="menu.html" />                
            </div>
        
            <div style = "float:left; width: 80%;">
        
        <%!
        public class Studentsclasses {
            String URL = "jdbc:sqlserver://SHAMIM-PC\\SQLEXPRESS;databaseName=cse132b";
            String USERNAME = "sahmed123";
            String PASSWORD = "sahmed123";

            Connection connection = null;
            PreparedStatement pstmt = null;
            ResultSet resultSet = null;

            public Studentsclasses(){
                
                try {
                    connection = DriverManager.getConnection(URL, USERNAME,PASSWORD);
                    pstmt = connection.prepareStatement(
                        " SELECT a._date, a.day, a.start_time, a.end_time" 
                        + " FROM singleMeeting a"
                        + " WHERE NOT EXISTS"
                        + " (SELECT *" 
                        + " FROM classMeeting c, weeklymeeting w"
                        + " WHERE c.sectionid = ?"
                        + " AND c.meetingid = w.meetingid"
                        + " AND w.day = a.day"
                        + " AND ((a.start_time <= w.start_time"
                        + " AND w.start_time < a.end_time)"
                        + " OR (a.start_time <= w.end_time"
                        + " AND w.end_time < a.end_time)))"
                    );
                } catch (SQLException e){
                    e.printStackTrace();
                }

            }

            public ResultSet getClasses(int ID){
                try{
                    pstmt.setInt(1, ID);
                    resultSet = pstmt.executeQuery();
                } catch (SQLException e){
                    e.printStackTrace();
                }

                return resultSet;

            }
        }
        %>
        <%
            int studentID = 0;  

            if(request.getParameter("ID") != null){
                studentID = Integer.parseInt(request.getParameter("ID"));
            }

            Studentsclasses stdclasses = new Studentsclasses();
            ResultSet classes = stdclasses.getClasses(studentID);
        %>
        <table border="1">
            <tbody>
                Available times slots for Spring
                <% while (classes.next()){ %>
                <tr>
                    <td><%= classes.getString(1) %></td>
                    <td><%= classes.getString(2) %></td>
                    <td><%= classes.getString(3) %></td>
                    <td><%= classes.getString(4) %></td>
                </tr>
                <% } %>
            </tbody>
        </table>
        
        </div>
        </div>
    </body>
</html>
