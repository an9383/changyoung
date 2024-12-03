<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<title>MES</title>
	<link rel="apple-touch-icon" sizes="144x144" href="<c:url value='/resources/assets/images/hygino_icon.png?ver=1'/>">
	<%-- <link rel="shortcut icon" href="<c:url value='/resources/assets/images/hygino_icon.png?ver=1'/>"> --%>
	<%-- <link rel="shortcut icon" sizes="239x232" href="<c:url value='/resources/assets/images/hygino_icon.png?ver=1'/>" type="image/png"> --%>
	<%-- <link rel="shortcut icon" sizes="239x232" href="<c:url value='/resources/assets/images/hygino_icon_239x232.ico?ver=1'/>" type="image/x-icon">  --%>
	<link rel="shortcut icon" href="<c:url value='/resources/assets/images/hygino_icon32.ico?ver=1'/>" type="image/x-icon">
	<!-- bootstrap -->
	<link rel="stylesheet" href="<c:url value='/resources/assets/vendor/bootstrap/css/bootstrap-5.2.0.min.css?ver=2.1'/>"> <!-- bootstrap 5.2.0 -->
	
	<!-- jquery dataTables -->
	<link rel="stylesheet" href="<c:url value='/resources/assets/vendor/dataTables/datatables.css?ver=1.2'/>"> <!-- core -->
	
	<link rel="stylesheet" href="<c:url value='/resources/assets/vendor/fontawesome/css/all.min.css?ver=1'/>"> <!-- fontawesome -->
	<link rel="stylesheet" href="<c:url value='/resources/assets/vendor/toastr/css/toastr.min.css?ver=1.4'/>"> <!-- toastr 2.1.4 -->
	<link rel="stylesheet" href="<c:url value='/resources/assets/vendor/jstree/dist/themes/default/style.min.css?ver=1.1'/>"> <!-- jstree 3.3.12 -->
	<link rel="stylesheet" href="<c:url value='/resources/assets/vendor/bootstrap-toggle/bootstrap-toggle.min.css?ver=1.2'/>"> <!-- bootstrap toggle -->
	<link rel="stylesheet" href="<c:url value='/resources/assets/vendor/select2/dist/css/select2.min.css?ver=1.0'/>"> <!-- select2 4.0.13 -->
	<link rel="stylesheet" href="<c:url value='/resources/assets/vendor/select2-bootstrap-5-theme/dist/select2-bootstrap-5-theme.css?ver=1.0'/>"> <!-- select2 bootstart5 theme 1.3.0 -->
	<link rel="stylesheet" href="<c:url value='/resources/assets/vendor/virtualKeyboard/JS_virtualKeyboard.css?ver=1.1'/>"><!-- virtualKeyboard -->
	
	<link rel="stylesheet" href="<c:url value='/resources/assets/vendor/jquery-ui/jquery-ui.min.css?ver=1.12.0'/>"> <!-- jquery UI -->
	
	
	
	<link rel="stylesheet" href="<c:url value='/resources/dist/css/custom_style.css?ver=2.0'/>"> <!-- custom style -->
	<style>
		.nonScrollTable::-webkit-scrollbar {
			display: none; /* Chrome, Safari, Opera*/
		}
		#my-spinner {
			width: 100%; height: 100%;
			top: 0; left: 0;
			display: none;
			opacity: .3;
			background: #000000;
			position: fixed;
			z-index: 9999;
		}

		#my-spinner div {
			width: 100%; height: 100%;
			display: table;
		}

		#my-spinner span {
			display: table-cell;
			text-align: center;
			vertical-align: middle;
		}

		#my-spinner img {
			background: transparent;
			padding: 1em;
			border-radius: .7em;      
		}

		@media print {
			body {
				-webkit-print-color-adjust: exact !important;
			}
			div.print_footer_left {
		    	position: fixed;
		    	bottom: 0;
		    	left: 0;
		    }
		    div.print_footer_center {
		    	position: fixed;
		    	bottom: 0;
		    	left: 50%;
	    		transform: translate(-50%, 0);
		    }
		    div.print_footer_right {
		    	position: fixed;
		    	bottom: 0;
		    	right: 0;
		    }
		}

		.endline {
			page-break-before:always
		}

		@keyframes blink-effect { 50% { background-color: #ffffff; color: #000000; } }
	</style>
</head>
<body>