<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="ui" uri="http://www.jahia.org/tags/uiComponentsLib" %>
<%@ taglib prefix="functions" uri="http://www.jahia.org/tags/functions" %>
<%@ taglib prefix="query" uri="http://www.jahia.org/tags/queryLib" %>
<%@ taglib prefix="utility" uri="http://www.jahia.org/tags/utilityLib" %>
<%@ taglib prefix="s" uri="http://www.jahia.org/tags/search" %>
<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>
<%--@elvariable id="out" type="java.io.PrintWriter"--%>
<%--@elvariable id="script" type="org.jahia.services.render.scripting.Script"--%>
<%--@elvariable id="scriptInfo" type="java.lang.String"--%>
<%--@elvariable id="workspace" type="java.lang.String"--%>
<%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>
<%--@elvariable id="currentResource" type="org.jahia.services.render.Resource"--%>
<%--@elvariable id="url" type="org.jahia.services.render.URLGenerator"--%>


<template:include view="hidden.base"/>


<c:set var="photos" value="${currentNode.properties['photos']}"/>
<c:forEach items="${photos}" var="photo">
    <c:if test="${not empty photo.node.url}">
        <c:url value="${photo.node.url}" var="photoUrl"/>
        <div style="margin: 10px"><img src="${photoUrl}" alt="N/A"/></div>
    </c:if>
</c:forEach>


<div><fmt:message key="mynt_car.kms"/> : <b>${currentNode.properties['kms'].string}</b></div>

<div><fmt:message key="mynt_car.body"/> <b>${currentNode.properties['body'].string}</b></div>

<div><fmt:message key="mynt_car.price"/> <b>${currentNode.properties['price'].string}</b></div>

<div><fmt:message key="mynt_car.exterior"/> : <b>${currentNode.properties['exterior'].string}</b></div>

<div><fmt:message key="mynt_car.interior"/> : <b>${currentNode.properties['interior'].string}</b></div>

<div><fmt:message key="mynt_car.engine"/> : <b>${currentNode.properties['engine'].string}</b></div>

<div><fmt:message key="mynt_car.energy"/> : <b> <fmt:message key="mynt_car.energy.${currentNode.properties['energy'].string}"/></b></div>

<div><fmt:message key="mynt_car.doors"/> : <b>${currentNode.properties['doors'].string}</b></div>

<div><fmt:message key="mynt_car.transmission"/> : <b>${currentNode.properties['transmission'].string}</b></div>

<br/>
<h4>Book a Test</h4>
<form action="<c:url value='${url.base}${currentNode.path}'/>.carBooking.do"
      id="car-booking-${currentNode.identifier}">
    <input type="hidden" name="jcrMethodToCall" value="post"/>
    Date : <input type="date" name="date"/><br/>
    Email: <input type="email" name="email"/><br/>
    Comment: <textarea name="comment"></textarea><br/>
    <input type="submit" value="Submit"><br/>
</form>
<div><b>Booking List </b></div>
<div>
    <c:set var="bookings" value="${jcr:getChildrenOfType(currentNode, 'mynt:booking')}"/>
    <%--${fn:length(bookings)}--%>
    <c:forEach items="${bookings}" var="booking">
        <div>
                ${booking.properties.email.string} /
            <fmt:formatDate value="${booking.properties.date.time}" pattern="dd/MM/yyyy"/> /
                ${booking.properties.comment.string}
        </div>
    </c:forEach>
</div>
