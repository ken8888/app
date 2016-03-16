<%@page language="java" import="java.sql.*" %>
        <% DriverManager.registerDriver(new com.microsoft.sqlserver.jdbc.SQLServerDriver()); %>

<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <title>Graduate Student Requirements</title>
    </head>
    <body>
        <h1>Display MS student's requirements</h1>
        
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
                        PreparedStatement pstmt6 = null;
                                                PreparedStatement pstmt7 = null;
            ResultSet resultSet6 = null;
                        ResultSet resultSet7 = null;

            ResultSet rs_classes = null;
            ResultSet rs_gpa = null;

            public GradeReport(){
                
                try {
                    connection = DriverManager.getConnection(URL, USERNAME,PASSWORD);
                    
                    pstmt_classes = connection.prepareStatement(
                        " with ss as (SELECT x.name, avg(cast(w.value as float )) as gpa, sum(cast(z.units as int)) as totalunit FROM gradeconversion w, concentration x, class y, pastclass z WHERE x.reqcourse  like '%' + y.course_title + '%'AND y.section_id = z.section_id AND z.grade_received = w.lettergrade AND z.student_id =? group by x.name) select ss.name from ss, concentration c where ss.name = c.name and ss.gpa >= c.mingpa and ss.totalunit >= c.minunits"

                    ); 
                    pstmt_gpa = connection.prepareStatement(
                    "with taken as (select se.COURSENUMBER as coursenumber from studentEnrollment se where se.studentid = ? union select p.course_number as coursenumber from pastclass p where p.student_id = ?) select distinct course_title, name, n.nextterm from class c, concentration con, nextoffer n where  con.reqcourse like '%' + c.course_title + '%' and n.coursenumber = c.course_title except select distinct course_title, name, n.nextterm from nextoffer n, class c, concentration con, taken t where  con.reqcourse like '%' + c.course_title + '%' and c.course_title  = t.coursenumber and n.coursenumber = c.course_title"

                    );

                    pstmt7 = connection.prepareStatement(
                "select * from degree where title = ?"
                );
                } catch (SQLException e){
                    e.printStackTrace();
                }

            }
 public ResultSet getDegree(String title){
                try{
                    pstmt7.setString(1,title);
                    resultSet7 = pstmt7.executeQuery();
                    }catch(SQLException e){
                        e.printStackTrace();
                        }

                        return resultSet7;
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
                                        pstmt_gpa.setString(2, ID);
                    rs_gpa = pstmt_gpa.executeQuery();
                } catch (SQLException e){
                    e.printStackTrace();
                }

                return rs_gpa;
            }

            public void studentInfo(){
                try{
                    connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
                    pstmt6 = connection.prepareStatement(
                        "select * from student s where s.id =  ?");
                   }catch(SQLException e){
                        e.printStackTrace();
                                        }
               }
                 public ResultSet getStudentInfo(String ID){
                 try{
                 studentInfo();
                    pstmt6.setString(1, ID);
                    resultSet6 = pstmt6.executeQuery();
                } catch (SQLException e){
                    e.printStackTrace();
                }

                return resultSet6;

            }
        }
        %>

        <%
            String studentid = new String();

            if(request.getParameter("ID") != null){
                studentid = request.getParameter("ID");
            }
            GradeReport student = new GradeReport();
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

    </br>
        <%
            String degreetitle = new String();

            if(request.getParameter("title") != null){
                degreetitle = request.getParameter("title");
            }
            GradeReport degree = new GradeReport();
            ResultSet degreeinfo = degree.getDegree(degreetitle);
        %>
    <table border="1">
    <tbody>
    <tr>
    <td>Title</td>
    <td>Department</td>
    <td>Total Units Requirement</td>

    </tr>
        <%
    while (degreeinfo.next()){ %>
    <tr>
    <td><%= degreeinfo.getString("title") %></td>
    <td><%= degreeinfo.getString("deptname") %></td>
    <td><%= degreeinfo.getString("unitsreq") %></td>
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

            GradeReport stdreport = new GradeReport();
            ResultSet classes = stdreport.getClasses(studentID);
            ResultSet gpa = stdreport.getGPA(studentID);
        %>

        <table border="1">
            <tbody>
                <b>Concentration Completed </b>
                <% while (classes.next()){ %>
                <tr>
                    <td><%= classes.getString("name") %></td>
                    <%--     <td><%= classes.getInt(2) %></td> --%>
                </tr>
                <% } %>
            </tbody>
        </table>

        <table border="1">
            <tbody>
                <b>Courses to take to complete concentrations</b>
                <tr>
                    <td>Concentration</td>
                    <td>Course</td>
                    <td>Term</td>
                </tr>
                <% while (gpa.next()){ %>
                <tr>
                    <td><%= gpa.getString("name") %></td>
                    <td><%= gpa.getString("course_title") %></td>
    <td><%= gpa.getString("nextterm") %></td>

    <td></td>
                </tr>
                <% } %>
            </tbody>
        </table>
        
        </div>
        </div>
    </body>
</html>
