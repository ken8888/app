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
        <h1>Display the requirements needed by student</h1>
        
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
            PreparedStatement pstmt2 = null;
                        PreparedStatement pstmt3 = null;
                                    PreparedStatement pstmt4 = null;
                                                PreparedStatement pstmt5 = null;
                                                                                                PreparedStatement pstmt6 = null;
                                                                                                    PreparedStatement pstmt7 = null;
            ResultSet resultSet = null;
            ResultSet resultSet2 = null;
              ResultSet resultSet3 = null;
            ResultSet resultSet4 = null;
              ResultSet resultSet5 = null;
                            ResultSet resultSet6 = null;
 ResultSet resultSet7 = null;
            public Studentsclasses(){
                
                try {
                    connection = DriverManager.getConnection(URL, USERNAME,PASSWORD);
                    pstmt = connection.prepareStatement(
                        " SELECT DISTINCT y.title, y.unitsreq, z.lowerdivunits, z.upperdivunits, z.techunits"
                        + " FROM undergraduate x, degree y, degreecategory z"
                        + " WHERE x.studentid = ?"
                        + " AND x.degree = y.id"
                        + " AND x.degree = z.degreeid"
                    );
                    pstmt2 = connection.prepareStatement(
"with newscore as (select distinct c. coursenumber, s.units, d.lowerdivunits, de.unitsreq from degree de,course c , studentEnrollment s,undergraduate u, degreeCategory d where s.studentid = ? and c.coursenumber = s.coursenumber and c.division like '%lower%' and s.studentid = u.studentid and d.degreeid = u.degree  and d.degreeid = de.id union select distinct c.coursenumber, s.units,  d.lowerdivunits , de.unitsreq from degree de, course c , pastclass s, undergraduate u, degreeCategory d where s.student_id = ? and c.coursenumber = s.course_number and c.division like '%lower%' and s.student_id = u.studentid and d.degreeid = u.degree and d.degreeid = de.id union select distinct c. coursenumber, s.units, d.upperdivunits,de.unitsreq from degree de, course c , studentEnrollment s,undergraduate u, degreeCategory d where s.studentid = ? and c.coursenumber = s.coursenumber and c.division like '%upper%' and s.studentid = u.studentid and d.degreeid = u.degree  and d.degreeid = de.id  union select distinct c.coursenumber, s.units,  d.lowerdivunits , de.unitsreq from degree de,course c , pastclass s, undergraduate u, degreeCategory d where s.student_id = ? and c.coursenumber = s.course_number and c.division like '%upper%' and s.student_id = u.studentid and d.degreeid = u.degree  and d.degreeid = de.id union select distinct c. coursenumber, s.units, d.techunits,de.unitsreq from degree de, course c , studentEnrollment s,undergraduate u, degreeCategory d where s.studentid = ? and c.coursenumber = s.coursenumber and c.division = 'tech' and s.studentid = u.studentid and d.degreeid = u.degree  and d.degreeid = de.id union select distinct c.coursenumber, s.units,  d.techunits , de.unitsreq from degree de, course c , pastclass s, undergraduate u, degreeCategory d where s.student_id = ? and c.coursenumber = s.course_number and c.division like '%tech%' and s.student_id = u.studentid and d.degreeid = u.degree and d.degreeid = de.id ) select sum(unitsreq)/count(*) - sum(cast(units as int)) from newscore"
                    );

                    pstmt3 = connection.prepareStatement(
"with newscore as(select distinct c. coursenumber, s.units, d.lowerdivunits from course c , studentEnrollment s,undergraduate u, degreeCategory d where s.studentid = ? and c.coursenumber = s.coursenumber and c.division like '%lower%' and s.studentid = u.studentid and d.degreeid = u.degree  union select distinct c.coursenumber, s.units,  d.lowerdivunits from course c , pastclass s, undergraduate u, degreeCategory d where s.student_id = ? and c.coursenumber = s.course_number and c.division like '%lower%' and s.student_id = u.studentid and d.degreeid = u.degree ) select  sum(cast(lowerdivunits as int))/count(*) - sum(cast(units as int)) as lowerNeeded  from newscore"
                        );

                        pstmt4 = connection.prepareStatement(
                        "with newscore as(select distinct c. coursenumber, s.units, d.upperdivunits from course c , studentEnrollment s,undergraduate u, degreeCategory d where s.studentid = ? and c.coursenumber = s.coursenumber and c.division like '%upper%' and s.studentid = u.studentid and d.degreeid = u.degree  union select distinct c.coursenumber, s.units,  d.upperdivunits from course c , pastclass s, undergraduate u, degreeCategory d where s.student_id = ? and c.coursenumber = s.course_number and c.division like '%upper%' and s.student_id = u.studentid and d.degreeid = u.degree ) select  sum(cast(upperdivunits as int))/count(*) - sum(cast(units as int)) as upperNeeded  from newscore"
);
                pstmt5 = connection.prepareStatement(
                "with newscore as(select distinct c. coursenumber, s.units, d.techunits from course c , studentEnrollment s,undergraduate u, degreeCategory d where s.studentid = ? and c.coursenumber = s.coursenumber and c.division = 'tech' and s.studentid = u.studentid and d.degreeid = u.degree  union select distinct c.coursenumber, s.units,  d.techunits from course c , pastclass s, undergraduate u, degreeCategory d where s.student_id = ? and c.coursenumber = s.course_number and c.division like '%tech%' and s.student_id = u.studentid and d.degreeid = u.degree ) select  sum(cast(techunits as int))/count(*) - sum(cast(units as int)) as techNeeded  from newscore"
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
                    pstmt.setString(1, ID);
                    resultSet = pstmt.executeQuery();
                } catch (SQLException e){
                    e.printStackTrace();
                }

                return resultSet;

            }

            public ResultSet getUnits(String ID){
                try{
                    pstmt2.setString(1, ID);
                     pstmt2.setString(2, ID);
                     pstmt2.setString(3, ID);
                     pstmt2.setString(4, ID);
                     pstmt2.setString(5, ID);
                     pstmt2.setString(6, ID);
                    resultSet2 = pstmt2.executeQuery();
                } catch (SQLException e){
                    e.printStackTrace();
                }

                return resultSet2;

            }

            public ResultSet getLowerNeeded(String ID){
             try{
                    pstmt3.setString(1, ID);
                                        pstmt3.setString(2, ID);

                    resultSet3 = pstmt3.executeQuery();
                } catch (SQLException e){
                    e.printStackTrace();
                }

                return resultSet3;
            }

            public ResultSet getUpperNeeded(String ID){
             try{
                    pstmt4.setString(1, ID);
                                        pstmt4.setString(2, ID);

                    resultSet4 = pstmt4.executeQuery();
                } catch (SQLException e){
                    e.printStackTrace();
                }

                return resultSet4;
            }

            public ResultSet getTechNeeded(String ID){
             try{
                    pstmt5.setString(1, ID);
                                        pstmt5.setString(2, ID);

                    resultSet5 = pstmt5.executeQuery();
                } catch (SQLException e){
                    e.printStackTrace();
                }

                return resultSet5;
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
            String degreetitle = new String();

            if(request.getParameter("title") != null){
                degreetitle = request.getParameter("title");
            }
            Studentsclasses degree = new Studentsclasses();
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

            Studentsclasses stdclasses = new Studentsclasses();
            ResultSet classes = stdclasses.getClasses(studentID);
            ResultSet classes2 = stdclasses.getUnits(studentID);
            ResultSet classes3 = stdclasses.getLowerNeeded(studentID);
            ResultSet classes4 = stdclasses.getUpperNeeded(studentID);
                        ResultSet classes5 = stdclasses.getTechNeeded(studentID);
        %>
        <table border="1">
            <tbody>
                <tr>
                    <td>Student's Degree</td>
                    <td>Units required</td>
                    <td>Lower Units Required</td>
                    <td>Upper Units Required</td>
    <td>Tech Units Required</td>
    <td>Lower Units Needed</td>
    <td>Upper Units Needed</td>
    <td>Tech Units Needed</td>
    <td>Total Units Needed</td>
                </tr>
                <tr>
                <% while (classes.next()){ %>
                    <td><%= classes.getString("title") %></td>
                    <td><%= classes.getString("unitsreq") %></td>
                    <td><%= classes.getString("lowerdivunits") %></td>
                    <td><%= classes.getString("upperdivunits") %></td>
    <td><%= classes.getString("techunits") %></td>
                <% } %>
        <% while (classes3.next()){ %>
    <td><%= classes3.getInt("lowerNeeded") %></td>
        <% } %>
        <% while (classes4.next()){ %>
    <td><%= classes4.getInt("upperneeded") %></td>
        <% } %>
        <% while (classes5.next()){ %>
    <td><%= classes5.getInt(1) %></td>
        <% } %>
                <% while (classes2.next()){ %>
                    <td><%= classes2.getInt(1) %></td>
                <% } %>
                </tr>
            </tbody>
        </table>
        
        </div>
        </div>
    </body>
</html>
