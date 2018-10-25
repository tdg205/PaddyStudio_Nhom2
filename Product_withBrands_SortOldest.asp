<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="Connections/cn.asp" -->
<%
Dim rsBrands
Dim rsBrands_cmd
Dim rsBrands_numRows

Set rsBrands_cmd = Server.CreateObject ("ADODB.Command")
rsBrands_cmd.ActiveConnection = MM_cn_STRING
rsBrands_cmd.CommandText = "SELECT a. BrandName, count(*) as ProCount  FROM dbo.tbProduct a join dbo.tbBrand b on a.BrandName = b.BrandName group by a. BrandName" 
rsBrands_cmd.Prepared = true

Set rsBrands = rsBrands_cmd.Execute
rsBrands_numRows = 0
%>
<%
Dim rsProduct_withBrands__MMColParam
rsProduct_withBrands__MMColParam = "1"
If (Request.QueryString("BrandName") <> "") Then 
  rsProduct_withBrands__MMColParam = Request.QueryString("BrandName")
End If
%>
<%
Dim rsProduct_withBrands
Dim rsProduct_withBrands_cmd
Dim rsProduct_withBrands_numRows

Set rsProduct_withBrands_cmd = Server.CreateObject ("ADODB.Command")
rsProduct_withBrands_cmd.ActiveConnection = MM_cn_STRING
rsProduct_withBrands_cmd.CommandText = "SELECT * FROM dbo.tbProduct WHERE BrandName = ? ORDER BY ProductID ASC" 
rsProduct_withBrands_cmd.Prepared = true
rsProduct_withBrands_cmd.Parameters.Append rsProduct_withBrands_cmd.CreateParameter("param1", 200, 1, 20, rsProduct_withBrands__MMColParam) ' adVarChar

Set rsProduct_withBrands = rsProduct_withBrands_cmd.Execute
rsProduct_withBrands_numRows = 0
%>
<%
Dim rsLogo__MMColParam
rsLogo__MMColParam = "1"
If (Request.QueryString("BrandName") <> "") Then 
  rsLogo__MMColParam = Request.QueryString("BrandName")
End If
%>
<%
Dim rsLogo
Dim rsLogo_cmd
Dim rsLogo_numRows

Set rsLogo_cmd = Server.CreateObject ("ADODB.Command")
rsLogo_cmd.ActiveConnection = MM_cn_STRING
rsLogo_cmd.CommandText = "SELECT * FROM dbo.tbBrand WHERE BrandName = ?" 
rsLogo_cmd.Prepared = true
rsLogo_cmd.Parameters.Append rsLogo_cmd.CreateParameter("param1", 200, 1, 20, rsLogo__MMColParam) ' adVarChar

Set rsLogo = rsLogo_cmd.Execute
rsLogo_numRows = 0
%>
<%
Dim Repeat1__numRows
Dim Repeat1__index

Repeat1__numRows = -1
Repeat1__index = 0
rsBrands_numRows = rsBrands_numRows + Repeat1__numRows
%>
<%
Dim Repeat2__numRows
Dim Repeat2__index

Repeat2__numRows = 9
Repeat2__index = 0
rsProduct_withBrands_numRows = rsProduct_withBrands_numRows + Repeat2__numRows
%>
<%
Dim Repeat3__numRows
Dim Repeat3__index

Repeat3__numRows = 10
Repeat3__index = 0
rsLogo_numRows = rsLogo_numRows + Repeat3__numRows
%>
<%
'  *** Recordset Stats, Move To Record, and Go To Record: declare stats variables

Dim rsProduct_withBrands_total
Dim rsProduct_withBrands_first
Dim rsProduct_withBrands_last

' set the record count
rsProduct_withBrands_total = rsProduct_withBrands.RecordCount

' set the number of rows displayed on this page
If (rsProduct_withBrands_numRows < 0) Then
  rsProduct_withBrands_numRows = rsProduct_withBrands_total
Elseif (rsProduct_withBrands_numRows = 0) Then
  rsProduct_withBrands_numRows = 1
End If

' set the first and last displayed record
rsProduct_withBrands_first = 1
rsProduct_withBrands_last  = rsProduct_withBrands_first + rsProduct_withBrands_numRows - 1

' if we have the correct record count, check the other stats
If (rsProduct_withBrands_total <> -1) Then
  If (rsProduct_withBrands_first > rsProduct_withBrands_total) Then
    rsProduct_withBrands_first = rsProduct_withBrands_total
  End If
  If (rsProduct_withBrands_last > rsProduct_withBrands_total) Then
    rsProduct_withBrands_last = rsProduct_withBrands_total
  End If
  If (rsProduct_withBrands_numRows > rsProduct_withBrands_total) Then
    rsProduct_withBrands_numRows = rsProduct_withBrands_total
  End If
End If
%>
<%
Dim MM_paramName 
%>
<%
' *** Move To Record and Go To Record: declare variables

Dim MM_rs
Dim MM_rsCount
Dim MM_size
Dim MM_uniqueCol
Dim MM_offset
Dim MM_atTotal
Dim MM_paramIsDefined

Dim MM_param
Dim MM_index

Set MM_rs    = rsProduct_withBrands
MM_rsCount   = rsProduct_withBrands_total
MM_size      = rsProduct_withBrands_numRows
MM_uniqueCol = ""
MM_paramName = ""
MM_offset = 0
MM_atTotal = false
MM_paramIsDefined = false
If (MM_paramName <> "") Then
  MM_paramIsDefined = (Request.QueryString(MM_paramName) <> "")
End If
%>
<%
' *** Move To Record: handle 'index' or 'offset' parameter

if (Not MM_paramIsDefined And MM_rsCount <> 0) then

  ' use index parameter if defined, otherwise use offset parameter
  MM_param = Request.QueryString("index")
  If (MM_param = "") Then
    MM_param = Request.QueryString("offset")
  End If
  If (MM_param <> "") Then
    MM_offset = Int(MM_param)
  End If

  ' if we have a record count, check if we are past the end of the recordset
  If (MM_rsCount <> -1) Then
    If (MM_offset >= MM_rsCount Or MM_offset = -1) Then  ' past end or move last
      If ((MM_rsCount Mod MM_size) > 0) Then         ' last page not a full repeat region
        MM_offset = MM_rsCount - (MM_rsCount Mod MM_size)
      Else
        MM_offset = MM_rsCount - MM_size
      End If
    End If
  End If

  ' move the cursor to the selected record
  MM_index = 0
  While ((Not MM_rs.EOF) And (MM_index < MM_offset Or MM_offset = -1))
    MM_rs.MoveNext
    MM_index = MM_index + 1
  Wend
  If (MM_rs.EOF) Then 
    MM_offset = MM_index  ' set MM_offset to the last possible record
  End If

End If
%>
<%
' *** Move To Record: if we dont know the record count, check the display range

If (MM_rsCount = -1) Then

  ' walk to the end of the display range for this page
  MM_index = MM_offset
  While (Not MM_rs.EOF And (MM_size < 0 Or MM_index < MM_offset + MM_size))
    MM_rs.MoveNext
    MM_index = MM_index + 1
  Wend

  ' if we walked off the end of the recordset, set MM_rsCount and MM_size
  If (MM_rs.EOF) Then
    MM_rsCount = MM_index
    If (MM_size < 0 Or MM_size > MM_rsCount) Then
      MM_size = MM_rsCount
    End If
  End If

  ' if we walked off the end, set the offset based on page size
  If (MM_rs.EOF And Not MM_paramIsDefined) Then
    If (MM_offset > MM_rsCount - MM_size Or MM_offset = -1) Then
      If ((MM_rsCount Mod MM_size) > 0) Then
        MM_offset = MM_rsCount - (MM_rsCount Mod MM_size)
      Else
        MM_offset = MM_rsCount - MM_size
      End If
    End If
  End If

  ' reset the cursor to the beginning
  If (MM_rs.CursorType > 0) Then
    MM_rs.MoveFirst
  Else
    MM_rs.Requery
  End If

  ' move the cursor to the selected record
  MM_index = 0
  While (Not MM_rs.EOF And MM_index < MM_offset)
    MM_rs.MoveNext
    MM_index = MM_index + 1
  Wend
End If
%>
<%
' *** Move To Record: update recordset stats

' set the first and last displayed record
rsProduct_withBrands_first = MM_offset + 1
rsProduct_withBrands_last  = MM_offset + MM_size

If (MM_rsCount <> -1) Then
  If (rsProduct_withBrands_first > MM_rsCount) Then
    rsProduct_withBrands_first = MM_rsCount
  End If
  If (rsProduct_withBrands_last > MM_rsCount) Then
    rsProduct_withBrands_last = MM_rsCount
  End If
End If

' set the boolean used by hide region to check if we are on the last record
MM_atTotal = (MM_rsCount <> -1 And MM_offset + MM_size >= MM_rsCount)
%>
<%
' *** Go To Record and Move To Record: create strings for maintaining URL and Form parameters

Dim MM_keepNone
Dim MM_keepURL
Dim MM_keepForm
Dim MM_keepBoth

Dim MM_removeList
Dim MM_item
Dim MM_nextItem

' create the list of parameters which should not be maintained
MM_removeList = "&index="
If (MM_paramName <> "") Then
  MM_removeList = MM_removeList & "&" & MM_paramName & "="
End If

MM_keepURL=""
MM_keepForm=""
MM_keepBoth=""
MM_keepNone=""

' add the URL parameters to the MM_keepURL string
For Each MM_item In Request.QueryString
  MM_nextItem = "&" & MM_item & "="
  If (InStr(1,MM_removeList,MM_nextItem,1) = 0) Then
    MM_keepURL = MM_keepURL & MM_nextItem & Server.URLencode(Request.QueryString(MM_item))
  End If
Next

' add the Form variables to the MM_keepForm string
For Each MM_item In Request.Form
  MM_nextItem = "&" & MM_item & "="
  If (InStr(1,MM_removeList,MM_nextItem,1) = 0) Then
    MM_keepForm = MM_keepForm & MM_nextItem & Server.URLencode(Request.Form(MM_item))
  End If
Next

' create the Form + URL string and remove the intial '&' from each of the strings
MM_keepBoth = MM_keepURL & MM_keepForm
If (MM_keepBoth <> "") Then 
  MM_keepBoth = Right(MM_keepBoth, Len(MM_keepBoth) - 1)
End If
If (MM_keepURL <> "")  Then
  MM_keepURL  = Right(MM_keepURL, Len(MM_keepURL) - 1)
End If
If (MM_keepForm <> "") Then
  MM_keepForm = Right(MM_keepForm, Len(MM_keepForm) - 1)
End If

' a utility function used for adding additional parameters to these strings
Function MM_joinChar(firstItem)
  If (firstItem <> "") Then
    MM_joinChar = "&"
  Else
    MM_joinChar = ""
  End If
End Function
%>
<%
' *** Move To Record: set the strings for the first, last, next, and previous links

Dim MM_keepMove
Dim MM_moveParam
Dim MM_moveFirst
Dim MM_moveLast
Dim MM_moveNext
Dim MM_movePrev

Dim MM_urlStr
Dim MM_paramList
Dim MM_paramIndex
Dim MM_nextParam

MM_keepMove = MM_keepBoth
MM_moveParam = "index"

' if the page has a repeated region, remove 'offset' from the maintained parameters
If (MM_size > 1) Then
  MM_moveParam = "offset"
  If (MM_keepMove <> "") Then
    MM_paramList = Split(MM_keepMove, "&")
    MM_keepMove = ""
    For MM_paramIndex = 0 To UBound(MM_paramList)
      MM_nextParam = Left(MM_paramList(MM_paramIndex), InStr(MM_paramList(MM_paramIndex),"=") - 1)
      If (StrComp(MM_nextParam,MM_moveParam,1) <> 0) Then
        MM_keepMove = MM_keepMove & "&" & MM_paramList(MM_paramIndex)
      End If
    Next
    If (MM_keepMove <> "") Then
      MM_keepMove = Right(MM_keepMove, Len(MM_keepMove) - 1)
    End If
  End If
End If

' set the strings for the move to links
If (MM_keepMove <> "") Then 
  MM_keepMove = Server.HTMLEncode(MM_keepMove) & "&"
End If

MM_urlStr = Request.ServerVariables("URL") & "?" & MM_keepMove & MM_moveParam & "="

MM_moveFirst = MM_urlStr & "0"
MM_moveLast  = MM_urlStr & "-1"
MM_moveNext  = MM_urlStr & CStr(MM_offset + MM_size)
If (MM_offset - MM_size < 0) Then
  MM_movePrev = MM_urlStr & "0"
Else
  MM_movePrev = MM_urlStr & CStr(MM_offset - MM_size)
End If
%>
<!doctype html>
<html><!-- InstanceBegin template="/Templates/temp.dwt.asp" codeOutsideHTMLIsLocked="false" -->
<head>
<%
Dim rsFeedbackID
Dim rsFeedbackID_cmd
Dim rsFeedbackID_numRows

Set rsFeedbackID_cmd = Server.CreateObject ("ADODB.Command")
rsFeedbackID_cmd.ActiveConnection = MM_cn_STRING
rsFeedbackID_cmd.CommandText = "SELECT * FROM dbo.tbFeedback" 
rsFeedbackID_cmd.Prepared = true

Set rsFeedbackID = rsFeedbackID_cmd.Execute
rsFeedbackID_numRows = 0
%>
<%
Dim rsUserID
Dim rsUserID_cmd
Dim rsUserID_numRows

Set rsUserID_cmd = Server.CreateObject ("ADODB.Command")
rsUserID_cmd.ActiveConnection = MM_cn_STRING
rsUserID_cmd.CommandText = "SELECT * FROM dbo.tbUser" 
rsUserID_cmd.Prepared = true

Set rsUserID = rsUserID_cmd.Execute
rsUserID_numRows = 0
%>
<%
' *** Logout the current user.
MM_Logout = CStr(Request.ServerVariables("URL")) & "?MM_Logoutnow=1"
If (CStr(Request("MM_Logoutnow")) = "1") Then
  Session.Contents.Remove("MM_Username")
  Session.Contents.Remove("MM_UserRole")
  Session.Contents.Remove("MM_UserAuthorization")
  MM_logoutRedirectPage = "Home.asp"
  ' redirect with URL parameters (remove the "MM_Logoutnow" query param).
  if (MM_logoutRedirectPage = "") Then MM_logoutRedirectPage = CStr(Request.ServerVariables("URL"))
  If (InStr(1, UC_redirectPage, "?", vbTextCompare) = 0 And Request.QueryString <> "") Then
    MM_newQS = "?"
    For Each Item In Request.QueryString
      If (Item <> "MM_Logoutnow") Then
        If (Len(MM_newQS) > 1) Then MM_newQS = MM_newQS & "&"
        MM_newQS = MM_newQS & Item & "=" & Server.URLencode(Request.QueryString(Item))
      End If
    Next
    if (Len(MM_newQS) > 1) Then MM_logoutRedirectPage = MM_logoutRedirectPage & MM_newQS
  End If
  Response.Redirect(MM_logoutRedirectPage)
End If
%>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="">
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/font-awesome.min.css" rel="stylesheet">
<link href="css/prettyPhoto.css" rel="stylesheet">
<link href="css/price-range.css" rel="stylesheet">
<link href="css/animate.css" rel="stylesheet">
<link href="css/main.css" rel="stylesheet">
<link href="css/responsive.css" rel="stylesheet">
<script src="js/jquery.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/jquery.scrollUp.min.js"></script>
<script src="js/price-range.js"></script>
<script src="js/jquery.prettyPhoto.js"></script>
<script src="js/main.js"></script>
<!-- InstanceBeginEditable name="doctitle" -->
<title>Hiển Thị Sản Phẩm</title>
<!-- InstanceEndEditable -->
<!-- InstanceBeginEditable name="head" -->
<!-- InstanceEndEditable -->
</head>
<!-- InstanceBeginEditable name="body" -->
<body>
<!-- InstanceEndEditable -->
<header id="header"><!--header-->
  <div class="header-middle"><!--header-middle-->
    <div class="container">
      <div class="row"><a class="ps-logo" href="Home.asp" style="color:white;"><span style="color:#429DF1;">Paddy</span>Studio</a>
        <div class="mainmenu pull-left">
          <ul class="nav navbar-nav collapse navbar-collapse">
            <li><a href="Introduction.asp">Giới Thiệu</a></li>
            <li><a href="Product.asp">Sản Phẩm</a></li>
            <li><a href="EventAndNews.asp">Tin Tức</a></li>
            <li><a href="Contact.asp">Liên Hệ</a></li>
          </ul>
        </div>
        <div class="shop-menu pull-right">
          <ul class="nav navbar-nav">
            <% 	If(Session("MM_Username") <> "") Then %>
            <% 	If(Session("MM_UserRole") = "1") Then %>
            <li><a href="Admin_Account.asp?<%= Server.HTMLEncode(MM_keepNone) & MM_joinChar(MM_keepNone) & "UserID=" & Session("MM_Username") %>">Xin chào,<%=Session("MM_Username")%></a></li>
            <% 	Else If(Session("MM_UserRole") = "0") Then %>
            <li><a href="User_Account.asp?<%= Server.HTMLEncode(MM_keepNone) & MM_joinChar(MM_keepNone) & "UserID=" & Session("MM_Username") %>">Xin chào,<%=Session("MM_Username")%></a></li>
            <li><a href="User_Feedback.asp?<%= Server.HTMLEncode(MM_keepNone) & MM_joinChar(MM_keepNone) & "FeedbackMemberID=" & Session("MM_Username") %>">Phản Hồi</a></li>
            <%	End If %>
            <%	End If %>
            <li><a href="<%= MM_Logout %>">Đăng Xuất</a></li>
            <%	Else %>
            <li><a href="Register.asp">Đăng Ký</a></li>
            <li><a href="Login.asp">Đăng Nhập</a></li>
            <%	End If %>
          </ul>
        </div>
      </div>
    </div>
  </div>
  <!--/header-middle-->
  <div class="header-bottom"><!--header-bottom-->
    <div class="container">
      <div class="row">
        <div class="search_box pull-right">
          <form id="form1" name="form1" method="get" action="Result_Search.asp">
            <table border="0" cellpadding="0" cellpadding="0">
            <tr>
              <td><input type="text" name="txtSearch" id="txtSearch" placeholder="Tìm sản phẩm"/></td>
              <td><button type="submit" name="btnSearch" id="btnSearch" class="btn search" value="Tìm">Tìm</button></td>
            </tr>
            </table>
          </form>
        </div>
      </div>
    </div>
  </div>
  <!--/header-bottom-->
</header>
<!--/header-->

<!-- InstanceBeginEditable name="Slider" -->
    
    
	<!-- InstanceEndEditable -->
<section><!--section-->
  <div class="container">
    <div class="row">
      <div class="col-sm-3">
        <div class="left-sidebar">
          <% 	If(Session("MM_UserRole") = "1") Then %>
          <div class="brands_products"><!--brands manage products-->
            <h2>Ban Quản Trị</h2>
            <div class="brands-name">
              <ul class="nav nav-pills nav-stacked">
                <li><a href="Admin_Home.asp">Trang Chủ Admin</a><a href="Admin_ManageBrand.asp">Quản Lý Thương Hiệu</a><a href="Admin_ManageProduct.asp">Quản Lý Sản Phẩm</a><a href="Admin_ManageFeedback.asp">Quản Lý Phản Hồi</a><a href="Admin_ManageEventAndNews.asp">Quản Lý Tin Tức &amp; Sự Kiện</a><a href="Admin_ManageUser.asp">Quản Lý Thành Viên</a></li>
              </ul>
            </div>
          </div>
          <!--/brands manage products-->
          <br/>
          <p></p>
          <%	End If %>
          <div class="brands_products"><!--brands_products-->
            <h2>Thương Hiệu</h2>
            <div class="brands-name">
              <ul class="nav nav-pills nav-stacked">
                <% While ((Repeat1__numRows <> 0) AND (NOT rsBrands.EOF)) %>
                  <li><a HREF="Product_withBrands.asp?<%= Server.HTMLEncode(MM_keepNone) & MM_joinChar(MM_keepNone) & "BrandName=" & rsBrands.Fields.Item("BrandName").Value %>"><span class="pull-right">(<%=(rsBrands.Fields.Item("ProCount").Value)%>)</span><%=(rsBrands.Fields.Item("BrandName").Value)%></a></li>
                  <% 
					Repeat1__index=Repeat1__index+1
					Repeat1__numRows=Repeat1__numRows-1
					rsBrands.MoveNext()
					Wend
				%>
              </ul>
            </div>
          </div>
          <!--/brands_products-->
          <!-- InstanceBeginEditable name="left" -->
                       <br/><p></p>
                        <div class="brands_products"><!--brands_products-->
							<h2>Sắp Xếp</h2>
							<div class="brands-name">
								<ul class="nav nav-pills nav-stacked">
                                   	<li><a HREF="Product_withBrands.asp?<%= Server.HTMLEncode(MM_keepNone) & MM_joinChar(MM_keepNone) & "BrandName=" & rsLogo.Fields.Item("BrandName").Value %>">Mới Nhất -> Cũ Nhất</a></li>
                                    <li><a href="Product_withBrands_SortOldest.asp?<%= Server.HTMLEncode(MM_keepNone) & MM_joinChar(MM_keepNone) & "BrandName=" & rsLogo.Fields.Item("BrandName").Value %>">Cũ Nhất -> Mới Nhất</a></li>
                                    <li><a href="Product_withBrands_SortPrice.asp?<%= Server.HTMLEncode(MM_keepNone) & MM_joinChar(MM_keepNone) & "BrandName=" & rsLogo.Fields.Item("BrandName").Value %>">Giá Tăng Dần</a></li>	
                                 	<li><a href="Product_withBrands_SortPriceDESC.asp?<%= Server.HTMLEncode(MM_keepNone) & MM_joinChar(MM_keepNone) & "BrandName=" & rsLogo.Fields.Item("BrandName").Value %>">Giá Giảm Dần</a></li>
                                </ul>
							</div>
						</div><!--/brands_products-->
						<!-- InstanceEndEditable -->
        </div>
      </div>
      <div class="col-sm-9 padding-right">
        <!-- InstanceBeginEditable name="Content" -->
                    <div align="center" class="col-sm-12">
                    	<% While ((Repeat3__numRows <> 0) AND (NOT rsLogo.EOF)) %>
                    	<img src="images/logo/<%=(rsLogo.Fields.Item("BrandLogo").Value)%>" width="300" height="295"/>
                        <p align="justify"><%=(rsLogo.Fields.Item("BrandDescription").Value)%></p>
                        <% 
  							Repeat3__index=Repeat3__index+1
  							Repeat3__numRows=Repeat3__numRows-1
  							rsLogo.MoveNext()
							Wend
						%>
                    </div>
                    <h2 class="title text-center">Hiển Thị Sản Phẩm</h2>
					<div class="features_items"><!--features_items-->
						<% While ((Repeat2__numRows <> 0) AND (NOT rsProduct_withBrands.EOF)) %>
						<div class="col-sm-4">
							<div class="product-image-wrapper">
								<div class="single-products">
									<div class="productinfo text-center">
										<img src="images/product/<%=(rsProduct_withBrands.Fields.Item("ProductImage").Value)%>" width="268" height="249" />
										<h2><%=(rsProduct_withBrands.Fields.Item("Price").Value)%> VNĐ</h2>
										<p><%=(rsProduct_withBrands.Fields.Item("ProductName").Value)%></p>
                                        <a HREF="Product_Detail.asp?<%= Server.HTMLEncode(MM_keepNone) & MM_joinChar(MM_keepNone) & "ProductID=" & rsProduct_withBrands.Fields.Item("ProductID").Value %>" class="btn btn-default add-to-cart">Xem Chi Tiết</a>
									</div>
								</div>
							</div>
						</div>
                       	<% 
  							Repeat2__index=Repeat2__index+1
  							Repeat2__numRows=Repeat2__numRows-1
  							rsProduct_withBrands.MoveNext()
							Wend
						%>
                    </div><!--features_items-->
                    <div class="col-sm-12">
                    <table border="0" align="right">
                      <tr>
                        <td><% If MM_offset <> 0 Then %>
                            <a href="<%=MM_moveFirst%>" class="btn btn-default add-to-cart">Trang Đầu Tiên</a>
                            <% End If ' end MM_offset <> 0 %></td>
                        <td><% If MM_offset <> 0 Then %>
                            <a href="<%=MM_movePrev%>" class="btn btn-default add-to-cart">Trang Trước</a>
                            <% End If ' end MM_offset <> 0 %></td>
                        <td><% If Not MM_atTotal Then %>
                            <a href="<%=MM_moveNext%>" class="btn btn-default add-to-cart">Trang Sau</a>
                            <% End If ' end Not MM_atTotal %></td>
                        <td><% If Not MM_atTotal Then %>
                            <a href="<%=MM_moveLast%>" class="btn btn-default add-to-cart">Trang Cuối</a>
                            <% End If ' end Not MM_atTotal %></td>
                      </tr>
                    </table>
                    </div>
                    <!-- InstanceEndEditable -->
      </div>
    </div>
  </div>
</section>
<!--/section-->
<footer id="footer"><!--Footer-->
  <div class="footer-top">
    <div class="container">
      <div class="row">
        <div class="col-sm-5">
          <div class="companyinfo">
            <h2><span>Paddy</span>Studio</h2>
            <p>Đến với Paddy Studio là sự lựa chọn đúng đắn!</p>
          </div>
        </div>
      </div>
    </div>
  </div>
  <div class="footer-widget">
    <div class="container">
      <div class="row">
        <div class="col-sm-2">
          <div class="single-widget">
            <h2 style="color:#429DF1;">DỊCH VỤ</h2>
            <ul class="nav nav-pills nav-stacked">
              <li><a href="#">Hỗ Trợ Trực Tuyến</a></li>
              <li><a href="#">Liên Hệ</a></li>
              <li><a href="#">Câu Hỏi Thường Gặp</a></li>
            </ul>
          </div>
        </div>
        <div class="col-sm-2">
          <div class="single-widget">
            <h2 style="color:#429DF1;">CHÍNH SÁCH</h2>
            <ul class="nav nav-pills nav-stacked">
              <li><a href="#">Điều Khoản Sử Dụng</a></li>
              <li><a href="#">Chính Sách Bảo Mật</a></li>
            </ul>
          </div>
        </div>
        <div class="col-sm-2">
          <div class="single-widget">
            <h2 style="color:#429DF1;">VỀ CHÚNG TÔI</h2>
            <ul class="nav nav-pills nav-stacked">
              <li><a href="#">Về Paddy Studio</a></li>
              <li><a href="#">Nghề Nghiệp</a></li>
              <li><a href="#">Chương Trình Liên Kết</a></li>
              <li><a href="#">Bản Quyền</a></li>
            </ul>
          </div>
        </div>
        <div class="col-sm-5 col-sm-offset-1">
          <div class="single-widget">
            <h2 style="color:#429DF1;">LIÊN KẾT</h2>
            <form action="#" class="searchform">
              <p>Đăng ký nhận thông tin sự kiện mới nhất từ chúng tôi</p>
              <div>
                <table border="0" cellpadding="0" cellpadding="0">
                <tr>
                  <td><input type="text" placeholder="Email của bạn" /></td>
                  <td><button type="submit" class="btn search">Subscribe</button></td>
                </tr>
                </table>
              </div>
              <p><i>Thông tin của bạn sẽ được bảo mật tuyệt đối<br/>
                và bạn có thể hủy đăng ký bất cứ lúc nào.</i></p>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
  <div class="footer-bottom">
    <div class="container">
      <div class="row">
        <p class="pull-left">Copyright 2016 - 2018 Paddy Studio. All rights reserved.</p>
        <p class="pull-right">Designed by<span>Group 2 - Paddy Studio</span></p>
      </div>
    </div>
  </div>
</footer>
<!--/Footer-->
</body>
<!-- InstanceEnd --></html>
<%
rsBrands.Close()
Set rsBrands = Nothing
%>
<%
rsProduct_withBrands.Close()
Set rsProduct_withBrands = Nothing
%>
<%
rsLogo.Close()
Set rsLogo = Nothing
%>
