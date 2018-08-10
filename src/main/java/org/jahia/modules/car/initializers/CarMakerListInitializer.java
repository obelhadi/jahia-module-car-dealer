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
package org.jahia.modules.car.initializers;

import org.jahia.services.content.nodetypes.ExtendedPropertyDefinition;
import org.jahia.services.content.nodetypes.initializers.ChoiceListValue;
import org.jahia.services.content.nodetypes.initializers.ModuleChoiceListInitializer;

import java.util.Arrays;
import java.util.List;
import java.util.Locale;
import java.util.Map;

/**
 * Short description of the class
 *
 * @author obelhadi
 */
public class CarMakerListInitializer implements ModuleChoiceListInitializer {

    String key;

    @Override public List<ChoiceListValue> getChoiceListValues(ExtendedPropertyDefinition extendedPropertyDefinition, String s,
            List<ChoiceListValue> list, Locale locale, Map<String, Object> map) {
        return Arrays
                .asList(new ChoiceListValue("Mercedes", "Mercedes"),
                        new ChoiceListValue("BMW", "BMW"),
                        new ChoiceListValue("Audi", "Audi"),
                        new ChoiceListValue("Ferrari", "Ferrari"));
    }

    @Override public void setKey(String key) {
        this.key = key;

    }

    @Override public String getKey() {
        return this.key;
    }
}
