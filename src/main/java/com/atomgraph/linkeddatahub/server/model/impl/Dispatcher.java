/**
 *  Copyright 2021 Martynas Jusevičius <martynas@atomgraph.com>
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 *
 */
package com.atomgraph.linkeddatahub.server.model.impl;

import com.atomgraph.linkeddatahub.resource.Add;
import com.atomgraph.linkeddatahub.resource.Clone;
import com.atomgraph.linkeddatahub.resource.Imports;
import com.atomgraph.linkeddatahub.resource.Namespace;
import com.atomgraph.linkeddatahub.resource.RequestAccess;
import com.atomgraph.linkeddatahub.resource.SignUp;
import com.atomgraph.linkeddatahub.resource.Skolemize;
import com.atomgraph.linkeddatahub.resource.graph.Item;
import java.util.Optional;
import javax.inject.Inject;
import javax.ws.rs.Path;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.SecurityContext;
import javax.ws.rs.core.UriInfo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 *
 * @author Martynas Jusevičius {@literal <martynas@atomgraph.com>}
 */
@Path("/")
public class Dispatcher
{
    
    private static final Logger log = LoggerFactory.getLogger(Dispatcher.class);

    private final Optional<com.atomgraph.linkeddatahub.apps.model.Application> application;
    private final UriInfo uriInfo;
    
    @Inject
    public Dispatcher(Optional<com.atomgraph.linkeddatahub.apps.model.Application> application, @Context UriInfo uriInfo, @Context SecurityContext securityContext)
    {
        this.application = application;
        this.uriInfo = uriInfo;
    }
    
    @Path("{path: .*}")
    public Object getSubResource()
    {
        if (getApplication().isEmpty())
        {
            if (log.isDebugEnabled()) log.debug("No Application matched request URI '{}', dispatching to ExternalProxyResourceBase", getUriInfo().getRequestUri());
            return ExternalProxyResourceBase.class;
        }
        
        if (getApplication().get().getService() == null)
        {
            if (log.isDebugEnabled()) log.debug("Application has no Service, returning Linked Data");
            return ProxyResourceBase.class;
        }

        return getResourceClass();
    }
    
    @Path("sparql")
    public Object getSPARQLEndpoint()
    {
        return SPARQLEndpointImpl.class;
    }

    @Path("service")
    public Object getGraphStore()
    {
        return GraphStoreImpl.class;
    }

    @Path("ns")
    public Object getOntology()
    {
        return Namespace.class;
    }

    @Path("ns/{slug}/")
    public Object getSubOntology()
    {
        return Namespace.class;
    }

    @Path("{container}/ontologies/{uuid}/")
    public Object getOntologyItem()
    {
        return com.atomgraph.linkeddatahub.resource.ontology.Item.class;
    }
    
    @Path("sign up")
    public Object getSignUp()
    {
        return SignUp.class;
    }
    
    @Path("request access")
    public Object getRequestAccess()
    {
        return RequestAccess.class;
    }

    @Path("uploads/{sha1sum}/")
    public Object getFileItem()
    {
        return com.atomgraph.linkeddatahub.resource.upload.sha1.Item.class;
    }
    
    @Path("imports")
    public Object getImportEndpoint()
    {
        return Imports.class;
    }

    @Path("add")
    public Object getAddEndpoint()
    {
        return Add.class;
    }
    
    @Path("clone")
    public Object getCloneEndpoint()
    {
        return Clone.class;
    }

    @Path("skolemize")
    public Object getSkolemizeEndpoint()
    {
        return Skolemize.class;
    }
    
    @Path("oauth2/authorize/google")
    public Object getAuthorizeGoogle()
    {
        return com.atomgraph.linkeddatahub.resource.oauth2.google.Authorize.class;
    }

    @Path("oauth2/login")
    public Object getOAuth2Login()
    {
        return com.atomgraph.linkeddatahub.resource.oauth2.Login.class;
    }
    
    public Class getResourceClass()
    {
        return Item.class;
    }
    
    public Optional<com.atomgraph.linkeddatahub.apps.model.Application> getApplication()
    {
        return application;
    }
    
    public UriInfo getUriInfo()
    {
        return uriInfo;
    }

}
