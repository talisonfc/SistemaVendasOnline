<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="DAO.ConnectionDB"%>
<%@page import="java.sql.Connection"%>
<%@page import="DAO.ProdutoDAO" %>
<%@page import="entidade.Produto" %>
<%@page import="entidade.Pessoa" %>
<%@page import="entidade.Usuario" %>
<%@page import="entidade.Pagamento" %>
<%@page import="DAO.PagamentoDAO" %>
<%@page import="entidade.Pedido" %>
<%@page import="DAO.PedidoDAO" %>

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
                var form = document.getElementById("finalizar");
                form.value = v;
                document.fomulario.submit();
            }
            
            function valor(v){
                var valor = document.getElementById(v);
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
                                                <li><a href="index.jsp">Inicio</a></li>
                                                <li>
                                                    <%
                                                    HttpSession sessao = request.getSession();
                                                    Pessoa pessoa = (Pessoa)sessao.getAttribute("pessoa");
                                                    Usuario user = (Usuario)sessao.getAttribute("usuario");
                                                    
                                                    if(pessoa!=null){
                                                    %>
                                                    <b>Seja bem vindo, 
                                                    <%
                                                        out.print(pessoa.getNome()); 
                                                    }else{
                                                    %><a href="login.jsp"><b style="color:red">Login</b></a> <%
                                                    }
                                                    
                                                    %></b>
                                                </li>
                                                <li>
                                                    <form name="fomulario" style="display: none">
                                                        <input type="text" value="1" id="finalizar" name="finalizar">
                                                    </form>
                                                </li>
                                        </ul>
                                </nav>
                            </div>
                    <%
                    //Indices selecionados
                    ArrayList<Integer> listaCompra;
                    HttpSession carr = request.getSession();
                    listaCompra = (ArrayList<Integer>)carr.getAttribute("carrinho");
                    
                    //Bucas informações dos produtos no banco
                    ArrayList<Produto> lpC = new ArrayList<Produto>();
                    ProdutoDAO lpDAO = new ProdutoDAO();
                    lpC = lpDAO.searchID(listaCompra);
                    
                    float total = 0;
                    if(listaCompra!=null){    
                        for(Produto p: lpC){
                            total=total+p.getValorVenda();
                        }
                    }
                    %>
                                                <div class="col-md-3"></div>
                                                <div class="col-md-3">
                                                    <h3><b>Valor total: </b><%out.print(""+total); %></h3>
                                                </div>
                                                
                                                

                    </div>
                </div>
            </header>
        
            <!-- ########## CABECALHO  -->
            <section>
            <div class="container">
                <% 
                    String finalizar = request.getParameter("finalizar");
                    System.out.println("Fa "+finalizar);
                    if(listaCompra!=null && finalizar==null){
                        %> <table class="table"> <%
                        for(Produto pIndex: lpC){
                            out.print("<tr>");
                            out.print("<td>"+pIndex.getNome()+"</td>");
                            out.print("<td>"+pIndex.getValorVenda()+"</td>");
                            %>
                            <td>
                                <form>
                                    <input type="number" onclick="valor(<%out.print(pIndex.getIdProduto()); %>)" id="<%out.print(pIndex.getIdProduto()); %>" value="1" style="width: 50px; border: none">
                                </form>
                            </td>
                            <%
                            out.print("</tr>");
                        }
                        %> </table><%
                    }else{
                        
                        GregorianCalendar dataHora = new GregorianCalendar();
                        //Criar lista de pedidos com os produtos selecionado, e quantidades
                        ArrayList<Pedido> pedidos = new ArrayList<Pedido>();
                        for(Integer i: listaCompra){
                            Pedido pTemp = new Pedido();
                            pTemp.setProduto(""+i);
                            //O pagamento fica para a proxima tela
                            pTemp.setCliente(""+pessoa.getIdPessoa());
                            pTemp.setDataCompra(""+dataHora.DATE);
                            pTemp.setHoraCompra(""+dataHora.HOUR_OF_DAY);
                            pTemp.setObservacao("vazio");
                            pTemp.setDataPostagem(""+dataHora.DATE);
                            pTemp.setDataEntrega(""+dataHora.DATE);
                            pTemp.setQuantidade("1");
                            pTemp.setCodigoRastreamente("RRRR222332ASAS");
                            pedidos.add(pTemp);
                        }
                        carr.setAttribute("pedidos", pedidos);
                        %>
                        <div class="col-md-6">
                        <form action="#">
                            <div class="form-group">
                                <select class="form-control" name="formaPagamento">
                                    <option selected>Forma de pagamento</option>
                                    <option value="Boleto">Boleto</option>
                                    <option value="Cartão">Cartao</option>
                                </select>
                            </div>
                            
                            <div class="form-group">
                                <select class="form-control" name="numParcelas">
                                    <option value="0">Número de Parcelas</option>
                                    <%
                                        DecimalFormat format = new DecimalFormat("0.00");
                                        for(int i=1; i<10; i++){
                                            %><option value="<% out.print(i);%>">0<%
                                            out.print(""+i+" de "+format.format(total/i)+" - sem juro</option>");
                                        }
                                        for(int i=10; i<=12; i++){
                                            out.print("<option value="+i+">"+i+" de "+format.format(total/i)+" - sem juro</option>");
                                        }
                                    %>
                                </select>
                            </div>
                                
                            <input type="text" value="3" name="finalizar" style="display: none">
                                    
                            <div class="form-group">
                                <button type="submit" class="btn btn-default">Pagar</button>
                            </div>
                        </form>
                        </div>
                        <%
                    }

                    if(finalizar!=null){
                        if(finalizar.equals("3")){
                            Pagamento pagamento = new Pagamento();
                            pagamento.setFormaPagamento(request.getParameter("formaPagamento"));
                            pagamento.setNumeroParcelas(request.getParameter("numParcelas"));
                            pagamento.setJuro("0");
                            pagamento.setValorDaParcela(""+(total/Integer.parseInt(request.getParameter("numParcelas"))));
                            pagamento.setStatusPagamento("Aprovador");
                            pagamento.setValorTotal(""+total);
                            
                            PagamentoDAO pagamentoDAO = new PagamentoDAO();
                            pagamentoDAO.add(pagamento);
                            
                            //Atualizar quantidade de produtos
                            lpDAO.updateQtn(lpC);
                            
                            //Captura o ultimo pagamento efetuado para cadastrar o pedido
                            pagamento = pagamentoDAO.leastPagamento();
                            
                            //Lista de pedidos para cadastrar no banco
                            ArrayList<Pedido> lPedidos = new ArrayList<Pedido>();
                            lPedidos = (ArrayList<Pedido>)carr.getAttribute("pedidos");
                            System.out.println("Lista de pedidos"+lPedidos.size());
                            
                            PedidoDAO pDAO = new PedidoDAO();
                            for(Pedido p: lPedidos){
                                p.setPagamento(""+pagamento.getIdPagamento());
                                pDAO.add(p);
                            }
                            listaCompra = new ArrayList<Integer>();
                            carr.setAttribute("carrinho",listaCompra);

                            response.sendRedirect("index.jsp");
                        }   
                    }
                %>
                
                <% if(finalizar==null){ %>
                <div class="row">
                    <div class="col-md-10"></div>
                    <div class="col-md-2">
                            <div class="form-group">
                                <button onclick="pSelected(2)" class="btn btn-default">Finalizar</button>
                            </div>
                    </div>
                </div>
                <%} %>
            </div>
            </section>
           
        </body>
</html>