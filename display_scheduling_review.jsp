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
            String URL = "jdbc:sqlserver://MR_HE\\SQLEXPRESS;databaseName=cse132b";
            String USERNAME = "sahmed123";
            String PASSWORD = "sahmed123";

            Connection connection = null;
            PreparedStatement pstmt = null;
            ResultSet resultSet = null;

            public Studentsclasses(){

                try {
                    connection = DriverManager.getConnection(URL, USERNAME,PASSWORD);
                    pstmt = connection.prepareStatement(
                        "with newscore as (select distinct studentid from classMeeting sm, studentEnrollment se where sm.sectionid = se.SECTIONID and sm.sectionid = ?) select  a.day, a.start_time, a.end_time from singleMeeting a except (select   wm.day, wm.start_time, wm.end_time from newscore, studentEnrollment ss, classmeeting cm, weeklymeeting wm where ss.studentid = newscore.studentid and ss.sectionid = cm.sectionid and cm.meetingid = wm.meetingid union select  sm.day, sm.start_time, sm.end_time from newscore, studentEnrollment ss, classmeeting cm, singleMeeting sm where ss.studentid = newscore.studentid and ss.sectionid = cm.sectionid and cm.meetingid = sm.meetingid)"
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
        <tr>
<td>Date</td>
        <td>Days</td>
        <td>Beginning Time</td>
        <td>Ending Time</td>
        </tr>

        Available times slots for Review
            <% while (classes.next()){ %>
        <tr>
        <td>2016-2-12</td>
        <td><%= classes.getString(1) %></td>
        <td><%= classes.getString(2) %></td>
        <td><%= classes.getString(3) %></td>
        </tr>
            <% } %>
        </tbody>
        </table>

        </div>
        </div>
        </body>
        </html>