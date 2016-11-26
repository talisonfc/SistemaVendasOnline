<%@page import="java.util.ArrayList"%>
<%@page import="DAO.ConnectionDB"%>
<%@page import="java.sql.Connection"%>
<%@page import="DAO.ProdutoDAO" %>
<%@page import="entidade.Produto" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
	<link type="text/css" rel="stylesheet" href="css/estilo.css">
	<link type="text/css" rel="stylesheet" href="lib/bootstrap/bootstrap.min.css">
        <link rel="stylesheet" href="lib/fonts/font-awesome/css/font-awesome.min.css">
        
        <script type="text/javascript">
            function pSelected(v){
                var form = document.getElementById("pSelect");
                form.value = v;
                document.formulario.submit();
            }
        </script>
	</head>

	<body>
	
		<!-- ########## CABECALHO -->
		<header>
			<div class="container">
				<div class="row">
					<h1>Sistema de distribuição de produtos</h1>	
				</div>
				<div class="row">
                                    <div class="col-md-6">
					<nav>
						<ul class="list-unstyled list-inline">
							<li><a href="#">Inicio</a></li>
							<li><a href="login.jsp">Login</a></li>
						</ul>
					</nav>
                                    </div>
                                    
                                    <div class="col-md-4"></div>
                                    
                                    <div class="col-md-2">
                                        <%
                                            HttpSession carrinho = request.getSession();
                                            ArrayList<Integer> ids;
                                            ids = (ArrayList<Integer>)carrinho.getAttribute("carrinho");
                                            
                                            String pSelecionado = request.getParameter("pSelect");
                                            if(pSelecionado!=null){
                                                
                                                if(ids==null){
                                                    ids = new ArrayList<Integer>();
                                                    ids.add(Integer.parseInt(pSelecionado));
                                                    carrinho.setAttribute("carrinho", ids);
                                                }
                                                else{
                                                    //Verificar se o produto ja foi inserido
                                                    int ver = 0;
                                                    for(Integer in: ids){
                                                        if(in==Integer.parseInt(pSelecionado)){
                                                            ver++;
                                                        }
                                                    }
                                                    
                                                    //Adicionar o novo produto a sessao
                                                    if(ver==0){//Produto novo no carrinho
                                                        ids.add(Integer.parseInt(pSelecionado));
                                                    }
                                                    carrinho.setAttribute("carrinho", ids);
                                                    %><a href="pedidos.jsp"><h3><i class="fa fa-shopping-cart" aria-hidden="true"></i><%
                                                        out.print(" "+ids.size()+"</h3></a>");
                                                }
                                            }
                                            else{
                                                if(ids!=null){
                                                    %><a href="pedidos.jsp"><h3><i class="fa fa-shopping-cart" aria-hidden="true"></i><%
                                                     out.print(" "+ids.size()+"</h3></a>");
                                                }
                                                else{
                                                    %><a href="pedidos.jsp"><h3><i class="fa fa-shopping-cart" aria-hidden="true"></i><%
                                                     out.print("0</h3></a>");
                                                }
                                            }
                                        %>
                                    </div>
                                    
				</div>
			</div>
		</header>
	
		<!-- ########## CABECALHO -->
		<section>
		
			<div class="container">
                            
                            <form action="#" name="formulario">
                                <input type="text" name="pSelect" id="pSelect" style="display: none">
                            </form>
			<% 
                            ProdutoDAO pDAO = new ProdutoDAO();
                            ArrayList<Produto> lProd = new ArrayList<Produto>();
                            lProd = pDAO.estoque();
                            
                        int n = lProd.size();
                        int linha = n/6;
                        if(n%6!=0) linha++;
                        int coluna;
                        if(n>6)
                            coluna = 6;
                        else
                            coluna = n;
                        
                        int cont = 0;
			for(int i=0; i<linha; i++){
				%><div class="row"><%
				for(int j=0; j<coluna; j++){
					%>
					<div class="col-md-2">
						<img src="img/<%out.print(lProd.get(cont).getUrl());%>" alt="..." class="img-rounded" style="height: 120px">
                                                <div class="form-group" style="height: 180px">
                                                    <label><% out.print(lProd.get(cont).getNome()); %></label>
							<p style="font-size:12pt; color:#000">
                                                            <% out.print(lProd.get(cont).getDescricao()); %> </p>
						</div>
						
						
						<div class="form-group">
							<form>
								<h4><b><% out.print(lProd.get(cont).getValorVenda()); %> R$</b></h4>
                                                                <button onclick="pSelected('<%out.print(lProd.get(cont).getIdProduto());%>')" type="button" class="btn btn-primary">Comprar</button>
							</form>
						</div>
					</div> 
					
					<%
                                            cont++;
				}
				%></div><%
                                    n = n-6;
                                    if(n<6)
                                        coluna=n;
			}

			%>
			
            
			
		</div>
		</section>
	
	
		<!-- ########## CABECALHO -->
		<footer>
			
		</footer>
	</body>
</html>