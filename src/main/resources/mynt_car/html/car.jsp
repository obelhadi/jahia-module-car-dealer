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


<c:url var="detailUrl" value="${url.base}${currentNode.path}.html"/>
<c:set var="photos" value="${currentNode.properties['photos']}"/>

<div  style="float:left;width:50%;">
    <c:if test="${fn:length(photos) gt 0}">
        <c:url value="${photos[0].node.url}" var="photoUrl"/>
        <span style="margin: 10px; width: 50%;"> <img src="${photoUrl}" alt="N/A"/> </span>
    </c:if>
</div>
<div style="float:right;width:45%;">
    <div>
        <h2>
            ${currentNode.properties['maker'].string} ${' '}
            ${currentNode.properties['model'].string}
        </h2>
    </div>
    <c:set var="year" value="${currentNode.properties['year']}"/>

    <c:if test="${not empty year}">
        <div>
            <h4 style="color:darkred">
                <fmt:formatDate value="${year.time}" pattern="yyyy"/>
            </h4>
        </div>
    </c:if>
    <div>
        <button type="button" class="btn btn-secondary"><a href="${detailUrl}">Details</a></button>
    </div>
</div>

<div class="clearfix"></div>










