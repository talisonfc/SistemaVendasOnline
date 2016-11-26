<%@page import="entidade.Pagamento"%>
<%@page import="DAO.PagamentoDAO"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="java.io.File"%>
<%@page import="DAO.PedidoDAO"%>
<%@page import="entidade.Pedido"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entidade.Produto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ page import="entidade.Usuario" %>
    <%@ page import="DAO.UsuarioDAO" %>
    <%@ page import="entidade.Pessoa" %>
    <%@ page import="DAO.PessoaDAO" %>
    <%@ page import="entidade.Endereco" %>
    <%@ page import="DAO.EnderecoDAO" %>
    <%@ page import="entidade.Fornecedor" %>
    <%@ page import="DAO.FornecedorDAO" %>
    <%@ page import="entidade.Produto" %>
    <%@ page import="DAO.ProdutoDAO" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Insert title here</title>
		<link type="text/css" rel="stylesheet" href="css/estilo.css">
		<link type="text/css" rel="stylesheet" href="lib/bootstrap/bootstrap.min.css">
		<link rel="stylesheet" href="lib/fonts/font-awesome/css/font-awesome.min.css">
                
		<script type="text/javascript">
			function menu(option){
				var div = document.getElementById('select');
                              
				if(option=='produto'){
                                    div.value = "1";
				}
				else if(option=='fornecedor'){
                                    div.value = "2";
				}
                                else if(option=='sair'){
                                    div.value = "3";
                                }
                                else if(option=='dados'){
                                    div.value = "4";
                                }
                                else if(option=='compras'){
                                    div.value = "5";
                                }
                                else if(option=='listaClientes'){
                                    div.value = "6";
                                }
                                else if(option=='listaEstoque'){
                                    div.value = "7";
                                }
                                else if(option=='listFalta'){
                                    div.value = "8";
                                }
                                else if(option=='estatistica'){
                                    div.value = "9";
                                }
				document.formulario.submit();
			}
			
			function openFile(){
				var fileInput = document.getElementById("inputFile");
				var files = fileInput.files;
				alert(files.name);
				var file;
				//Loop ataves dos arquivos
				for(var i=0 ; i<files.length ; i++){
					file = files.item(i);
					file = files[i];
					str=file.name;
				}
				alert(i);
			}
                        
                        function pFalta(v){
                            el = document.getElementById("qtn"+v);
                            prd = document.getElementById("prdFalta");
                            idd = document.getElementById("idFalta");
                            idd.value = v;
                            prd.value = el.value;
                            document.prdFaltando.submit();
                            <%
                                String qtn = request.getParameter("prdFalta");
                                String idd = request.getParameter("idFalta");
                                
                                if(qtn!=null && idd != null){
                                    ProdutoDAO prdddDAO = new ProdutoDAO();
                                    Produto prddd = prdddDAO.produtoID(Integer.parseInt(idd));
                                //Setando a nova quantidade
                                    prddd.setQuantidadeAtual(qtn);
                                    //Atualizando produto no banco
                                    prdddDAO.updateQtn(prddd);
                                }
                            %>
                        }
		</script>
	</head>
	<body>
		<!-- ########## CABECALHO -->
		<header>
                    <div class="container">
                        <div class="row">
                                <h1>Dasheboard</h1>	
                        </div>
                        <div class="row">
                            <nav>
                                <ul class="list-unstyled list-inline">
                                    <li><h3><a href="index.jsp"><i class="fa fa-home" aria-hidden="true"></i></a></h3></li>
                                    <li><h3><a onclick="menu('sair')" href="#"><i class="fa fa-sign-out" aria-hidden="true"></i></a></h3></li>
                                    <li>
                                        <%
                                        HttpSession sessao = request.getSession();
                                        Pessoa pessoa = (Pessoa)sessao.getAttribute("pessoa");
                                        Usuario user = (Usuario)sessao.getAttribute("usuario");
                                        %>
                                        <b>Seja bem vindo, <%out.print(pessoa.getNome()); %></b>
                                    </li>
                                    <li><h3><a href="pedidos.jsp"><i class="fa fa-shopping-cart" aria-hidden="true"></i></a></h3></li>
                                    
                                </ul>
                            </nav>
                        </div>
                    </div>
		</header>
	
		<!-- ########## CORPO -->
		<section>
			<div class="container">
				<%if(user.getTipoUsuario().equals("Vendedor")){ %>
				<div class="row">
					<div class="col-md-2">
						<nav>
							<ul>
								<li><a onclick="menu('estatistica')" href="#">Estatistica</a></li>
								<li><a href="#">Cadastro</a>
                                                                    <ul>
                                                                            <li><a href="#" onclick="menu('produto')">Produto</a></li>
                                                                            <li><a href="#" onclick="menu('fornecedor')">Fornecedores</a></li>
                                                                    </ul>
                                                                </li>
                                                                <li><a href="#" onclick="menu('listaClientes')">Clientes</a></li>
                                                                <li><a href="#">Produtos</a>
                                                                    <ul>
                                                                        <li><a href="#" onclick="menu('listaEstoque')">Estoque</a></li>
                                                                        <li><a href="#" onclick="menu('listFalta')">Falta</a></li>
                                                                    </ul>
                                                                </li>
							</ul>
						</nav>
						
						<!-- ######### FORM PARA CONTROLE DO MENU -->
						<div style="display:none">
							<form action="#" name="formulario">
								<input type="text" id="select" name="option">
							</form>
						</div>
					</div>
					
					<div class="col-md-10">
						<%
						String i = request.getParameter("option");
						String iForn = request.getParameter("optionForn");
						
                                                System.out.println("i: "+i);
                                                System.out.println("iForn: "+iForn);
                                                
						if(i!=null || iForn!=null){
							if(i==null) i=iForn;
							
							if(i.equals("1")){
								%><h3 class="funcao"><b><%out.print("Cadastro Produto");%></b></h3>
								
								<!-- ###### DADOS DO PRODUTO ##### -->
								<div class="col-md-6">
									<h4><b>Dados do produto</b></h4>
									<form action="#">
                                                                                <div class="form-group">
											<input type="text" class="form-control" name="nome" id="inputNome" placeholder="Nome">
                                                                                </div>
										
                                                                            <div class="form-group">
                                                                                <select class="form-control" name="lFornecedores">
                                                                                    <option value="null">Fornecedor</option>
                                                                                    <%
                                                                                        FornecedorDAO fDAO = new FornecedorDAO();
                                                                                        ArrayList<Fornecedor> lForn = new ArrayList<Fornecedor>();
                                                                                        lForn = fDAO.list();
                                                                                        for(Fornecedor f: lForn){
                                                                                    %><option value="<%out.print(f.getIdFornecedor()); %>"><%out.print(f.getNome()); %></option><%
                                                                                        }
                                                                                    %>    
                                                                                </select>
                                                                            </div>
                                                                            
										<div class="form-group">
											<input type="number" class="form-control" name="valorCompra" id="inputValorCompra" placeholder="Valor compra">
										</div>
										
										<div class="form-group">
											<input type="number" class="form-control" name="valorVenda" id="inputValorVenda" placeholder="Valor venda">
										</div>
										
										<div class="form-group">
											<input type="number" class="form-control" name="quantidadeAtual" id="inpuQuantidadeAtual" placeholder="Quantidade atual">
										</div>
										
										<div class="form-group">
											<input type="number" class="form-control" name="quantidadeMinima" id="inputQuantidadeMinima" placeholder="Quantidade minima">
										</div>
										
										<div class="form-group">
											<input type="number" class="form-control" name="lucro" id="inputLucro" placeholder="Lucro">
										</div>
										
										<div class="form-group">
                                                                                    <textarea rows="5" cols="5" name="descrissao" class="form-control"></textarea>
										</div>
										
										<input type="text" name="produto" value="produto" style="display: none">
										
										<div class="form-group">
											<button class="btn btn-default">Salvar</button>
										</div>
									</form>
								</div>
								
								<!-- ###### IMAGEM DO PRODUTO ###### -->
								<h3></h3>
								<form action="#">
									<h4><b>Imagem de exibição</b></h4>
									<div class="form-group">
										<label for="inputFile">Escolha uma imagem para apresentação</label>
										<input type="file" id="inputFile" name="imagem">
										<input type="text" name="produto" value="upload" style="display: none">
									</div>
									
									<div class="form-group">
										<button class="btn btn-default">Salvar</button>
									</div>
								</form>
								
								<%
							}
							else if(i.equals("2")){
								%><h3><b><%out.print("Cadastro Fornecedor");%></b></h3>
												
								<!-- ######### DADOS DE IDENTIFICAÇÃO DO FORNECEDOR -->
								<div class="col-md-6">
									<h4><b>Fornecedor</b></h4>
									<%if(iForn==null){ %>
									<form action="#">
										<div class="form-group">
											<input type="text" class="form-control" name="nome" placeholder="Nome">
										</div>
										
										<div class="form-group">
											<input type="text" class="form-control" name="cnpj" placeholder="CNPJ">
										</div>
										
										<div class="form-group">
											<input type="text" class="form-control" name="celular" placeholder="Celular">
										</div>
										
										<div class="form-group">
											<input type="text" class="form-control" name="fixo" placeholder="Fixo">
										</div>
										
										<div class="form-group">
											<input type="text" class="form-control" name="email" placeholder="E-mail">
										</div>
										
										<div class="form-group">
											<input type="text" class="form-control" name="obs" placeholder="Observação">
										</div>
										
										<input type="text" name="fornecedor" value="fornecedor" style="display: none">
										<input type="text" id="select" name="optionForn" value="2" style="display:none">
										
										<div class="form-group">
											<button onclick="menu('fornecedor')" class="btn btn-default">Proximo</button>
										</div>
									</form>
									<%
									} else if(iForn.equals(""+3)){
										HttpSession sessaoForn = request.getSession();
										Fornecedor temp = (Fornecedor)sessaoForn.getAttribute("fornCadastrado");
										%>
										<div class="form-group"><h5><%out.print(temp.getNome());%></h5></div>
										<div class="form-group"><h5><%out.print(temp.getCnpj());%></h5></div>
										<div class="form-group"><h5><%out.print(temp.getCelular());%></h5></div>
										<div class="form-group"><h5><%out.print(temp.getFixo());%></h5></div>
										<div class="form-group"><h5><%out.print(temp.getEmail());%></h5></div>
										<div class="form-group"><h5><%out.print(temp.getObservacao());%></h5></div>
										<%
									} %>
								</div>			
								
								<!-- ######### ENDEREÇO DO FORNECEDOR -->
								<div class="col-md-6">
									<!--<h4><b>Endereço</b></h4>
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
										
										<input type="text" name="fornecedor" value="endereco" style="display: none">
										
										<div class="form-group">
											<button class="btn btn-default">Salvar</button>
										</div>
									</form>-->
								</div>
									
								<%
							}
                                                        else if(i.equals("3")){ //Sair
                                                            pessoa = null;
                                                            sessao.setAttribute("pessoa", pessoa);
                                                            response.sendRedirect("index.jsp");
                                                        }
                                                        else if(i.equals("6")){//Listar todos os clientes do banco
                                                            ArrayList<Pessoa> pessoas = new ArrayList<Pessoa>();
                                                            PessoaDAO pDAO = new PessoaDAO();
                                                            pessoas = pDAO.list();
                                                            
                                                            out.print("<table class='table'>");
                                                            out.print("<tr>");
                                                                out.print("<td><b>Nome</b></td>");
                                                                out.print("<td><b>Sobrenome</b></td>");
                                                                out.print("<td><b>Nascimento</b></td>");
                                                                out.print("<td><b>CPF</b></td>");
                                                                out.print("<td><b>RG</b></td>");
                                                                out.print("<td><b>Celular</b></td>");
                                                                out.print("<td><b>Fixo</b></td>");
                                                                out.print("<td><b>Email</b></td>");
                                                                out.print("</tr>");
                                                            for(Pessoa p: pessoas){
                                                                out.print("<tr>");
                                                                out.print("<td>"+p.getNome()+"</td>");
                                                                out.print("<td>"+p.getSobrenome()+"</td>");
                                                                out.print("<td>"+p.getNascimento()+"</td>");
                                                                out.print("<td>"+p.getCpf()+"</td>");
                                                                out.print("<td>"+p.getRg()+"</td>");
                                                                out.print("<td>"+p.getCelular()+"</td>");
                                                                out.print("<td>"+p.getFixo()+"</td>");
                                                                out.print("<td>"+p.getEmail()+"</td>");
                                                                out.print("</tr>");
                                                            }
                                                            out.print("</table>");
                                                        }
                                                        else if(i.equals("7")){
                                                            ArrayList<Produto> listaEstoque = new ArrayList<Produto>();
                                                            ProdutoDAO pEstoque = new ProdutoDAO();
                                                            listaEstoque = pEstoque.list();
                                                            
                                                            out.print("<table class='table'>");
                                                            %>
                                                            <td><b>ID</b></td>
                                                            <td><b>Nome</b></td>
                                                            <td><b>Qtn. Atual</b></td>
                                                            <td><b>Qtn. Minima</b></td>
                                                            <td><b>V. Compra</b></td>
                                                            <td><b>V. Venda</b></td>
                                                                <%
                                                            for(Produto p: listaEstoque){
                                                                if(p.getQuantidadeAtual()>0){
                                                                    out.print("<tr>");
                                                                    out.print("<td>"+p.getIdProduto()+"</td>");
                                                                    out.print("<td>"+p.getNome()+"</td>");
                                                                    out.print("<td>"+p.getQuantidadeAtual()+"</td>");
                                                                    out.print("<td>"+p.getQuantidadeMinima()+"</td>");
                                                                    out.print("<td>"+p.getValorCompra()+"</td>");
                                                                    out.print("<td>"+p.getValorVenda()+"</td>");
                                                                    out.print("</tr>");
                                                                }
                                                            }
                                                            out.print("</table>");
                                                        }
                                                        else if(i.equals("8")){
                                                            ArrayList<Produto> listaEstoque = new ArrayList<Produto>();
                                                            ProdutoDAO pEstoque = new ProdutoDAO();
                                                            listaEstoque = pEstoque.list();
                                                            
                                                            out.print("<table class='table'>");
                                                            %>
                                                            <td><b>ID</b></td>
                                                            <td><b>Nome</b></td>
                                                            <td><b>Qtn. Atual</b></td>
                                                            <td><b>Qtn. Minima</b></td>
                                                            <td><b>V. Compra</b></td>
                                                            <td><b>V. Venda</b></td>
                                                                <%
                                                            for(Produto p: listaEstoque){
                                                                if(p.getQuantidadeAtual()==0){
                                                                    out.print("<tr><form>");
                                                                    out.print("<td><input style='width:50px; border: none; background-color:white' type='text' name='idProduto' value='"+p.getIdProduto()+"' disabled></td>");
                                                                    out.print("<td>"+p.getNome()+"</td>");
                                                                    out.print("<td><input id='qtn"+p.getIdProduto()+"' value='1'></td>");
                                                                    out.print("<td>"+p.getQuantidadeMinima()+"</td>");
                                                                    out.print("<td>"+p.getValorCompra()+"</td>");
                                                                    out.print("<td>"+p.getValorVenda()+"</form></td>");
                                                                    out.print("<td><button onclick='pFalta("+p.getIdProduto()+")' style='border:none; background-color:white'><i class='fa fa-arrow-circle-right' aria-hidden='true'></i></button></td>");
                                                                    out.print("</tr>");
                                                                }
                                                            }
                                                            out.print("</table>");
                                                        }
                                                        else if(i.equals("9")){
                                                            PessoaDAO pDAO = new PessoaDAO();
                                                            ProdutoDAO prdDAO = new ProdutoDAO();
                                                            PagamentoDAO pgDAO = new PagamentoDAO();
                                                            PedidoDAO pedDAO = new PedidoDAO();

                                                            ArrayList<Pessoa> pess = new ArrayList<Pessoa>();
                                                            ArrayList<Produto> prds = new ArrayList<Produto>();
                                                            ArrayList<Pagamento> pg = new ArrayList<Pagamento>();
                                                            ArrayList<Pedido> ped = new ArrayList<Pedido>();
                                                            
                                                            pess = pDAO.list();
                                                            prds = prdDAO.list();
                                                            pg = pgDAO.list();
                                                            ped = pedDAO.list();
                                                            
                                                            //Obtendo valor vendido
                                                            float valorVendido = 0;
                                                            for(Pedido p: ped){
                                                                valorVendido += prdDAO.produtoID(p.getProduto()).getValorCompra();
                                                            }

                                                            //obtendo o montante - valor total vendido
                                                            float montante = 0;
                                                            for(Pagamento p: pg){
                                                                montante += p.getValorTotal();
                                                            }
                                                            
                                                            %>
                                                            <h3><b>Estatisticas</b></h3>
                                                            <table class="table">
                                                                <tr>
                                                                    <td><h4><b>Qtn. Clientes</b></h4></td>
                                                                    <td><h4><b>Qtn. Produtos</b></h4></td>
                                                                    <td><h4><b>Montante</b></h4></td>
                                                                    <td><h4><b>Lucro</b></h4></td>
                                                                </tr>
                                                                <tr>
                                                                    <td><h3><%out.print(""+pess.size()); %></h3></td>
                                                                    <td><h3><%out.print(""+prds.size()); %></h3></td>
                                                                    <td><h3><%out.print(""+montante); %></h3></td>
                                                                    <td><h3><%out.print(""+(montante-valorVendido)); %></h3></td>
                                                                    <td><h3></h3></td>
                                                                </tr>
                                                            </table>
                                                            <%
                                                        }
						}
						%>
					</div>
                                        <form name="prdFaltando" style="display:none">
                                            <input type="text" id="idFalta" name="idFalta">
                                            <input type="text" id="prdFalta" name="prdFalta">
                                        </form>
				</div>
				<%
				}//Cliente
				else{ %>
                                    <div class="col-md-2">
                                        <nav>
                                            <ul>
                                                <li><a onclick="menu('dados')" href="#">Dados</a></li>
                                                <li><a onclick="menu('compras')" href="#">Compras</a>
                                            </ul>
                                        </nav>

                                        <!-- ######### FORM PARA CONTROLE DO MENU -->
                                        <div style="display:none">
                                            <form action="#" name="formulario">
                                                <input type="text" id="select" name="option">
                                            </form>
                                        </div>
                                    </div>
                                    
                                    <div class="col-md-10">
                                    <!-- #################### LOGICA DO CLIENTE -->
                                <% 
                                    String i = request.getParameter("option");
                                    System.out.println("Cliente: "+i);
                                    
                                    if(i!=null){
                                        if(i.equals("4")){ //Mostrar dados pessoais
                                            %><div class="col-md-2">
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

                                            </div><%
                                        }
                                        else if(i.equals("5")){ // Mostrar compras efetuadas
                                            ArrayList<Pedido> listaPedidos = new ArrayList<Pedido>();
                                            PedidoDAO pDAO = new PedidoDAO();
                                            listaPedidos = pDAO.pedidosCliente(pessoa);
                                            
                                            if(listaPedidos!=null){
                                                %><table class="table"> 
                                                    <tr>
                                                        <td><b>Nome</b></td>
                                                        <td><b>Quantidade</b></td>
                                                        <td><b>Status</b></td>
                                                        <td><b>Valor</b></td>
                                                    </tr>
                                                    <%
                                                ProdutoDAO prdDAO = new ProdutoDAO();
                                                for(Pedido p:listaPedidos){
                                                    Produto temp = new Produto();
                                                    temp = prdDAO.produtoID(p.getProduto());
                                                    out.print("<tr>");
                                                    out.print("<td>"+temp.getNome()+"</td>");
                                                    out.print("<td>"+p.getQuantidade()+"</td>");
                                                    out.print("<td>Aprovado</td>");
                                                    out.print("<td>"+temp.getValorVenda()+"</td>");
                                                }
                                                %></table> <%
                                            }else{
                                                %><h4><b>Voçê ainda não fez nenhum pedido!</b></h4> <%
                                            }
                                        }
                                        else if(i.equals("3")){ // Remover usuario da sessao
                                            pessoa = null;
                                            sessao.setAttribute("pessoa", pessoa);
                                            response.sendRedirect("index.jsp");
                                        }
                                    }
                                        }
                                
                                        %></div><%
/*    
################################################################################################
*/
				String fornecedor = request.getParameter("fornecedor");
				String produto = request.getParameter("produto");
				String imagem = request.getParameter("imagem");
				String option = request.getParameter("option");
				
				System.out.println("Produto: "+produto);
				System.out.println("Imagem: "+imagem);
				System.out.println("Fornecedor: "+fornecedor);
				if(fornecedor!=null){
					if(fornecedor.equals("endereco")){
						System.out.println("Fornecedor: "+fornecedor);
						
						Endereco address = new Endereco();
						
						address.setRua(request.getParameter("rua"));
						address.setNumero(request.getParameter("numero"));
						address.setBairro(request.getParameter("bairro"));
						address.setCidade(request.getParameter("cidade"));
						address.setEstado(request.getParameter("estado"));
						address.setPais(request.getParameter("pais"));
						address.setComplemento(request.getParameter("complemento"));
						
						HttpSession sessaoForn = request.getSession();
						Fornecedor temp = (Fornecedor)sessaoForn.getAttribute("fornCadastrado");
						FornecedorDAO fornDAO = new FornecedorDAO();
						address.setPessoa(fornDAO.search(temp).getIdFornecedor());
						
						EnderecoDAO endDAO = new EnderecoDAO();
						endDAO.add(address);
						
					}
					else if(fornecedor.equals("fornecedor")){
						System.out.println("Fornecedor: "+fornecedor);
						
						Fornecedor forn = new Fornecedor();
						forn.setNome(request.getParameter("nome"));
						forn.setCnpj(request.getParameter("cnpj"));
						forn.setCelular(request.getParameter("celular"));
						forn.setFixo(request.getParameter("fixo"));
						forn.setEmail(request.getParameter("email"));
						forn.setObservacao(request.getParameter("obs"));
						
						FornecedorDAO fornDAO = new FornecedorDAO();
						fornDAO.add(forn);
						
						HttpSession sessaoForn = request.getSession();
						sessaoForn.setAttribute("fornCadastrado", forn);
					}
				}
				
				if(produto!=null){
                                    if(produto.equals("upload")){
                                        File img = new File("c:/img/"+imagem);
                                        BufferedImage imgBuffer = ImageIO.read(img);
                                        ImageIO.write(imgBuffer, "jpg", new File("C:/Users/Talison/Documents/NetBeansProjects/SistemaWeb/web/img/"+imagem));
                                        ProdutoDAO prdDAO = new ProdutoDAO();
                                        Produto prd = prdDAO.leastProduto();
                                        prd.setUrl(imagem);
                                        prdDAO.update(prd);
                                    }
                                    else{
                                        Produto prod = new Produto();
                                        prod.setFornecedor(request.getParameter("lFornecedores"));
                                        prod.setNome(request.getParameter("nome"));
                                        prod.setValorCompra(request.getParameter("valorCompra"));
                                        prod.setValorVenda(request.getParameter("valorVenda"));
                                        prod.setQuantidadeAtual(request.getParameter("quantidadeAtual"));
                                        prod.setQuantidadeMinima(request.getParameter("quantidadeMinima"));
                                        prod.setLucro(request.getParameter("lucro"));
                                        prod.setDescricao(request.getParameter("descrissao"));
                                        prod.setUrl("arduino.png");

                                        ProdutoDAO prodDAO = new ProdutoDAO();
                                        prodDAO.add(prod);
                                    }
				}
				%>
			</div>
		</section>
	
	
		<!-- ########## RODAPE -->
		<footer>
			
		</footer>
	</body>
</html>