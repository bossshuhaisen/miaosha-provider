<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'index.jsp' starting page</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	
	<script type="text/javascript" src="./static/js/jquery-1.12.4.min.js"></script>
	<link href="./static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="./static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
	
	
  </head>
  
  <body>
  
			  <!-- 员工添加的模态框 -->
			<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			  <div class="modal-dialog" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			        <h4 class="modal-title" id="myModalLabel">员工添加</h4>
			      </div>
			      <div class="modal-body">
			        <form class="form-horizontal">
					  <div class="form-group">
					    <label class="col-sm-2 control-label">empName</label>
					    <div class="col-sm-10">
					      <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
					      <span class="help-block"></span>
					    </div>
					  </div>
					  <div class="form-group">
					    <label class="col-sm-2 control-label">email</label>
					    <div class="col-sm-10">
					      <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email@atguigu.com">
					      <span class="help-block"></span>
					    </div>
					  </div>
					  <div class="form-group">
					    <label class="col-sm-2 control-label">gender</label>
					    <div class="col-sm-10">
					      <label class="radio-inline">
							  <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
							</label>
							<label class="radio-inline">
							  <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
							</label>
					    </div>
					  </div>
					  <div class="form-group">
					    <label class="col-sm-2 control-label">deptName</label>
					    <div class="col-sm-4">
					    	<!-- 部门提交部门id即可 -->
					      <select class="form-control" name="dId">
					      </select>
					    </div>
					  </div>
					</form>
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
			        <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
			      </div>
			    </div>
			  </div>
			</div>
			  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  	<div class="container">
		<!-- 标题 -->
		<div class="row">
			<div class="col-md-12">
				<h1>SSM整合</h1>
			</div>
		</div>
		<!-- 按钮 -->
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-primary" id="user_add">新增</button>
				<button class="btn btn-danger" id="user_del">删除</button>
			</div>
		</div>
		<!-- 显示表格数据 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="user_table">
					<thead>
						<tr>
							<th>#</th>
							<th>序号</th>
							<th>Name</th>
							<th>gender</th>
							<th>age</th>
							<th>deptName</th>
							<th>操作</th>
						</tr>
					</thead>
					
					<tbody>
					
					</tbody>
				</table>
			</div>	
		</div>
			
	<!-- 显示分页信息 -->
		<div class="row">
			<!--分页文字信息  -->
			<div class="col-md-6" id="page_info_area"></div>
			
			<!-- 分页条信息 -->
			<div class="col-md-6" id="page_nav_area"></div>
								
		</div>
		
		</div>
	   <script type="text/javascript">
	   		$(function(){
				to_page(1);	   		
	   		})
	   		
	   		function to_page(page){
	   				$.ajax({
					url:"http://localhost:8080/ssm1/user",
					data:"page="+page,
					type:"GET",
					success:function(result){
						build_users(result);
						page_info(result);
						page_nav(result);
					}				
				});	   		
	   		}
	   		
	   		
	   		function build_users(result){
	   			$("#user_table tbody").empty();
	   			var user =result.list;
	   			$.each(user,function(index,item){
					var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
					var userId = $("<td></td>").append(item.uid);
					var uname = $("<td></td>").append(item.uname);
					var uage = $("<td></td>").append(item.uage);
					var usex = $("<td></td>").append(item.usex);
					var did = $("<td></td>").append(item.did);
	
					var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
									.append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
	
					editBtn.attr("edit-id",item.uid);
					var delBtn =  $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
									.append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
	
					delBtn.attr("del-id",item.uid);
					var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
					//var delBtn = 
					//append方法执行完成以后还是返回原来的元素
					$("<tr></tr>").append(checkBoxTd)
						.append(userId)
						.append(uname)
						.append(uage)
						.append(usex)
						.append(did)
						.append(btnTd)
						.appendTo("#user_table tbody");
				});
	   			
	   		}
	   		
	   		function page_info(result){
	   			$("#page_info_area").empty();
	   			$("#page_info_area").append("当前"+result.pageNum+"页,总"+result.pages+"页，总"+result.total+"条记录");
	   			
	   			
	   		}
	   		
	   		function page_nav(result){
	   			$("#page_nav_area").empty();
	   			var ul = $("<ul></ul>").addClass("pagination");
	   			var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
	   			var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
			if(result.hasPreviousPage == false){
				firstPageLi.addClass("disabled");
				prePageLi.addClass("disabled");
			}else{				
				firstPageLi.click(function(){
					to_page(1);
				});
				prePageLi.click(function(){
					to_page(result.pageNum -1);
				});
			}
			
			
			
			var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
			var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
			if(result.hasNextPage == false){
				nextPageLi.addClass("disabled");
				lastPageLi.addClass("disabled");
			}else{
				nextPageLi.click(function(){
					to_page(result.pageNum +1);
				});
				lastPageLi.click(function(){
					to_page(result.pages);
				});
			}
			
			
			
			//添加首页和前一页 的提示
			ul.append(firstPageLi).append(prePageLi);
			//1,2，3遍历给ul中添加页码提示
			$.each(result.navigatepageNums,function(index,item){
				
				var numLi = $("<li></li>").append($("<a></a>").append(item));
				if(result.pageNum == item){
					numLi.addClass("active");
				}
				numLi.click(function(){
					to_page(item);
				});
				ul.append(numLi);
			});
			//添加下一页和末页 的提示
			ul.append(nextPageLi).append(lastPageLi);
			
			//把ul加入到nav
			var navEle = $("<nav></nav>").append(ul);
			navEle.appendTo("#page_nav_area");
	   		}
	   		
		   	function reset_form(ele){
				$(ele)[0].reset();
				//清空表单样式
				$(ele).find("*").removeClass("has-error has-success");
				$(ele).find(".help-block").text("");
			}
	   		
	   		$("#user_add").click(){
		   		reset_form("#empAddModal form");
				//s$("")[0].reset();
				//发送ajax请求，查出部门信息，显示在下拉列表中
				getDepts("#empAddModal select");
				//弹出模态框
				$("#empAddModal").modal({
					backdrop:"static"
				});
	   		}
	   </script>

	</div>
    
  </body>
</html>
