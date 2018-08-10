/*
 * ==========================================================================================
 * =                            JAHIA'S ENTERPRISE DISTRIBUTION                             =
 * ==========================================================================================
 *
 *                                  http://www.jahia.com
 *
 * JAHIA'S ENTERPRISE DISTRIBUTIONS LICENSING - IMPORTANT INFORMATION
 * ==========================================================================================
 *
 *     Copyright (C) 2002-2018 Jahia Solutions Group. All rights reserved.
 *
 *     This file is part of a Jahia's Enterprise Distribution.
 *
 *     Jahia's Enterprise Distributions must be used in accordance with the terms
 *     contained in the Jahia Solutions Group Terms &amp; Conditions as well as
 *     the Jahia Sustainable Enterprise License (JSEL).
 *
 *     For questions regarding licensing, support, production usage...
 *     please contact our team at sales@jahia.com or go to http://www.jahia.com/license.
 *
 * ==========================================================================================
 */
package org.jahia.modules.car.actions;

import org.jahia.bin.Action;
import org.jahia.bin.ActionResult;
import org.jahia.bin.Render;
import org.jahia.services.content.JCRCallback;
import org.jahia.services.content.JCRNodeWrapper;
import org.jahia.services.content.JCRSessionWrapper;
import org.jahia.services.content.JCRTemplate;
import org.jahia.services.content.rules.BackgroundAction;
import org.jahia.services.mail.MailService;
import org.jahia.services.render.RenderContext;
import org.jahia.services.render.Resource;
import org.jahia.services.render.URLResolver;
import org.json.JSONException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.jcr.RepositoryException;
import javax.script.ScriptException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Short description of the class
 *
 * @author obelhadi
 */
public class CarBooking extends Action implements BackgroundAction {

    private static final Logger log = LoggerFactory.getLogger(CarBooking.class);

    private JCRTemplate jcrTemplate;

    private MailService mailService;

    public void setJcrTemplate(JCRTemplate jcrTemplate) {
        this.jcrTemplate = jcrTemplate;
    }

    public void setMailService(MailService mailService) {
        this.mailService = mailService;
    }

    @Override
    public ActionResult doExecute(HttpServletRequest httpServletRequest, RenderContext renderContext,final  Resource resource,
            JCRSessionWrapper jcrSessionWrapper, final Map<String, List<String>> parameters, URLResolver urlResolver) throws Exception {
        return (ActionResult) jcrTemplate.doExecuteWithSystemSession(null, jcrSessionWrapper.getWorkspace().getName(), jcrSessionWrapper.getLocale(),
                new JCRCallback<Object>() {
            @Override public Object doInJCR(JCRSessionWrapper jcrSessionWrapper) throws RepositoryException {
                JCRNodeWrapper node = jcrSessionWrapper.getNodeByUUID(resource.getNode().getIdentifier());

//                if(!node.hasNode("bookings")) {
//                    node.addNode("bookings", "mynt:booking");
//                    log.info("### booking node added");
//                }

                String UUID= org.apache.commons.id.uuid.UUID.randomUUID().toString();
                log.info("### trying to add new child");
                JCRNodeWrapper newNode = node.addNode(UUID,"mynt:booking");
                log.info("### after adding new child");

                String email = parameters.get("email") != null ? parameters.get("email").get(0) : "";
                String comment = parameters.get("comment") != null ? parameters.get("comment").get(0) : "";
                String date = parameters.get("date") != null ? parameters.get("date").get(0) : "";

                newNode.setProperty("email", email);
                newNode.setProperty("comment", comment);

                DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
                Calendar cal  = Calendar.getInstance();
                if (date !=null) {
                    try {
                        cal.setTime(df.parse(date));
                        newNode.setProperty("date", cal);
                    } catch (ParseException e) {
                        e.printStackTrace();
                    }
                }
                newNode.saveSession();
//                node.saveSession();
//                jcrSessionWrapper.save();
                try {
                    return new ActionResult(HttpServletResponse.SC_OK, node.getPath(),
                            Render.serializeNodeToJSON(node));
                } catch (IOException e) {
                    e.printStackTrace(); //To change body of catch statement use File | Settings | File Templates.
                } catch (JSONException e) {
                    e.printStackTrace(); //To change body of catch statement use File | Settings | File Templates.
                }
                return null;
            }
        });
    }

    @Override public void executeBackgroundAction(JCRNodeWrapper node) {
        try {
            String email = node.getProperty("email").getValue().getString();
            Calendar date = node.getProperty("date").getValue().getDate();

            String maker = node.getParent().getPropertyAsString("maker");
            String model = node.getParent().getPropertyAsString("model");
            Map<String, Object> binding = new HashMap<>();
            DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
            String formattedDate = dateFormat.format(date.getTime());
            binding.put("email", email);
            binding.put("date", formattedDate);
            binding.put("carMaker", maker);
            binding.put("carModel", model);
            Locale locale = node.getSession().getLocale();
            log.info("### Emailing "+ email + " for a booking on " + formattedDate);
            try {
                mailService.sendMessageWithTemplate("/mails/templates/carTestBooking.vm", binding, email, "Jahia@jahia.com", null, null,
                        locale, "Car Dealer Module");
            } catch (ScriptException e) {
                e.printStackTrace();
            }
        } catch (RepositoryException e) {
            e.printStackTrace();
        }

    }
}
