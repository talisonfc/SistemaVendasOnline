<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ page import="entidade.Usuario" %>
    <%@ page import="DAO.UsuarioDAO" %>
    <%@ page import="entidade.Pessoa" %>
    <%@ page import="DAO.PessoaDAO" %>
    
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Insert title here</title>
		<link type="text/css" rel="stylesheet" href="css/estilo.css">
		<link type="text/css" rel="stylesheet" href="lib/bootstrap/bootstrap.min.css">
	</head>
	<!--####################### CORPO -->
	<body>
		<!-- ########## CABECALHO -->
		<header>
			<div class="container">
				<div class="row">
					<h1>Login</h1>	
				</div>
				<div class="row">
					<nav>
						<ul class="list-unstyled list-inline">
							<li><a href="index.jsp">Inicio</a></li>
						</ul>
					</nav>
				</div>
			</div>
		</header>
	
		<!-- ########## CORPO -->
		<section>
                    <%
                        HttpSession sessao = request.getSession();
                        Pessoa p = (Pessoa)sessao.getAttribute("pessoa");
                        if(p!=null){
                            response.sendRedirect("dasheboard.jsp");
                        }
                    %>
			<div class="container">
				<div class="row">
					<div class="col-md-4"></div>
					<div class="col-md-4 login-bordas">
					
					<!-- ##### FORMULARIO DE LOGIN -->
						<form action="#">
							<div class="form-group">
						    	<label for="InputEmail1">Email</label>
						    	<input type="email" class="form-control" name="email" id="InputEmail1" placeholder="Email">
						  	</div>
						  	<div class="form-group">
						    	<label for="exampleInputPassword1">Senha</label>
						    	<input type="password" class="form-control" name="senha" id="exampleInputPassword1" placeholder="Password">
						  	</div>
						  	<a href="cadastro.jsp" class="btn btn-default">Cadastrar-se</a>
						  	<button type="submit" class="btn btn-default">Entrar</button>
						</form>
					<!-- #################################### -->
					
						<div class="form-group">
							<%
							String email = request.getParameter("email");
                                                        String senha = request.getParameter("senha");
						    			
						   	if(email!=null || senha!=null){
						   		Usuario user = new Usuario();
						   		user.setSenha(senha);
						   		
						   		//Pesquisar usuario pela senha
						   		UsuarioDAO userDAO = new UsuarioDAO();
						   		Usuario uTemp = userDAO.search(user);
						   		
						   		if(uTemp!=null){
						   			p = new Pessoa();
						   			p.setIdPessoa(uTemp.getPessoa());
						   			
						   			//Pesquisar pessoa pelo id
						   			PessoaDAO pDAO = new PessoaDAO();
						   			Pessoa pTemp = pDAO.searchID(p);
						   			
						   			if(email.equals(pTemp.getEmail())){
						   				sessao.setAttribute("pessoa", pTemp);
						   				sessao.setAttribute("usuario", uTemp);
						   				response.sendRedirect("dasheboard.jsp");
						   			}
						   		}
						   	}
						   	%>
						</div>
					</div>
				</div>
			</div>
		</section>
	
	
		<!-- ########## RODAPE -->
		<footer>
			
		</footer>
	</body>
</html>