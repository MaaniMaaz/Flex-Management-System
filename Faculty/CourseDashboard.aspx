<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CourseDashboard.aspx.cs" Inherits="db_projecta.Faculty.CourseDashboard" %>


   <!DOCTYPE html>
<html>
<head runat="server">
        <title>Fast Faculty Portal</title>
        <meta charset="UTF-8">
        <script src="https://kit.fontawesome.com/b99e675b6e.js"></script>
        <link href="Content/styles.css" rel="stylesheet" />
    <link rel="stylesheet" href="style.css">
        <script>
            $(document).ready(function () {
                $(".siderbar_menu li").click(function () {
                    $(".siderbar_menu li").removeClass("active");
                    $(this).addClass("active");
                });
                $(".hamburger").click(function () {
                    $(".wrapper").addClass("active");
                });
                $(".close, .bg_shadow").click(function () {
                    $(".wrapper").removeClass("active");
                });
            });
        </script>
  
    
</head>
<body>
    <form id="form1" >
        <div class="wrapper">
            <div class="sidebar">
                <div class="bg_shadow"></div>
                <div class="sidebar_inner">
                    <div class="close">
                        <i class="fas fa-times"></i>
                    </div>
                    <div class="profile_info">
                        
                        <div class="profile_data">
                            <p class="name">Faculty Portal</p>
                            <span><i class="fas fa-map-marker-alt"></i>Islamabad, Pak</span>
                        </div>
                    </div>
                    <ul class="siderbar_menu">
                        
                        <li><a href="Facultymain.aspx">
                            
                                <div class="icon"><i class="fas fa-home"></i></div>
                                <div class="title">Home</div>
                            </a>
                        </li>
                        <li><a href="CourseDashboard.aspx">
                           
                                <div class="icon"><i class="fas fa-hotel"></i></div>
                                <div class="title">Offered Courses</div>
                                
                            </a>
                        </li>
                        <li>
                            <a href="Evaluations%20Management.aspx">
                                <div class="icon"><i class="fas fa-book"></i></div>
                                <div class="title">Evaluations Management</div>
                            </a>
                        </li>
                        <li>
                            <a href="GradeGeneration.aspx">
                                <div class="icon"><i class="fas fa-user-tie"></i></div>
                                <div class="title">Grade Generation</div>
                            </a>
                            </li>
                          <li>
                            <a href="AttendanceManagement.aspx">
                                <div class="icon"><i class="fas fa-book"></i></div>
                                <div class="title">Attendance Management</div>
                            </a>
                        </li>
                        
                        <li>
                            <a href="ReportsGeneration.aspx">
                                <div class="icon"><i class="fas fa-book"></i></div>
                                <div class="title">Reports Generation</div>
                            </a>
                        </li>

                         <li>
                            <a href="AttendanceManagement.aspx">
                                <div class="icon"><i class="fas fa-book"></i></div>
                                <div class="title">Attendance Management</div>
                            </a>
                        </li>
                        
                        
                       
                           
                           
                    <div class="logout_btn">
                        <a href="../main/login.aspx">Logout</a>
                        
                    </div>
                </div>
            </div>
            <div class="main_container">
                <div class="navbar">
                    <div class="hamburger">
                        <i class="fas fa-bars"></i>
                    </div>
                    <div class="logo">
                        <a href="#">Fast Faculty Portal</a>
                    </div>
                </div>
                
            </div>
        </div>
    </form>
    <style>
        .form-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }
    </style>

  <div class="form-container">
        <form id="formCourseDashboard" runat="server">
            <h2>Course Dashboard</h2>
            <asp:GridView ID="gvCourses" runat="server" AutoGenerateColumns="false">
                <Columns>
                    <asp:BoundField DataField="course_code" HeaderText="Course Code" />
                    <asp:BoundField DataField="course_title" HeaderText="Course Title" />
                    <asp:BoundField DataField="section_number" HeaderText="Section" />
                </Columns>
            </asp:GridView>
        </form>
    </div>
</body>

    </html>



<style>
    


@import url('https://fonts.googleapis.com/css?family=Montserrat:400,600,700|Trade+Winds&display=swap');

*{
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  list-style: none;
  text-decoration: none;
  font-family: 'Montserrat';
}

body{
  background: #e7f1ff;
  font-size: 14px;
  letter-spacing: 1px;
}

.wrapper{
  display: flex;
  width: 100%;
}

.sidebar{
  position: relative;
}

.sidebar .bg_shadow{
  width: 100%;
  height: 100%;
  position: fixed;
  top: 0;
  left: 0;
  background: #000;
  z-index: 998;
  opacity: 0;
  visibility: hidden;
  transition: all 0.3s ease;
}

.sidebar_inner {
  width: 250px;
  position: fixed;
  top: 0;
  left: 0;
  height: 100vh;
  background: #5558c9;
  z-index: 999;
  transition: all 0.3s ease;
}

.main_container {
  margin-left: 250px;
  width: calc(100% - 250px);
   transition: all 0.3s ease;
}

.sidebar_inner .profile_info {
  padding: 20px;
  text-align: center;
}

.sidebar_inner .profile_info .profile_img {
  width: 100px;
  margin: 0 auto 5px;
}

.sidebar_inner .profile_info .profile_img img {
  width: 100%;
  display: block;
}

.sidebar_inner .profile_info .profile_data .name {
  font-size: 18px;
  color: #fff;
  margin-bottom: 5px;
  font-family: 'Trade Winds';
}

.sidebar_inner .profile_info .profile_data span {
  color: #c4dcff;
}

.sidebar_inner .siderbar_menu{
      height: 500px;
    overflow: auto;
}

.sidebar_inner .siderbar_menu > li > a {
  padding: 12px 20px;
  display: flex;
  align-items: center;
  position: relative;
  margin-bottom: 1px;
  color: #c4dcff;
}

.sidebar_inner .siderbar_menu > li > a .icon {
  font-size: 25px;
  margin-right: 15px;
}

.sidebar_inner .siderbar_menu > li.active > a,
.sidebar_inner .siderbar_menu > li > a:hover{
  background: #3d3d79;
  color: #fff;
  text-decoration: none !important;
}

.sidebar_inner .siderbar_menu > li > a .arrow{
  position: absolute;
  top: 20px;
  right: 20px;
  transition: all 0.3s ease;
}

.sidebar .logout_btn a{
  position: absolute;
  bottom: 20px;
  left: 20px;
  width: 210px;
  border: 1px solid #fff;
  color: #fff;
  border-radius: 5px;
  font-weight: 600;
  padding: 10px;
  text-align: center;
  transition: all 0.3s ease;
}

.sidebar .logout_btn a:hover {
    background: #fff;
    color: #3d3d79;
    text-decoration: none;
}

.sidebar_inner .close{
    position: absolute;
    top: 5px;
    right: 15px;
    font-size: 25px;
    color: #fff;
  cursor: pointer;
  display: none;
}

.sidebar_inner .close:hover,
.navbar .hamburger:hover{
  opacity: 0.7;
}

.navbar{
  background: #fff;
  height: 50px;
  width: 100%;
  box-shadow: 0 3px 5px rgba(0,0,0,0.125);
  display: flex;
  align-items: center;
  padding: 0 20px;
}

.navbar .hamburger{
  font-size: 25px;
  cursor: pointer;
  margin-right: 20px;
  color: #5558c9;
  display: none;
}

.navbar .logo a{
  font-family: 'Trade Winds';
  color: #5558c9;
  font-size: 20px;
}

.content{
  padding: 20px;
  display: flex;
  flex-wrap: wrap;
}

.content .item{
  background: #fff;
  box-shadow: 2px 2px 4px rgba(0,0,0,0.125), -2px -2px 4px rgba(0,0,0,0.125);
  margin: 10px 5px;
  width: 31.8%;
  padding: 20px;
}

.accordion{
  background: #6f6fc7;
  padding-left: 20px;
  height: 0px;
  transition: all 0.3s ease;
  overflow: hidden;
}

.accordion li a{
  display: block;
  color: #c4dcff;
  padding: 12px 0;
  padding-left: 10px;
}

.accordion li:last-child a{
  border-bottom: 0px;
}

.accordion li a.active {
    color: #fff;
    text-decoration: none;
}

.accordion li a:hover {
    background: #3d3d79;
    color: #fff;
}

.siderbar_menu > li.active .accordion {
    height:auto;
}

.siderbar_menu > li.active .arrow{
  transform: rotate(180deg);
  transition: all 0.3s ease;
}


@media (max-width: 1024px) {
  .sidebar_inner{
    left: -115%;
    transition: all 0.5s ease;
  }
  .main_container{
    width: 100%;
    margin-left: 0;
  }
  .navbar .hamburger,
  .sidebar_inner .close{
    display: block;
  }
  .content .item{
    width: 47%;
  }
  .wrapper.active .sidebar_inner{
  left: 0;
  transition: all 0.5s ease;
}

.wrapper.active .sidebar .bg_shadow{
  visibility: visible;
  opacity: 0.7;
}
}

@media (max-width: 528px) {
  .content .item{
    width: 100%;
  }
}
</style>