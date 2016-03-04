<%@page language="java" import="java.sql.*" %>
<% DriverManager.registerDriver(new com.microsoft.sqlserver.jdbc.SQLServerDriver()); %>

<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <title>Course Grade Distribution</title>
    </head>
    <body>
        <h1>Display information on the distribution of grades in particular courses and by particular professors</h1>

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

            PreparedStatement pstmt_ii = null;
            PreparedStatement pstmt_iii = null;
            PreparedStatement pstmt_iv = null;
            PreparedStatement pstmt_v = null;

            ResultSet rs_ii = null;
            ResultSet rs_iii = null;
            ResultSet rs_iv = null;
            ResultSet rs_v = null;

            public GradeReport(){
                
                try {
                    connection = DriverManager.getConnection(URL, USERNAME,PASSWORD);

                    pstmt_ii = connection.prepareStatement(
                        "SELECT COUNT(CASE WHEN c.grade_received IN ('A+','A','A-') THEN 1 END) AS numA,"
                              + "COUNT(CASE WHEN c.grade_received IN ('B+','B','B-') THEN 1 END) AS numB,"
                              + "COUNT(CASE WHEN c.grade_received IN ('C+','C','C-') THEN 1 END) AS numC,"
                              + "COUNT(CASE WHEN c.grade_received IN ('D+','D','D-') THEN 1 END) AS numD,"
                              + "COUNT(CASE WHEN c.grade_received IN ('F+','F','F-','P','NP') THEN 1 END) AS numOther"

                        + " FROM course a, class b, pastclass c"
                        + " WHERE a.coursenumber = ? AND b.instructor = ? AND b.term = ?"
                        + " AND a.coursenumber = b.course_title"
                       );

                    pstmt_iii = connection.prepareStatement(
                       "SELECT COUNT(CASE WHEN c.grade_received IN ('A+','A','A-') THEN 1 END) AS numA,"
                              + "COUNT(CASE WHEN c.grade_received IN ('B+','B','B-') THEN 1 END) AS numB,"
                              + "COUNT(CASE WHEN c.grade_received IN ('C+','C','C-') THEN 1 END) AS numC,"
                              + "COUNT(CASE WHEN c.grade_received IN ('D+','D','D-') THEN 1 END) AS numD,"
                              + "COUNT(CASE WHEN c.grade_received IN ('F+','F','F-','P','NP') THEN 1 END) AS numOther"

                        + " FROM course a, class b, pastclass c"
                        + " WHERE a.coursenumber = ? AND b.instructor = ?"
                        + " AND a.coursenumber = b.course_title"
                       );

                    pstmt_iv = connection.prepareStatement(
                        "SELECT COUNT(CASE WHEN c.grade_received IN ('A+','A','A-') THEN 1 END) AS numA,"
                              + "COUNT(CASE WHEN c.grade_received IN ('B+','B','B-') THEN 1 END) AS numB,"
                              + "COUNT(CASE WHEN c.grade_received IN ('C+','C','C-') THEN 1 END) AS numC,"
                              + "COUNT(CASE WHEN c.grade_received IN ('D+','D','D-') THEN 1 END) AS numD,"
                              + "COUNT(CASE WHEN c.grade_received IN ('F+','F','F-','P','NP') THEN 1 END) AS numOther"

                        + " FROM course a, class b, pastclass c"
                        + " WHERE a.coursenumber = ?"
                        + " AND a.coursenumber = b.course_title"
                        );

                    pstmt_v = connection.prepareStatement(
                        "SELECT AVG(t.VALUE)"
                        + " FROM course a, class b, pastclass c, gradeconversion t"
                        + " WHERE a.coursenumber = ? AND b.instructor = ?"
                        + " AND a.coursenumber = b.course_title"
                   
                        + " AND c.grade_received = t.lettergrade");
                    
                } catch (SQLException e){
                    e.printStackTrace();
                }

            }

            public ResultSet getDistribution(String title, String instructor, String term){
                try{


    pstmt_ii.setString(1, title);
                    pstmt_ii.setString(2, instructor);
                    pstmt_ii.setString(3, term);

                    rs_ii = pstmt_ii.executeQuery();

                } catch (SQLException e){
                    e.printStackTrace();
                }
                return rs_ii;
            }
            
            public ResultSet getDistribution(String title, String instructor){
                try{
                    pstmt_iii.setString(1, title);
                    pstmt_iii.setString(2, instructor);

                    rs_iii = pstmt_iii.executeQuery();

                } catch (SQLException e){
                    e.printStackTrace();
                }
                return rs_iii;
            }

            public ResultSet getDistribution(String title){
                try{
                    pstmt_iv.setString(1, title);

                    rs_iv = pstmt_iv.executeQuery();

                } catch (SQLException e){
                    e.printStackTrace();
                }
                return rs_iv;
            }
            
            public ResultSet getGPA(String title, String instructor){
                try{
                    pstmt_v.setString(1, title);
                    pstmt_v.setString(2, instructor);

                    rs_v = pstmt_v.executeQuery();

                } catch (SQLException e){
                    e.printStackTrace();
                }
                return rs_v;
            }
        }
        %>
        
        <%
            String courseTitle = new String();
            String classInstructor = new String();
            String classTerm = new String();

            courseTitle = request.getParameter("title");
            classInstructor = request.getParameter("instructor");
            classTerm = request.getParameter("term");
            GradeReport stdreport = new GradeReport();
            ResultSet part_ii = stdreport.getDistribution(courseTitle, classInstructor, classTerm);
            ResultSet part_iii = stdreport.getDistribution(courseTitle, classInstructor);
            ResultSet part_iv = stdreport.getDistribution(courseTitle);
            ResultSet part_v = stdreport.getGPA(courseTitle, classInstructor);
        %>
        <table border="1">
            <tbody>
                <tr>
                    <td>A</td>
                    <td>B</td>
                    <td>C</td>
                    <td>D</td>
                    <td>Other</td>
                </tr>
                <% while (part_ii.next()){ %>
                <tr>
                    <td><%= part_ii.getInt("numA") %></td>
                    <td><%= part_ii.getInt("numB") %></td>
                    <td><%= part_ii.getInt("numC") %></td>
                    <td><%= part_ii.getInt("numD") %></td>
                    <td><%= part_ii.getInt("numOther") %></td>
                </tr>
                <% } %>
            </tbody>
        </table>
        
        <table border="1">
            <tbody>
                <tr>
                    <td>A</td>
                    <td>B</td>
                    <td>C</td>
                    <td>D</td>
                    <td>Other</td>
                </tr>
                <% while (part_iii.next()){ %>
                <tr>
                    <td><%= part_iii.getInt("numA") %></td>
                    <td><%= part_iii.getInt("numB") %></td>
                    <td><%= part_iii.getInt("numC") %></td>
                    <td><%= part_iii.getInt("numD") %></td>
                    <td><%= part_iii.getInt("numOther") %></td>
                </tr>
                <% } %>
            </tbody>
        </table>
        
        <table border="1">
            <tbody>
                <tr>
                    <td>A</td>
                    <td>B</td>
                    <td>C</td>
                    <td>D</td>
                    <td>Other</td>
                </tr>
                <% while (part_iv.next()){ %>
                <tr>
                    <td><%= part_iv.getInt("numA") %></td>
                    <td><%= part_iv.getInt("numB") %></td>
                    <td><%= part_iv.getInt("numC") %></td>
                    <td><%= part_iv.getInt("numD") %></td>
                    <td><%= part_iv.getInt("numOther") %></td>
                </tr>
                <% } %>
            </tbody>
        </table>
        
        <table border="1">
            <tbody>
                <tr>
                    <td>GPA</td>
                </tr>
                <% while (part_v.next()){ %>
                <tr>
                    <td><%= part_v.getDouble(1) %></td>
                </tr>
                <% } %>
            </tbody>
        </table>
        
        </div>
        </div>
    </body>
</html>