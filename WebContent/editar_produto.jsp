<%@ page language="java" contentType="text/html; UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.dao.interfaces.CategoriaDAO" %>
<%@ page import="model.dao.MySQLLojaUfscarDAOFactory" %>
<%@ page import="model.beans.Categoria" %>
<%@ page import="java.util.List" %>
<%@ page import="model.dao.interfaces.ProdutoDAO" %>
<%@ page import="model.beans.Produto" %>

<%
	int i = 0;
	Categoria categoria;
	CategoriaDAO lista = MySQLLojaUfscarDAOFactory.getCategoriaDAO();
	List<Categoria> categorias = lista.retrieve();
	
	int idProduto = Integer.parseInt(request.getParameter("id"));
	
	ProdutoDAO listaProduto = MySQLLojaUfscarDAOFactory.getProdutoDAO();
	Produto produto = listaProduto.retrieveProdutoID(idProduto);
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <link rel="stylesheet" href="css/main.css" />
        <link rel="stylesheet" href="css/bootstrap.min.css" />
        <script src="js/jquery-2.2.4.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="ckeditor/ckeditor.js"></script>
        <script>
        	$(document).ready(function(){
        		CKEDITOR.replace("textCaracteristicas");        		
        	});
        </script>
        
        <title>LojaUfscar</title>
    </head>
    <body>
        <div class="container-fluid">
            <jsp:include page="header_interno.jsp" />
                        
            <section class="row">
                <jsp:include page="menu_funcionario.jsp" />  
                <div class="col-md-9 center">
                    <div class="row panel panel-primary">
                        <div class="panel-heading">
                            <h3 class="panel-title"><b>Alteração de dados do Produto id #<%=produto.getId()%></b></h3>
                        </div>
                        <div class="panel-body">
                            <form name="form" action="ServletEditaProduto?id=<%=idProduto%>" method="POST" accept-charset="iso-8859-1,utf-8" class="form-horizontal">
                            	<div class="form-group">                        				
                        			<% if(request.getParameter("mensagem") != null)
                        			{	
                        			%>
                        			<%= request.getParameter("mensagem") %>
                        			<%} %>
                        			</div>
                              	<div class="form-group">

                                <div class="form-group">
                                    <label class="control-label col-md-2" for="descricao">Descrição</label>  
                                    <div class="col-md-8">
                                        <input type="text" class="form-control" name="descricao" value="<%=produto.getDescricao()%>" required/>
                                    </div>
                                </div>
                                
                                <div class="form-group">
                                    <label class="control-label col-md-2" for="categoria">Categoria</label>  
                                    <div class="col-md-4">
                                        <select name="categoria" class="form-control" required>
                                            <option disabled>Selecione uma categoria</option>
                                            <%
                                            	while(i < categorias.size()){
                                        			categoria = categorias.get(i);
                                        			
                                        			if(produto.getCategoria_id().getId() == categoria.getId()){
                                        				;
                                            %>		
                                        				<option selected value="<%= categoria.getId()%>"><%= categoria.getDescricao()%></option>
                                        	<% 
                                        			}else{
                                            			;
                                        	%>
                                        				<option value="<%= categoria.getId()%>"><%= categoria.getDescricao()%></option>
                                        	<%		
                                        			}
                                        		i++;
            									}
           									%>	
                                        </select>
                                    </div>
                                </div>
                                
                                <div class="form-group">
                                    <label class="control-label col-md-2" for="quantidade">Quantidade</label>  
                                    <div class="col-md-4">
                                        <input type="number" class="form-control" name="quantidade" min="1" value="<%=produto.getQuantidade_estoque()%>"required/>
                                    </div>
                                </div>
                                
                                <div class="form-group">
                                    <label class="control-label col-md-2" for="preco_custo">Preço de custo</label>  
                                    <div class="col-md-4">
                                        <input type="number" min="0.01" step="0.01" class="form-control" name="preco_custo" value="<%= produto.getPreco_custo()%>" required/>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="control-label col-md-2" for="preco_venda">Preço de venda</label>  
                                    <div class="col-md-4">
                                        <input type="number" min="0.01" step="0.01" class="form-control" name="preco_venda" value="<%=produto.getPreco_venda()%>"required/>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="control-label col-md-2" for="ativo">Ativo</label>  
                                    <div class="col-md-4">
                                        
                                        <%
                                        	if(produto.getStatus() == 1){
                                        		;
                                        %>
												<label class="radio-inline">
		                                            <input type="radio" name="ativo" value="1" checked/>Sim
		                                        </label>
		                                        <label class="radio-inline">
		                                            <input type="radio" name="ativo" value="0"/>Não
		                                        </label>
										<%
                                        	}else{
												;
										%>				                                        
                                        		<label class="radio-inline">
		                                            <input type="radio" name="ativo" value="1" />Sim
		                                        </label>
		                                        <label class="radio-inline">
		                                            <input type="radio" name="ativo" value="0" checked/>Não
		                                        </label>
                                        
                                        
                                        <%
                                        	}
                                        %>
                                    </div>
                                </div>
                                
                                <div class="form-group">
                                    <label class="control-label col-md-2" for="preco_venda">Características:</label>  
                                    <div class="col-md-6">
                                        <textarea class="form-control" id="textCaracteristicas"  name="textCaracteristicas" rows="7"><%=produto.getCaracteristicas()%></textarea>
                                    </div>
                                </div>
                                
                                <div class="form-group">
                                    <label class="control-label col-md-2" for="foto">Foto</label>  
                                    <div class="col-md-6">
                                        <input type="file" class="" name="foto"/>
                                        <br/>
                                        <button type="submit" class="pull-right btn btn-default" onClick="this.form.submit()">Salvar alterações</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </section>
        </div>
    </body>
</html>