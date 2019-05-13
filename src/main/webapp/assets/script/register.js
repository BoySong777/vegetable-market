$(function(){

	var error_name = false;
	var error_password = false;
	var error_check_password = false;
	var error_email = false;
	var error_check = false;
	var account = "";
	var password = "";
	var email = "";


	$('#user_name').blur(function() {
		check_user_name();
	});

	$('#pwd').blur(function() {
		check_pwd();
	});

	$('#cpwd').blur(function() {
		check_cpwd();
	});

	$('#email').blur(function() {
		check_email();
	});

	$('#allow').click(function() {
		if($(this).is(':checked'))
		{
			error_check = false;
			$(this).siblings('span').hide();
		}
		else
		{
			error_check = true;
			$(this).siblings('span').html('请勾选同意');
			$(this).siblings('span').show();
		}
	});


	function check_user_name(){
		var len = $('#user_name').val().length;
		if(len<3||len>20)
		{
			$('#user_name').next().html('请输入3-20个字符的用户名')
			$('#user_name').next().show();
			error_name = true;
		}
		else
		{
			account = $('#user_name').val();
			$.ajax({
				url : basePath+'/user/verifyAccount/'+account,
				type : 'get',
				success: function(data) {
					if(data.num>0){
						$('#user_name').next().html('此用户名已被占用')
						$('#user_name').next().show();
						error_name = true;
					}else{
						$('#user_name').next().hide();
						error_name = false;
					}
				},
				error:function () {
				    alert(basePath);
					alert("验证用户名时出错，ajax发送失败")
				}

			});
		}
	}

	function check_pwd(){
		var len = $('#pwd').val().length;
		if(len<1||len>20)
		{
			$('#pwd').next().html('密码最少1位，最长20位')
			$('#pwd').next().show();
			error_password = true;
		}
		else
		{
			$('#pwd').next().hide();
			error_password = false;
			password = $('#pwd').val();
		}		
	}


	function check_cpwd(){
		var pass = $('#pwd').val();
		var cpass = $('#cpwd').val();

		if(pass!=cpass)
		{
			$('#cpwd').next().html('两次输入的密码不一致')
			$('#cpwd').next().show();
			error_check_password = true;
		}
		else
		{
			$('#cpwd').next().hide();
			error_check_password = false;
		}		
		
	}

	function check_email(){
		var re = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;

		if(re.test($('#email').val()))
		{
			$('#email').next().hide();
			error_email = false;
			email = $('#email').val();
			$.ajax({
				url : basePath+'/user/verifyEmail/'+email+'/email',
				type : 'get',
				success: function(data) {
					if(data.num>0){
						$('#email').next().html('此邮箱已被使用')
						$('#email').next().show();
						error_email = true;
					}else{
						$('#email').next().hide();
						error_email = false;
					}
				},
				error:function () {
					alert("验证邮箱时出错，ajax发送失败")
				}

			});
		}
		else
		{
			$('#email').next().html('你输入的邮箱格式不正确')
			$('#email').next().show();
			error_check_password = true;
		}

	}


	$('#register').click(function() {
		check_user_name();
		check_pwd();
		check_cpwd();
		check_email();
		alert("注册方法");
		if(error_name == false && error_password == false && error_check_password == false && error_email == false && error_check == false)
		{
			$.ajax({
				url : basePath+'/user/register',
				type : 'post',
				data : $.toJSON({account:account,password:password,email:email}),
				contentType: 'application/json;charset=UTF-8',
				success: function(data) {
					if(data.isTrue){
						window.location.href ="login.jsp";
					}else{
						alert("注册失败，返回数据验证不通过")
					}
				},
				error:function () {
					alert("注册失败，ajax发送出现错误")
				}

			});
		}

	});








})