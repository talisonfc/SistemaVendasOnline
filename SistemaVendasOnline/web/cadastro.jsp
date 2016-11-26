<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	
	<%@page import="DAO.ConnectionDB"%> 
	<%@ page import="java.sql.*"%>   
    <%@ page import="entidade.Pessoa" %>
    <%@ page import="DAO.PessoaDAO" %>
    <%@ page import="entidade.Endereco" %>
    <%@ page import="DAO.EnderecoDAO" %>
    <%@ page import="entidade.Usuario" %>
    <%@ page import="DAO.UsuarioDAO" %>
    
    <%@ page import="java.sql.Connection" %>
    <%@ page import="DAO.ConnectionDB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Insert title here</title>
		<link type="text/css" rel="stylesheet" href="css/estilo.css">
		<link type="text/css" rel="stylesheet" href="lib/bootstrap/bootstrap.min.css">
		
	</head>
	<body>
		<!-- ########## CABECALHO -->
		<header>
			<div class="container">
				<div class="row">
					<h1>Cadastro</h1>	
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
			
			
		<%
		int i=1;
		String cont = request.getParameter("next");
		if(cont!=null)
			i=Integer.parseInt(cont);
		%>
		
		<!-- ########## CORPO -->
		<section>
			<div class="container">
				<div class="row">
					<!--DADOS PESSOAIS-->
					<div class="col-md-4 cadastro-background">
						<h3>Dados Pessoais</h3>
						
						<% if(i==1){%>
						<form action="#">
							<div class="form-group">
								<input type="text" class="form-control" name="nome" id="inputName" placeholder="Nome">
							</div>
	
							<div class="form-group">
								<input type="text" class="form-control" name="sobrenome" id="inputSobrenome" placeholder="Sobrenome">
							</div>
	
							<div class="form-group">
								<input type="date" class="form-control" name="nascimento" id="inputNascimento">
							</div>
	
							<div class="form-group">
								<select class="form-control" name="sexo" >
									<option value="Sexo" selected>Sexo</option>
									<option value="Indefinido">Indefinido</option>
									<option value="Masculino">Masculino</option>
								  	<option value="Feminino">Feminino</option>
								</select>
							</div>
	
							<div class="form-group">
								<input type="text" class="form-control" name="cpf" id="inputCPF" placeholder="CPF">
							</div>
	
							<div class="form-group">
								<input type="text" class="form-control" name="rg" id="inputRG" placeholder="RG">
							</div>
	
							<div class="form-group">
								<input type="number" class="form-control" name="celular" id="inputCelular" placeholder="Celular">
							</div>
	
							<div class="form-group">
								<input type="number" class="form-control" name="fixo" id="inputFixo" placeholder="Fixo">
							</div>
							
							<div class="form-group">
								<input type="email" class="form-control" name="email" id="intputEmail" placeholder="E-mail">
							</div>
							
							<input type="text" name="next" value="2" style="display: none">
							
							<div class="form-group">
								<button class="btn btn-default">Proximo</button>
							</div>
						</form>
						<%
						} 
						else if(i==2){
							
						
							Pessoa pessoa = new Pessoa();
							pessoa.setNome(request.getParameter("nome"));
							pessoa.setSobrenome(request.getParameter("sobrenome"));
							pessoa.setNascimento(request.getParameter("nascimento"));
							pessoa.setSexo(request.getParameter("sexo"));
							pessoa.setCpf(request.getParameter("cpf"));
							pessoa.setRg(request.getParameter("rg"));
							pessoa.setCelular(request.getParameter("celular"));
							pessoa.setFixo(request.getParameter("fixo"));
							pessoa.setEmail(request.getParameter("email"));
							
							HttpSession sessao = request.getSession();
							sessao.setAttribute("pessoa", pessoa);
							
							PessoaDAO pDAO = new PessoaDAO();
							pDAO.add(pessoa);
							
							%>
							<div class="container">
								<div class="row">
									<div class="col-md-1">
										<div class="form-group"><h5><b>Nome:</b></h5></div>
										<div class="form-group"><h5><b>Sobrenome:</b></h5></div>
										<div class="form-group"><h5><b>Nascimento:</b></h5></div>
										<div class="form-group"><h5><b>Sexo:</b></h5></div>
										<div class="form-group"><h5><b>CPF:</b></h5></div>
										<div class="form-group"><h5><b>RG::</b></h5></div>
										<div class="form-group"><h5><b>Celular:</b></h5></div>
										<div class="form-group"><h5><b>Fixo:</b></h5></div>
										<div class="form-group"><h5><b>E-mail:</b></h5></div>
									</div>
									
									<div class="col-md-3">
										<div class="form-group"><h5><%out.print(pessoa.getNome());%></h5></div>
										<div class="form-group"><h5><%out.print(pessoa.getSobrenome());%></h5></div>
										<div class="form-group"><h5><%out.print(pessoa.getNascimento());%></h5></div>
										<div class="form-group"><h5><%out.print(pessoa.getSexo());%></h5></div>
										<div class="form-group"><h5><%out.print(pessoa.getCpf());%></h5></div>
										<div class="form-group"><h5><%out.print(pessoa.getRg());%></h5></div>
										<div class="form-group"><h5><%out.print(pessoa.getCelular());%></h5></div>
										<div class="form-group"><h5><%out.print(pessoa.getFixo());%></h5></div>
										<div class="form-group"><h5><%out.print(pessoa.getEmail());%></h5></div>
										
									</div>
								</div>
							</div>
							<%
							
						}
						else if(i>2){
							HttpSession sessao = request.getSession();
							Pessoa pessoa = (Pessoa)sessao.getAttribute("pessoa");
							%>
							<div class="container">
								<div class="row">
									<div class="col-md-1">
										<div class="form-group"><h5><b>Nome:</b></h5></div>
										<div class="form-group"><h5><b>Sobrenome:</b></h5></div>
										<div class="form-group"><h5><b>Nascimento:</b></h5></div>
										<div class="form-group"><h5><b>Sexo:</b></h5></div>
										<div class="form-group"><h5><b>CPF:</b></h5></div>
										<div class="form-group"><h5><b>RG::</b></h5></div>
										<div class="form-group"><h5><b>Celular:</b></h5></div>
										<div class="form-group"><h5><b>Fixo:</b></h5></div>
										<div class="form-group"><h5><b>E-mail:</b></h5></div>
									</div>
									
									<div class="col-md-3">
										<div class="form-group"><h5><%out.print(pessoa.getNome());%></h5></div>
										<div class="form-group"><h5><%out.print(pessoa.getSobrenome());%></h5></div>
										<div class="form-group"><h5><%out.print(pessoa.getNascimento());%></h5></div>
										<div class="form-group"><h5><%out.print(pessoa.getSexo());%></h5></div>
										<div class="form-group"><h5><%out.print(pessoa.getCpf());%></h5></div>
										<div class="form-group"><h5><%out.print(pessoa.getRg());%></h5></div>
										<div class="form-group"><h5><%out.print(pessoa.getCelular());%></h5></div>
										<div class="form-group"><h5><%out.print(pessoa.getFixo());%></h5></div>
										<div class="form-group"><h5><%out.print(pessoa.getEmail());%></h5></div>
										
									</div>
								</div>
							</div>
							<%
						}
						%>
						
					</div>
	
					<!--ENDERECO-->
					<div class="col-md-4 cadastro-background">
						
						<%if(i==2){ %>
						<h3>Endereço</h3>
						<form action="#">
							<div class="form-group">
								<input type="text" class="form-control" name="rua" id="inputRua" placeholder="Rua">
							</div>
	
							<div class="form-group">
								<input type="number" class="form-control" name="numero" id="inputNumero" placeholder="Número">
							</div>
	
							<div class="form-group">
								<input type="text" class="form-control" name="bairro" id="inputBairro" placeholder="Bairro">
							</div>
	
							<div class="form-group">
								<input type="text" class="form-control" name="cidade" id="inputCidade" placeholder="Cidade">
							</div>
	
							<div class="form-group">
								<input type="text" class="form-control" name="estado" id="inputEstado" placeholder="Estado">
							</div>
	
							<div class="form-group">
								<input type="text" class="form-control" name="pais" id="inputPais" placeholder="Pais">
							</div>
	
							<div class="form-group">
								<input type="text" class="form-control" name="complemento" id="inputComplemento" placeholder="Complemento">
							</div>
							
							<input type="text" name="next" value="3" style="display: none">
							
							<div class="form-group">
								<button class="btn btn-default">Proximo</button>
							</div>
						</form>
						<%
						}else if(i==3){
							
							HttpSession sessao = request.getSession();
							Pessoa pCadastrada = (Pessoa)sessao.getAttribute("pessoa");
							String cpf = pCadastrada.getCpf();
							System.out.println("CPF para busca: "+cpf);
							
							// Objeto para buscar id cadastrado
							PessoaDAO pb = new PessoaDAO();
							Pessoa temp = pb.search(pCadastrada);
							
							Endereco endereco = new Endereco();
							endereco.setPessoa(temp.getIdPessoa());
							endereco.setRua(request.getParameter("rua"));
							endereco.setNumero(request.getParameter("numero"));
							endereco.setBairro(request.getParameter("bairro"));
							endereco.setCidade( request.getParameter("cidade"));
							endereco.setEstado( request.getParameter("estado"));
							endereco.setPais(request.getParameter("pais"));
							endereco.setComplemento(request.getParameter("complemento"));
							
							sessao.setAttribute("endereco", endereco);
							EnderecoDAO eDAO = new EnderecoDAO();
							eDAO.add(endereco);
							
							%>
							<h3>Endereço</h3>
							<address>
								<%
								out.print(endereco.getRua()+" - ");
								out.print(endereco.getNumero()+" - ");
								out.print(endereco.getBairro()); %><br><%
								out.print(endereco.getCidade()+" - ");
								out.print(endereco.getEstado()+" - ");
								out.print(endereco.getPais());%><br><%
								out.print(endereco.getComplemento());
								%>
							</address>
							<%
						}
						if(i>3){
							HttpSession sessao = request.getSession();
							Endereco endereco = (Endereco)sessao.getAttribute("endereco");
							%>
							<h3>Endereço</h3>
							<address>
								<%
								out.print(endereco.getRua()+" - ");
								out.print(endereco.getNumero()+" - ");
								out.print(endereco.getBairro()); %><br><%
								out.print(endereco.getCidade()+" - ");
								out.print(endereco.getEstado()+" - ");
								out.print(endereco.getPais());%><br><%
								out.print(endereco.getComplemento());
								%>
							</address>
							<%
						}
						%>
					</div>
	
					<!--DADOS DE ACESSO-->
					<div class="col-md-4 cadastro-background">
					
						<%if(i==3){ %>
						<h3>Dados de acesso</h3>
						<form action="#">
							<div class="form-group">
								<input type="password" class="form-control" name="senha" id="inputSenha" placeholder="Senha">
							</div>
	
							<div class="form-group">
								<input type="password" class="form-control" name="repetirSenha" id="inputRepetirSenha" placeholder="Repetir senha">
							</div>
							
							<input type="text" name="next" value="4" style="display: none">
							
							<div class="form-group">
								<button class="btn btn-default">Cadastrar</button>
							</div>
						</form>
						<%
						} 
						else if(i==4){
							
							HttpSession sessao = request.getSession();
							Pessoa pCadastrada = (Pessoa)sessao.getAttribute("pessoa");
							
							// Objeto para buscar id cadastrado
							PessoaDAO pb = new PessoaDAO();
							Pessoa temp = pb.search(pCadastrada);
							
							Usuario user = new Usuario();
							user.setPessoa(temp.getIdPessoa());
							user.setTipoUsuario("Cliente");
							
							String senha = request.getParameter("senha");
							String rSenha = request.getParameter("repetirSenha");
							
							if(senha.equals(rSenha)){
								user.setSenha(senha);
							}
							
							UsuarioDAO userDAO = new UsuarioDAO();
							userDAO.add(user);
							
							%>
							<h3>Dados de acesso</h3>
							<div class=form-group>
								<p><b>Cadastro finalizado com sucesso!</b></p>
								Agora, você pode efetuar login.
							</div>
							<%
						}
						%>
					</div>
				</div>
				
			</div>
		</section>
	
	
		<!-- ########## RODAPE -->
		<footer>
			
		</footer>
	</body>
</html>