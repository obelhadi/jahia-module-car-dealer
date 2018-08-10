<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="s" uri="http://www.jahia.org/tags/search" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>
<%--@elvariable id="out" type="java.io.PrintWriter"--%>
<%--@elvariable id="script" type="org.jahia.services.render.scripting.Script"--%>
<%--@elvariable id="scriptInfo" type="java.lang.String"--%>
<%--@elvariable id="workspace" type="java.lang.String"--%>
<%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>
<%--@elvariable id="currentResource" type="org.jahia.services.render.Resource"--%>
<%--@elvariable id="url" type="org.jahia.services.render.URLGenerator"--%>


<%--<template:addCacheDependency uuid="${currentNode.properties.result.string}"/>--%>
<c:if test="${not empty currentNode.path}">
    <c:url value="${url.base}${currentNode.parent.parent.path}.html" var="searchUrl"/>
    <s:form method="post" class="simplesearchform" action="${searchUrl}">
        <jcr:nodeProperty name="jcr:title" node="${currentNode}" var="title"/>
        <c:if test="${not empty title.string}">
            <label>${fn:escapeXml(title.string)}:&nbsp;</label>
        </c:if>
        <c:set value="Start Searching" var="startSearching"/>
        <s:term match="all_words" id="searchTerm" value="${startSearching}" searchIn="siteContent,tags,files" onfocus="if(this.value=='${startSearching}')this.value='';" onblur="if(this.value=='')this.value='${startSearching}';" class="text-input"/>
        <s:site value="${renderContext.site.name}" includeReferencesFrom="systemsite" display="false"/>
        <s:language value="${renderContext.mainResource.locale}" display="false" />
        <input class="button" type="submit"  title="Submit" value="Submit"/>

    </s:form><br class="clear"/>
</c:if>



<%--${searchUrl} === ${url.base}${jcr:getParentOfType(currentNode,'jnt:page').path}${'.html'}--%>
${renderContext.channel}

