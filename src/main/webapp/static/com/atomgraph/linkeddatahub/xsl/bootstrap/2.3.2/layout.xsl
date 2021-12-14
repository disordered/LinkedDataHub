<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
    <!ENTITY lapp   "https://w3id.org/atomgraph/linkeddatahub/apps/domain#">
    <!ENTITY adm    "https://w3id.org/atomgraph/linkeddatahub/admin#">
    <!ENTITY lacl   "https://w3id.org/atomgraph/linkeddatahub/admin/acl/domain#">
    <!ENTITY lsm    "https://w3id.org/atomgraph/linkeddatahub/admin/sitemap/domain#">
    <!ENTITY def    "https://w3id.org/atomgraph/linkeddatahub/default#">
    <!ENTITY apl    "https://w3id.org/atomgraph/linkeddatahub/domain#">
    <!ENTITY aplt   "https://w3id.org/atomgraph/linkeddatahub/templates#">
    <!ENTITY google "https://w3id.org/atomgraph/linkeddatahub/services/google#">
    <!ENTITY ac     "https://w3id.org/atomgraph/client#">
    <!ENTITY a      "https://w3id.org/atomgraph/core#">
    <!ENTITY rdf    "http://www.w3.org/1999/02/22-rdf-syntax-ns#">
    <!ENTITY xhv    "http://www.w3.org/1999/xhtml/vocab#">
    <!ENTITY rdfs   "http://www.w3.org/2000/01/rdf-schema#">
    <!ENTITY xsd    "http://www.w3.org/2001/XMLSchema#">
    <!ENTITY owl    "http://www.w3.org/2002/07/owl#">
    <!ENTITY geo    "http://www.w3.org/2003/01/geo/wgs84_pos#">
    <!ENTITY http   "http://www.w3.org/2011/http#">
    <!ENTITY sc     "http://www.w3.org/2011/http-statusCodes#">
    <!ENTITY acl    "http://www.w3.org/ns/auth/acl#">
    <!ENTITY cert   "http://www.w3.org/ns/auth/cert#">
    <!ENTITY sd     "http://www.w3.org/ns/sparql-service-description#">
    <!ENTITY ldt    "https://www.w3.org/ns/ldt#">
    <!ENTITY c      "https://www.w3.org/ns/ldt/core/domain#">
    <!ENTITY ct     "https://www.w3.org/ns/ldt/core/templates#">
    <!ENTITY dh     "https://www.w3.org/ns/ldt/document-hierarchy/domain#">
    <!ENTITY dct    "http://purl.org/dc/terms/">
    <!ENTITY foaf   "http://xmlns.com/foaf/0.1/">
    <!ENTITY sioc   "http://rdfs.org/sioc/ns#">
    <!ENTITY sp     "http://spinrdf.org/sp#">
    <!ENTITY spin   "http://spinrdf.org/spin#">
    <!ENTITY spl    "http://spinrdf.org/spl#">
    <!ENTITY void   "http://rdfs.org/ns/void#">
    <!ENTITY nfo    "http://www.semanticdesktop.org/ontologies/2007/03/22/nfo#">
    <!ENTITY dydra  "https://w3id.org/atomgraph/linkeddatahub/services/dydra#">
]>
<xsl:stylesheet version="3.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:xhtml="http://www.w3.org/1999/xhtml"
xmlns:xs="http://www.w3.org/2001/XMLSchema"
xmlns:map="http://www.w3.org/2005/xpath-functions/map"
xmlns:ac="&ac;"
xmlns:a="&a;"
xmlns:lapp="&lapp;"
xmlns:lacl="&lacl;"
xmlns:apl="&apl;"
xmlns:aplt="&aplt;"
xmlns:rdf="&rdf;"
xmlns:xhv="&xhv;"
xmlns:rdfs="&rdfs;"
xmlns:owl="&owl;"
xmlns:http="&http;"
xmlns:acl="&acl;"
xmlns:cert="&cert;"
xmlns:sd="&sd;"
xmlns:ldt="&ldt;"
xmlns:core="&c;"
xmlns:dh="&dh;"
xmlns:dct="&dct;"
xmlns:foaf="&foaf;"
xmlns:sioc="&sioc;"
xmlns:spin="&spin;"
xmlns:sp="&sp;"
xmlns:spl="&spl;"
xmlns:void="&void;"
xmlns:nfo="&nfo;"
xmlns:geo="&geo;"
xmlns:google="&google;"
xmlns:bs2="http://graphity.org/xsl/bootstrap/2.3.2"
exclude-result-prefixes="#all">

    <xsl:import href="imports/xml-to-string.xsl"/>
    <xsl:import href="../../../../client/xsl/converters/RDFXML2JSON-LD.xsl"/>
    <xsl:import href="../../../../client/xsl/bootstrap/2.3.2/internal-layout.xsl"/>
    <xsl:import href="imports/default.xsl"/>
    <xsl:import href="imports/apl.xsl"/>
    <xsl:import href="imports/dct.xsl"/>
    <xsl:import href="imports/nfo.xsl"/>
    <xsl:import href="imports/rdf.xsl"/>
    <xsl:import href="imports/sioc.xsl"/>
    <xsl:import href="imports/sp.xsl"/>
    <xsl:import href="imports/void.xsl"/>
    <xsl:import href="resource.xsl"/>
    <xsl:import href="document.xsl"/>
    
    <!--  To use xsl:import-schema, you need the schema-aware version of Saxon -->
    <!-- <xsl:import-schema namespace="http://www.w3.org/1999/xhtml" schema-location="http://www.w3.org/2002/08/xhtml/xhtml1-transitional.xsd"/> -->
  
    <xsl:include href="signup.xsl"/>
    <xsl:include href="request-access.xsl"/>

    <xsl:output method="xhtml" encoding="UTF-8" indent="yes" omit-xml-declaration="yes" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" media-type="application/xhtml+xml"/>

    <xsl:param name="apl:base" as="xs:anyURI" static="yes"/>
    <xsl:param name="apl:absolutePath" as="xs:anyURI"/>
    <xsl:param name="ac:endpoint" select="resolve-uri('sparql', $ldt:base)" as="xs:anyURI"/>
    <xsl:param name="a:graphStore" select="resolve-uri('service', $ldt:base)" as="xs:anyURI"/> <!-- TO-DO: rename to ac:graphStore? -->
    <xsl:param name="lapp:Application" as="document-node()?"/>
    <xsl:param name="acl:Agent" as="document-node()?"/>
    <xsl:param name="force-exclude-all-namespaces" select="true()"/>
    <xsl:param name="ac:httpHeaders" as="xs:string"/> 
    <xsl:param name="ac:method" as="xs:string"/>
    <xsl:param name="ac:uri" as="xs:anyURI"/>
    <xsl:param name="ac:mode" as="xs:anyURI*"/> <!-- select="xs:anyURI('&ac;ReadMode')"  -->
    <xsl:param name="ac:googleMapsKey" select="'AIzaSyCQ4rt3EnNCmGTpBN0qoZM1Z_jXhUnrTpQ'" as="xs:string"/>
    <xsl:param name="acl:agent" as="xs:anyURI?"/>
    <xsl:param name="acl:mode" select="$acl:Agent[doc-available($apl:absolutePath)]//*[acl:accessToClass/@rdf:resource = (key('resources', $apl:absolutePath, document($apl:absolutePath))/rdf:type/@rdf:resource, key('resources', $apl:absolutePath, document($apl:absolutePath))/rdf:type/@rdf:resource/apl:listSuperClasses(.))]/acl:mode/@rdf:resource" as="xs:anyURI*"/>
    <xsl:param name="google:clientID" as="xs:string?"/>

    <xsl:key name="resources-by-primary-topic" match="*[@rdf:about] | *[@rdf:nodeID]" use="foaf:primaryTopic/@rdf:resource"/>
    <xsl:key name="resources-by-dataset" match="*[@rdf:about]" use="void:inDataset/@rdf:resource"/>
    <xsl:key name="resources-by-defined-by" match="*[@rdf:about]" use="rdfs:isDefinedBy/@rdf:resource"/>
    <xsl:key name="violations-by-path" match="*" use="spin:violationPath/@rdf:resource"/>
    <xsl:key name="violations-by-root" match="*" use="spin:violationRoot/@rdf:resource"/>
    <xsl:key name="violations-by-value" match="*" use="apl:violationValue/text()"/>
    <xsl:key name="resources-by-container" match="*[@rdf:about] | *[@rdf:nodeID]" use="sioc:has_parent/@rdf:resource | sioc:has_container/@rdf:resource"/>
    <xsl:key name="resources-by-expression" match="*[@rdf:nodeID]" use="sp:expression/@rdf:about | sp:expression/@rdf:nodeID"/>
    <xsl:key name="resources-by-varname" match="*[@rdf:nodeID]" use="sp:varName"/>
    <xsl:key name="resources-by-arg1" match="*[@rdf:nodeID]" use="sp:arg1/@rdf:about | sp:arg1/@rdf:nodeID"/>
    
    <rdf:Description rdf:about="">
    </rdf:Description>

    <xsl:function name="ac:uri" as="xs:anyURI">
        <xsl:sequence select="$ac:uri"/>
    </xsl:function>
    
    <!-- TITLE -->

    <xsl:template match="rdf:RDF" mode="xhtml:Title">
        <title>
            <xsl:if test="$lapp:Application">
                <xsl:value-of>
                    <xsl:apply-templates select="$lapp:Application//*[ldt:base/@rdf:resource = $ldt:base]" mode="ac:label"/>
                </xsl:value-of>
                <xsl:text> - </xsl:text>
            </xsl:if>

            <xsl:apply-templates mode="#current"/>
        </title>
    </xsl:template>

    <xsl:template match="*[rdf:type/@rdf:resource = '&http;Response'][not(key('resources', ac:uri()))]" mode="xhtml:Title" priority="1">
        <xsl:value-of>
            <xsl:apply-templates select="." mode="ac:label"/>
        </xsl:value-of>
    </xsl:template>
    
    <xsl:template match="*[@rdf:about = ac:uri()]" mode="xhtml:Title" priority="1">
        <xsl:value-of>
            <xsl:apply-templates select="." mode="ac:label"/>
        </xsl:value-of>
    </xsl:template>

    <xsl:template match="*[*][@rdf:about] | *[*][@rdf:nodeID]" mode="xhtml:Title"/>
    
    <!-- META -->
    
    <xsl:template match="rdf:RDF" mode="xhtml:Meta">
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

        <meta name="og:url" content="{ac:uri()}"/>
        <meta name="twitter:url" content="{ac:uri()}"/>

        <xsl:for-each select="key('resources', ac:uri())">
            <meta name="og:title" content="{ac:label(.)}"/>
            <meta name="twitter:title" content="{ac:label(.)}"/>

            <meta name="twitter:card" content="summary_large_image"/>

            <xsl:if test="ac:description(.)">
                <meta name="description" content="{ac:description(.)}"/>
                <meta property="og:description" content="{ac:description(.)}"/>
                <meta name="twitter:description" content="{ac:description(.)}"/>
            </xsl:if>

            <xsl:if test="ac:image(.)">
                <meta property="og:image" content="{ac:image(.)}"/>
                <meta name="twitter:image" content="{ac:image(.)}"/>
            </xsl:if>

            <xsl:for-each select="foaf:maker/@rdf:resource">
                <xsl:if test="doc-available(ac:document-uri(.))">
                    <xsl:for-each select="key('resources', ., document(ac:document-uri(.)))">
                        <meta name="author" content="{ac:label(.)}"/>
                    </xsl:for-each>
                </xsl:if>
            </xsl:for-each>
        </xsl:for-each>

        <xsl:if test="$lapp:Application//*[ldt:base/@rdf:resource = $ldt:base]">
            <meta property="og:site_name" content="{ac:label($lapp:Application//*[ldt:base/@rdf:resource = $ldt:base])}"/>
        </xsl:if>
    </xsl:template>

    <!-- STYLE -->
    
    <xsl:template match="rdf:RDF" mode="xhtml:Style">
        <xsl:param name="load-wymeditor" select="exists($acl:Agent//@rdf:about)" as="xs:boolean"/>
        <xsl:param name="load-yasqe" select="true()" as="xs:boolean"/>

        <xsl:apply-imports/>

        <link href="{resolve-uri('static/com/atomgraph/linkeddatahub/css/bootstrap.css', $ac:contextUri)}" rel="stylesheet" type="text/css"/>
        <xsl:if test="$load-wymeditor">
            <link href="{resolve-uri('static/com/atomgraph/linkeddatahub/js/wymeditor/skins/default/skin.css', $ac:contextUri)}" rel="stylesheet" type="text/css"/>
        </xsl:if>
        <xsl:if test="$load-yasqe">
            <link href="{resolve-uri('static/css/yasqe.css', $ac:contextUri)}" rel="stylesheet" type="text/css"/>
        </xsl:if>
    </xsl:template>

    <!-- SCRIPT -->

    <xsl:template match="rdf:RDF" mode="xhtml:Script">
        <xsl:param name="client-stylesheet" select="resolve-uri('static/com/atomgraph/linkeddatahub/xsl/client.xsl.sef.json', $ac:contextUri)" as="xs:anyURI"/>
        <xsl:param name="saxon-js-log-level" select="10" as="xs:integer"/>
        <xsl:param name="load-wymeditor" select="exists($acl:Agent//@rdf:about)" as="xs:boolean"/>
        <xsl:param name="load-yasqe" select="true()" as="xs:boolean"/>
        <xsl:param name="load-saxon-js" select="not($ac:mode = ('&ac;ModalMode', '&aplt;InfoWindowMode')) and not(ac:uri() = resolve-uri(concat('admin/', encode-for-uri('sign up')), $ldt:base))" as="xs:boolean"/>
        <xsl:param name="load-sparql-builder" select="not($ac:mode = ('&ac;ModalMode', '&aplt;InfoWindowMode')) and (not(key('resources-by-type', '&http;Response')) or ac:uri() = resolve-uri(concat('admin/', encode-for-uri('sign up')), $ldt:base))" as="xs:boolean"/>
        <xsl:param name="load-sparql-map" select="not($ac:mode = ('&ac;ModalMode', '&aplt;InfoWindowMode')) and (not(key('resources-by-type', '&http;Response')) or ac:uri() = resolve-uri(concat('admin/', encode-for-uri('sign up')), $ldt:base))" as="xs:boolean"/>
        <xsl:param name="load-google-charts" select="not($ac:mode = ('&ac;ModalMode', '&aplt;InfoWindowMode')) and not($ac:mode = ('&ac;ModalMode', '&aplt;InfoWindowMode')) and (not(key('resources-by-type', '&http;Response')) or ac:uri() = resolve-uri(concat('admin/', encode-for-uri('sign up')), $ldt:base))" as="xs:boolean"/>
        <xsl:param name="output-json-ld" select="false()" as="xs:boolean"/>
        <xsl:param name="service-query" as="xs:string">
            CONSTRUCT 
              { 
                ?service &lt;&dct;title&gt; ?title .
                ?service &lt;&sd;endpoint&gt; ?endpoint .
                ?service &lt;&dydra;repository&gt; ?repository .
              }
            WHERE
              { GRAPH ?g
                  { ?service  &lt;&dct;title&gt;  ?title
                      { ?service  &lt;&sd;endpoint&gt;  ?endpoint }
                    UNION
                      { ?service  &lt;&dydra;repository&gt;  ?repository }
                  }
              }
        </xsl:param>
    
        <!-- Web-Client scripts -->
        <script type="text/javascript" src="{resolve-uri('static/js/jquery.min.js', $ac:contextUri)}" defer="defer"></script>
        <script type="text/javascript" src="{resolve-uri('static/js/bootstrap.js', $ac:contextUri)}" defer="defer"></script>
        <script type="text/javascript" src="{resolve-uri('static/com/atomgraph/client/js/UUID.js', $ac:contextUri)}" defer="defer"></script>
        <!-- LinkedDataHub scripts -->
        <script type="text/javascript" src="{resolve-uri('static/com/atomgraph/linkeddatahub/js/jquery.js', $ac:contextUri)}" defer="defer"></script>
        <script type="text/javascript">
            <![CDATA[
                var baseUri = ]]><xsl:value-of select="'&quot;' || $ldt:base || '&quot;'"/><![CDATA[;
                var absolutePath = ]]><xsl:value-of select="'&quot;' || $apl:absolutePath || '&quot;'"/><![CDATA[;
                var ontologyUri = ]]><xsl:value-of select="'&quot;' || $ldt:ontology || '&quot;'"/><![CDATA[;
                var contextUri = ]]><xsl:value-of select="if ($ac:contextUri) then '&quot;' || $ac:contextUri || '&quot;'  else 'null'"/><![CDATA[;
                var agentUri = ]]><xsl:value-of select="if ($acl:agent) then '&quot;' || $acl:agent || '&quot;'  else 'null'"/><![CDATA[;
                var accessModeUri = []]><xsl:value-of select="string-join(for $mode in $acl:mode return '&quot;' || $mode || '&quot;', ', ')"/><![CDATA[];
            ]]>
        </script>
        <xsl:if test="$load-wymeditor">
            <script type="text/javascript" src="{resolve-uri('static/com/atomgraph/linkeddatahub/js/wymeditor/jquery.wymeditor.js', $ac:contextUri)}" defer="defer"></script>
        </xsl:if>
        <xsl:if test="$load-yasqe">
            <script src="{resolve-uri('static/js/yasqe.js', $ac:contextUri)}" type="text/javascript"></script>
        </xsl:if>
        <xsl:if test="$load-saxon-js">
            <xsl:variable name="services-request-uri" select="ac:build-uri($ac:endpoint, map{ 'query': $service-query })" as="xs:anyURI"/>
            <script type="text/javascript" src="{resolve-uri('static/com/atomgraph/linkeddatahub/js/saxon-js/SaxonJS2.rt.js', $ac:contextUri)}" defer="defer"></script>
            <script type="text/javascript">
                <![CDATA[
                    window.onload = function() {
                        const locationMapping = [ 
                            // not using entities as we don't want the # in the end
                            { name: contextUri + "static/com/atomgraph/linkeddatahub/xsl/bootstrap/2.3.2/translations.rdf", altName: contextUri + "static/com/atomgraph/linkeddatahub/xsl/bootstrap/2.3.2/translations.rdf" },
                            { name: "https://w3id.org/atomgraph/client", altName: "]]><xsl:value-of select="$ldt:base"/><![CDATA[" + "?uri=" + encodeURIComponent("https://w3id.org/atomgraph/client") + "&accept=" + encodeURIComponent("application/rdf+xml") },
                            { name: "https://w3id.org/atomgraph/linkeddatahub/admin", altName: "]]><xsl:value-of select="$ldt:base"/><![CDATA[" + "?uri=" + encodeURIComponent("https://w3id.org/atomgraph/linkeddatahub/admin") + "&accept=" + encodeURIComponent("application/rdf+xml") },
                            { name: "https://w3id.org/atomgraph/linkeddatahub/domain", altName: "]]><xsl:value-of select="$ldt:base"/><![CDATA[" + "?uri=" + encodeURIComponent("https://w3id.org/atomgraph/linkeddatahub/domain") + "&accept=" + encodeURIComponent("application/rdf+xml") },
                            { name: "https://w3id.org/atomgraph/linkeddatahub/default", altName: "]]><xsl:value-of select="$ldt:base"/><![CDATA[" + "?uri=" + encodeURIComponent("https://w3id.org/atomgraph/linkeddatahub/default") + "&accept=" + encodeURIComponent("application/rdf+xml") },
                            { name: "http://spinrdf.org/sp", altName: "]]><xsl:value-of select="$ldt:base"/><![CDATA[" + "?uri=" + encodeURIComponent("http://spinrdf.org/sp") + "&accept=" + encodeURIComponent("application/rdf+xml") },
                            { name: "http://www.w3.org/1999/02/22-rdf-syntax-ns", altName: "]]><xsl:value-of select="$ldt:base"/><![CDATA[" + "?uri=" + encodeURIComponent("http://www.w3.org/1999/02/22-rdf-syntax-ns") + "&accept=" + encodeURIComponent("application/rdf+xml") }
                            ]]>
                            <!--<xsl:variable name="ontology-imports" select="for $value in distinct-values(apl:ontologyImports($ldt:ontology)) return xs:anyURI($value)" as="xs:anyURI*"/>
                            <xsl:if test="exists($ontology-imports)">
                                <xsl:text>,</xsl:text>
                                <xsl:for-each select="$ontology-imports">
                                    <xsl:text>{ name: "</xsl:text>
                                    <xsl:value-of select="ac:document-uri(.)"/>
                                    <xsl:text>", altName: baseUri + "?uri=" + encodeURIComponent("</xsl:text>
                                    <xsl:value-of select="ac:document-uri(.)"/>
                                    <xsl:text>") + "&amp;accept=" + encodeURIComponent("application/rdf+xml") }</xsl:text>
                                    <xsl:if test="position() != last()">
                                        <xsl:text>,&#xa;</xsl:text>
                                    </xsl:if>
                                </xsl:for-each>
                            </xsl:if> -->
                            <![CDATA[
                        ];
                        const docPromises = locationMapping.map(mapping => SaxonJS.getResource({location: mapping.altName, type: "xml"}));
                        const servicesRequestUri = "]]><xsl:value-of select="$services-request-uri"/><![CDATA[";
                        const stylesheetParams = {
                            "Q{https://w3id.org/atomgraph/client#}contextUri": contextUri, // servlet context URI
                            "Q{https://www.w3.org/ns/ldt#}base": baseUri,
                            "Q{https://www.w3.org/ns/ldt#}ontology": ontologyUri,
                            "Q{https://w3id.org/atomgraph/linkeddatahub/domain#}absolutePath": absolutePath,
                            "Q{http://www.w3.org/ns/auth/acl#}agent": agentUri,
                            "Q{http://www.w3.org/ns/auth/acl#}mode": accessModeUri,
                            "Q{}services-request-uri": servicesRequestUri
                            };
                        
                        SaxonJS.getResource({location: servicesRequestUri, type: "xml", headers: { "Accept": "application/rdf+xml" } }).
                            then(resource => {
                                stylesheetParams["Q{https://w3id.org/atomgraph/linkeddatahub/domain#}services"] = resource;
                                return Promise.all(docPromises);
                            }, error => {
                                return Promise.all(docPromises);
                            }).
                            then(resources => {
                                const cache = {};
                                for (var i = 0; i < resources.length; i++) {
                                    cache[locationMapping[i].name] = resources[i]
                                };
                                return SaxonJS.transform({
                                    documentPool: cache,
                                    stylesheetLocation: "]]><xsl:value-of select="$client-stylesheet"/><![CDATA[",
                                    initialTemplate: "main",
                                    logLevel: ]]><xsl:value-of select="$saxon-js-log-level"/><![CDATA[,
                                    stylesheetParams: stylesheetParams
                                }, "async");
                            }).
                            catch(err => console.log("Transformation failed: " + err));
                    }
                ]]>
            </script>
        </xsl:if>
        <xsl:if test="$load-sparql-builder">
            <script type="text/javascript" src="{resolve-uri('static/com/atomgraph/linkeddatahub/js/SPARQLBuilder.js', $ac:contextUri)}" defer="defer"></script>
        </xsl:if>
        <xsl:if test="$load-sparql-map">
            <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key={$ac:googleMapsKey}" defer="defer"></script>
            <script type="text/javascript" src="{resolve-uri('static/com/atomgraph/linkeddatahub/js/SPARQLMap.js', $ac:contextUri)}" defer="defer"></script>
        </xsl:if>
        <xsl:if test="$load-google-charts">
            <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
            <script type="text/javascript">
                <![CDATA[
                    google.charts.load('current', {packages: ['corechart', 'table', 'timeline', 'map']});
                ]]>
            </script>
        </xsl:if>
        <xsl:if test="$output-json-ld">
            <!-- output structured data: https://developers.google.com/search/docs/guides/intro-structured-data -->
            <script type="application/ld+json">
                <xsl:apply-templates select="." mode="ac:JSON-LD"/>
            </script>
        </xsl:if>
    </xsl:template>
    
    <!-- NAVBAR -->
    
    <xsl:template match="rdf:RDF" mode="bs2:NavBar">
        <div class="navbar navbar-fixed-top">
            <div class="navbar-inner">
                <div class="container-fluid">
                    <button class="btn btn-navbar">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>

                    <xsl:if test="$ldt:base">
                        <xsl:if test="not($ldt:base = $ac:contextUri)">
                            <a class="brand context" href="{resolve-uri('..', $ldt:base)}"/>
                        </xsl:if>
                    </xsl:if>
                        
                    <xsl:apply-templates select="." mode="bs2:Brand"/>

                    <div id="collapsing-top-navbar" class="nav-collapse collapse" style="margin-left: 17%;">
                        <xsl:apply-templates select="." mode="bs2:SearchBar"/>

                        <xsl:apply-templates select="." mode="bs2:NavBarNavList"/>
                    </div>
                </div>
            </div>

            <xsl:apply-templates select="." mode="bs2:ActionBar"/>
        </div>
    </xsl:template>

    <xsl:template match="rdf:RDF" mode="bs2:Brand">
        <a class="brand" href="{$ldt:base}">
            <xsl:if test="$lapp:Application//*[ldt:base/@rdf:resource = $ldt:base]/rdf:type/@rdf:resource = '&lapp;AdminApplication'">
                <xsl:attribute name="class" select="'brand admin'"/>
            </xsl:if>

            <xsl:value-of>
                <xsl:apply-templates select="$lapp:Application//*[ldt:base/@rdf:resource = $ldt:base]" mode="ac:label"/>
            </xsl:value-of>
        </a>
    </xsl:template>
    
    <!-- check if agent has access to the user endpoint by executing a dummy query ASK {} -->
    <xsl:template match="rdf:RDF[doc-available(resolve-uri('sparql?query=ASK%20%7B%7D', $ldt:base))]" mode="bs2:SearchBar" priority="1">
        <form action="" method="get" class="navbar-form pull-left" accept-charset="UTF-8" title="{ac:label(key('resources', 'search-title', document('translations.rdf')))}">
            <div class="input-append">
                <select id="search-service" name="service">
                    <option value="">[SPARQL service]</option>
                </select>
                
                <input type="text" id="uri" name="uri" class="input-xxlarge typeahead">
                    <xsl:if test="not(starts-with(ac:uri(), $ldt:base))">
                        <xsl:attribute name="value">
                            <xsl:value-of select="ac:uri()"/>
                        </xsl:attribute>
                    </xsl:if>
                </input>

                <button type="submit">
                    <xsl:apply-templates select="key('resources', 'search', document('translations.rdf'))" mode="apl:logo">
                        <xsl:with-param name="class" select="'btn btn-primary'"/>
                    </xsl:apply-templates>
                </button>
            </div>
        </form>
    </xsl:template>
    
    <xsl:template match="*" mode="bs2:SearchBar"/>

    <xsl:template match="rdf:RDF" mode="bs2:ActionBarLeft">
        <xsl:param name="id" as="xs:string?"/>
        <xsl:param name="class" select="'span2'" as="xs:string?"/>
        <xsl:param name="classes" select="document(ac:document-uri($ldt:ontology))/rdf:RDF/*[@rdf:about][rdfs:isDefinedBy/@rdf:resource = $ldt:ontology][spin:constructor or (rdfs:subClassOf and apl:listSuperClasses(@rdf:about)/../../spin:constructor)]" as="element()*"/>
        
        <div>
            <xsl:if test="$id">
                <xsl:attribute name="id"><xsl:sequence select="$id"/></xsl:attribute>
            </xsl:if>
            <xsl:if test="$class">
                <xsl:attribute name="class"><xsl:sequence select="$class"/></xsl:attribute>
            </xsl:if>
            
            <xsl:apply-templates select="." mode="bs2:Create">
                <xsl:with-param name="class" select="'btn-group pull-left'"/>
                <xsl:with-param name="classes" select="$classes"/>
            </xsl:apply-templates>
            
            <xsl:apply-templates select="." mode="bs2:AddData"/>
        </div>
    </xsl:template>
    
    <xsl:template match="rdf:RDF" mode="bs2:ActionBarMain">
        <xsl:param name="id" as="xs:string?"/>
        <xsl:param name="class" select="'span7'" as="xs:string?"/>

        <div>
            <xsl:if test="$id">
                <xsl:attribute name="id"><xsl:value-of select="$id"/></xsl:attribute>
            </xsl:if>
            <xsl:if test="$class">
                <xsl:attribute name="class"><xsl:value-of select="$class"/></xsl:attribute>
            </xsl:if>
            
            <div id="result-counts">
                <!-- placeholder for client.xsl callbacks -->
            </div>

            <div id="breadcrumb-nav">
                <!-- placeholder for client.xsl callbacks -->
            </div>
        </div>
    </xsl:template>
    
    <xsl:template match="rdf:RDF" mode="bs2:ActionBarRight">
        <xsl:param name="id" as="xs:string?"/>
        <xsl:param name="class" select="'span3'" as="xs:string?"/>

        <div>
            <xsl:if test="$id">
                <xsl:attribute name="id"><xsl:value-of select="$id"/></xsl:attribute>
            </xsl:if>
            <xsl:if test="$class">
                <xsl:attribute name="class"><xsl:value-of select="$class"/></xsl:attribute>
            </xsl:if>
            
            <xsl:apply-templates select="." mode="bs2:MediaTypeList"/>

            <xsl:apply-templates select="." mode="bs2:NavBarActions"/>
        </div>
    </xsl:template>
    
    <xsl:template match="rdf:RDF" mode="bs2:NavBarNavList">
        <xsl:if test="$acl:Agent//@rdf:about">
            <ul class="nav pull-right">
                <li>
                    <xsl:if test="$ac:mode = '&ac;QueryEditorMode'">
                        <xsl:attribute name="class" select="'active'"/>
                    </xsl:if>

                    <a href="{ac:build-uri((), map{ 'mode': '&ac;QueryEditorMode' })}" class="query-editor">SPARQL editor</a>
                </li>
                <li>
                    <xsl:apply-templates select="." mode="bs2:Settings"/>
                </li>
                <!-- overridden in acl/layout.xsl! TO-DO: extract into separate template -->
                <li>
                    <div class="btn-group">
                        <button type="button" title="{ac:label($acl:Agent//*[@rdf:about][1])}">
                            <xsl:apply-templates select="key('resources', '&foaf;Agent', document(ac:document-uri('&foaf;')))" mode="apl:logo">
                                <xsl:with-param name="class" select="'btn dropdown-toggle'"/>
                            </xsl:apply-templates>
                        </button>
                        <ul class="dropdown-menu pull-right">
                            <li>
                                <xsl:for-each select="key('resources-by-type', '&lacl;Agent', $acl:Agent)">
                                    <xsl:apply-templates select="." mode="xhtml:Anchor"/>
                                </xsl:for-each>
                            </li>
                        </ul>
                    </div>
                </li>
            </ul>
        </xsl:if>

        <xsl:apply-templates select="." mode="bs2:SignUp"/>
    </xsl:template>

    <xsl:template match="rdf:RDF[not($acl:Agent//@rdf:about)][$lapp:Application//rdf:type/@rdf:resource = '&lapp;EndUserApplication']" mode="bs2:SignUp" priority="1">
        <xsl:param name="uri" select="ac:build-uri(resolve-uri(encode-for-uri('sign up'), $lapp:Application//*[rdf:type/@rdf:resource = '&lapp;AdminApplication']/ldt:base/@rdf:resource), map{ 'forClass': string('&adm;Person') })" as="xs:anyURI"/>
        <xsl:param name="google-signup" select="exists($google:clientID)" as="xs:boolean"/>
        <xsl:param name="webid-signup" select="true()" as="xs:boolean"/>
        
        <xsl:if test="$google-signup or $webid-signup">
            <p class="pull-right">
                <xsl:if test="$google-signup">
                    <a class="btn btn-primary" href="{ac:build-uri(resolve-uri('oauth2/authorize/google', $lapp:Application//*[rdf:type/@rdf:resource = '&lapp;AdminApplication']/ldt:base/@rdf:resource), map{ 'referer': string(ac:uri()) })}">
                        <xsl:value-of>
                            <xsl:apply-templates select="key('resources', 'login-google', document('translations.rdf'))" mode="ac:label"/>
                        </xsl:value-of>
                    </a>
                </xsl:if>
                <xsl:if test="$webid-signup">
                    <a class="btn btn-primary" href="{if (not(starts-with($ldt:base, $apl:base))) then ac:build-uri((), map{ 'uri': string($uri) }) else $uri}">
                        <xsl:value-of>
                            <xsl:apply-templates select="key('resources', 'sign-up', document('translations.rdf'))" mode="ac:label"/>
                        </xsl:value-of>
                    </a>
                </xsl:if>
            </p>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="rdf:RDF" mode="bs2:SignUp"/>
    
    <xsl:template match="*[ldt:base/@rdf:resource]" mode="bs2:AppListItem">
        <xsl:param name="active" as="xs:boolean?"/>
        
        <li>
            <xsl:if test="$active">
                <xsl:attribute name="class">active</xsl:attribute>
            </xsl:if>

            <a href="{ldt:base/@rdf:resource[starts-with(., $ac:contextUri)]}" title="{ldt:base/@rdf:resource[starts-with(., $ac:contextUri)]}">
                <xsl:value-of>
                    <xsl:apply-templates select="." mode="ac:label"/>
                </xsl:value-of>
            </a>
        </li>
    </xsl:template>
    
    <!-- BODY -->

    <!-- show only form when ac:ModalMode combined with ac:forClass (used by client.xsl) -->
    <xsl:template match="rdf:RDF[$ac:forClass]" mode="xhtml:Body" priority="1">
        <xsl:param name="modal" select="$ac:mode = '&ac;ModalMode'" as="xs:boolean" tunnel="yes"/>
        <xsl:param name="action" select="ac:build-uri($a:graphStore, let $params := map{ 'forClass': string($ac:forClass) } return if ($modal) then map:merge(($params, map{ 'mode': '&ac;ModalMode' })) else $params)" as="xs:anyURI"/>
        <xsl:param name="constructor" as="document-node()">
            <xsl:choose>
                <!-- if $ac:forClass is not a document class or content, then pair the instance with a document instance -->
                <xsl:when test="not($ac:forClass = ('&def;Container', '&def;Item', '&apl;Content'))">
                    <xsl:document>
                        <xsl:for-each select="ac:construct($ldt:ontology, ($ac:forClass, xs:anyURI('&def;Item')), $ldt:base)">
                            <xsl:apply-templates select="." mode="apl:SetPrimaryTopic">
                                <!-- avoid selecting object blank nodes which only have rdf:type -->
                                <xsl:with-param name="topic-id" select="key('resources-by-type', $ac:forClass)[* except rdf:type]/@rdf:nodeID" tunnel="yes"/>
                                <xsl:with-param name="doc-id" select="key('resources-by-type', '&def;Item')/@rdf:nodeID" tunnel="yes"/>
                            </xsl:apply-templates>
                        </xsl:for-each>
                    </xsl:document>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:copy-of select="ac:construct($ldt:ontology, $ac:forClass, $ldt:base)"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        <xsl:param name="classes" select="document(ac:document-uri($ldt:ontology))/rdf:RDF/*[@rdf:about][rdfs:isDefinedBy/@rdf:resource = $ldt:ontology][spin:constructor or (rdfs:subClassOf and apl:listSuperClasses(@rdf:about)/../../spin:constructor)]" as="element()*"/>
        <xsl:param name="default-classes" select="(key('resources-by-type', '&rdfs;Class', document(ac:document-uri('&def;')))[not(@rdf:about = ('&def;Root', '&def;Container', '&def;Item'))])" as="element()*"/>

        <body>
            <xsl:choose>
                <xsl:when test="$ac:method = 'GET'">
                    <xsl:choose>
                        <xsl:when test="$ac:mode = '&ac;ModalMode'">
                            <xsl:apply-templates select="$constructor" mode="bs2:ModalForm">
                                <xsl:with-param name="action" select="$action"/>
                            </xsl:apply-templates>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:apply-templates select="$constructor" mode="bs2:Form">
                                <xsl:with-param name="action" select="$action"/>
                                <xsl:with-param name="classes" select="$classes"/>
                                <xsl:with-param name="default-classes" select="$default-classes"/>
                            </xsl:apply-templates>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:when test="$ac:method = 'POST' and key('resources-by-type', '&spin;ConstraintViolation')">
                    <xsl:choose>
                        <xsl:when test="$ac:mode = '&ac;ModalMode'">
                            <xsl:apply-templates select="." mode="bs2:ModalForm">
                                <xsl:with-param name="action" select="$action"/>
                            </xsl:apply-templates>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:apply-templates select="." mode="bs2:Form">
                                <xsl:with-param name="action" select="$action"/>
                                <xsl:with-param name="classes" select="$classes"/>
                                <xsl:with-param name="default-classes" select="$default-classes"/>
                            </xsl:apply-templates>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:next-match/>
                </xsl:otherwise>
            </xsl:choose>
        </body>
    </xsl:template>

    <!-- show only form when ac:ModalMode combined with ac:Edit (used by client.xsl) -->
    <xsl:template match="rdf:RDF[$ac:mode = '&ac;EditMode']" mode="xhtml:Body" priority="1">
        <xsl:param name="action" select="if (empty($ldt:base)) then ac:build-uri($ac:contextUri, map{ 'uri': string(ac:uri()), '_method': 'PUT', 'mode': for $mode in $ac:mode return string($mode) }) else ac:build-uri(ac:uri(), map{ '_method': 'PUT', 'mode': for $mode in $ac:mode return string($mode) })" as="xs:anyURI"/>
        <xsl:param name="classes" select="document(ac:document-uri($ldt:ontology))/rdf:RDF/*[@rdf:about][rdfs:isDefinedBy/@rdf:resource = $ldt:ontology][spin:constructor or (rdfs:subClassOf and apl:listSuperClasses(@rdf:about)/../../spin:constructor)]" as="element()*"/>
        <xsl:param name="default-classes" select="(key('resources', '&apl;Content', document(ac:document-uri('&apl;'))), key('resources-by-type', '&rdfs;Class', document(ac:document-uri('&def;')))[not(@rdf:about = ('&def;Root', '&def;Container', '&def;Item'))])" as="element()*"/>

        <body>
            <xsl:choose>
                <xsl:when test="$ac:mode = '&ac;ModalMode'">
                    <xsl:apply-templates select="." mode="bs2:ModalForm">
                        <xsl:with-param name="action" select="$action"/>
                    </xsl:apply-templates>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates select="." mode="bs2:Form">
                        <xsl:with-param name="action" select="$action"/>
                        <xsl:with-param name="classes" select="$classes"/>
                        <xsl:with-param name="default-classes" select="$default-classes"/>
                    </xsl:apply-templates>
                </xsl:otherwise>
            </xsl:choose>
        </body>
    </xsl:template>

    <xsl:template match="rdf:RDF[key('resources', ac:uri())][$ac:mode = '&aplt;InfoWindowMode']" mode="xhtml:Body" priority="1">
        <body>
            <div> <!-- SPARQLMap renders the first child of <body> as InfoWindow -->
                <xsl:apply-templates select="." mode="bs2:Block">
                    <xsl:with-param name="display" select="true()" tunnel="yes"/>
                </xsl:apply-templates>
            </div>
        </body>
    </xsl:template>

    <xsl:template match="rdf:RDF[key('resources', ac:uri())][$ac:mode = '&aplt;ObjectMode']" mode="xhtml:Body" priority="2">
        <body class="embed">
            <div>
                <xsl:apply-templates select="." mode="bs2:Object">
                    <xsl:with-param name="show-controls" select="false()" tunnel="yes"/>
                </xsl:apply-templates>
            </div>
        </body>
    </xsl:template>

    <xsl:template match="rdf:RDF" mode="xhtml:Body">
        <body>
            <xsl:apply-templates select="." mode="bs2:NavBar"/>

            <div id="content-body" class="container-fluid">
                <xsl:apply-templates select="." mode="bs2:ModeTabs"/>
            
                <xsl:variable name="has-content" select="key('resources', key('resources', ac:uri())/apl:content/@rdf:resource) or key('resources', ac:uri())/rdf:type/@rdf:resource[doc-available(ac:document-uri(.))]/key('resources', ., document(ac:document-uri(.)))/apl:template/@rdf:resource[doc-available(ac:document-uri(.))]/key('resources', ., document(ac:document-uri(.)))" as="xs:boolean"/>
                <xsl:choose>
                    <!-- check if the current document has content or its class has content -->
                    <xsl:when test="(not($ac:mode) or $ac:mode = '&apl;ContentMode') and $has-content">
                        <xsl:for-each select="key('resources', ac:uri())">
                            <xsl:apply-templates select="key('resources', apl:content/@rdf:*)" mode="apl:ContentList"/>
                            <xsl:apply-templates select="rdf:type/@rdf:resource[doc-available(ac:document-uri(.))]/key('resources', ., document(ac:document-uri(.)))/apl:template/@rdf:resource[doc-available(ac:document-uri(.))]/key('resources', ., document(ac:document-uri(.)))" mode="apl:ContentList"/>
                        </xsl:for-each>
                    </xsl:when>
                    <xsl:when test="$ac:mode = '&ac;MapMode'">
                        <xsl:apply-templates select="." mode="bs2:Map">
                            <xsl:sort select="ac:label(.)"/>
                        </xsl:apply-templates>
                    </xsl:when>
                    <xsl:when test="$ac:mode = '&ac;ChartMode'">
                        <xsl:apply-templates select="." mode="bs2:Chart">
                            <xsl:sort select="ac:label(.)"/>
                        </xsl:apply-templates>
                    </xsl:when>
                    <xsl:when test="$ac:mode = '&ac;GraphMode'">
                        <xsl:apply-templates select="." mode="bs2:Graph">
                            <xsl:sort select="ac:label(.)"/>
                        </xsl:apply-templates>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates select="." mode="bs2:RowBlock">
                            <xsl:sort select="ac:label(.)"/>
                        </xsl:apply-templates>
                    </xsl:otherwise>
                </xsl:choose>
            </div>

            <xsl:apply-templates select="." mode="bs2:Footer"/>
        </body>
    </xsl:template>

    <xsl:template match="rdf:RDF[key('resources-by-type', '&http;Response')]" mode="bs2:ModeTabs" priority="1"/>

    <xsl:template match="rdf:RDF" mode="bs2:ModeTabs">
        <xsl:param name="has-content" select="key('resources', key('resources', ac:uri())/apl:content/@rdf:resource) or key('resources', ac:uri())/rdf:type/@rdf:resource[doc-available(ac:document-uri(.))]/key('resources', ., document(ac:document-uri(.)))/apl:template/@rdf:resource[doc-available(ac:document-uri(.))]/key('resources', ., document(ac:document-uri(.)))" as="xs:boolean"/>

        <div class="row-fluid">
            <ul class="nav nav-tabs offset2 span7">
                <xsl:if test="$has-content">
                    <li class="content-mode{if (not($ac:mode) or $ac:mode = '&apl;ContentMode') then ' active' else() }">
                        <a>
                            <xsl:value-of>
                                <xsl:apply-templates select="key('resources', 'content', document('translations.rdf'))" mode="ac:label"/>
                            </xsl:value-of>
                        </a>
                    </li>
                </xsl:if>

                <xsl:for-each select="key('resources', '&ac;ReadMode', document(ac:document-uri('&ac;')))">
                    <xsl:apply-templates select="." mode="bs2:ModeTabsItem">
                        <xsl:with-param name="active" select="@rdf:about = $ac:mode or (not($ac:mode) and not($has-content))"/>
                    </xsl:apply-templates>
                </xsl:for-each>
                <xsl:for-each select="key('resources', '&ac;MapMode', document(ac:document-uri('&ac;')))">
                    <xsl:apply-templates select="." mode="bs2:ModeTabsItem">
                        <xsl:with-param name="active" select="@rdf:about = $ac:mode"/>
                    </xsl:apply-templates>
                </xsl:for-each>
                <xsl:for-each select="key('resources', '&ac;ChartMode', document(ac:document-uri('&ac;')))">
                    <xsl:apply-templates select="." mode="bs2:ModeTabsItem">
                        <xsl:with-param name="active" select="@rdf:about = $ac:mode"/>
                    </xsl:apply-templates>
                </xsl:for-each>
                <xsl:for-each select="key('resources', '&ac;GraphMode', document(ac:document-uri('&ac;')))">
                    <xsl:apply-templates select="." mode="bs2:ModeTabsItem">
                        <xsl:with-param name="active" select="@rdf:about = $ac:mode"/>
                    </xsl:apply-templates>
                </xsl:for-each>
            </ul>
        </div>
    </xsl:template>
    
    <xsl:template match="*[@rdf:about]" mode="bs2:ModeTabsItem">
        <xsl:param name="active" as="xs:boolean"/>
        <xsl:param name="mode-classes" as="map(xs:string, xs:string)">
            <xsl:map>
                <xsl:map-entry key="'&apl;ContentMode'" select="'content-mode'"/>
                <xsl:map-entry key="'&ac;ReadMode'" select="'read-mode'"/>
                <xsl:map-entry key="'&ac;MapMode'" select="'map-mode'"/>
                <xsl:map-entry key="'&ac;ChartMode'" select="'chart-mode'"/>
                <xsl:map-entry key="'&ac;GraphMode'" select="'graph-mode'"/>
            </xsl:map>
        </xsl:param>
        <xsl:param name="class" select="map:get($mode-classes, @rdf:about) || (if ($active) then ' active' else ())" as="xs:string?"/>

        <li>
            <xsl:if test="$class">
                <xsl:attribute name="class"><xsl:sequence select="$class"/></xsl:attribute>
            </xsl:if>

            <a>
                <xsl:value-of>
                    <xsl:apply-templates select="." mode="ac:label"/>
                </xsl:value-of>
            </a>
        </li>
    </xsl:template>
    
    <xsl:template match="*[*][@rdf:about = ac:uri()]" mode="bs2:PropertyList">
        <xsl:variable name="query-string" select="'DESCRIBE &lt;' || ac:uri() || '&gt;'" as="xs:string"/>
        <xsl:variable name="local-doc" select="document(ac:build-uri(xs:anyURI('https://localhost:4443/sparql'), map{ 'query': $query-string }))"/>

        <xsl:variable name="triples-original" as="map(xs:string, element())">
            <xsl:map>
                <xsl:for-each select="*">
                    <xsl:map-entry key="concat(../@rdf:about, '|', namespace-uri(), local-name(), '|', @rdf:resource, @rdf:nodeID, if (text() castable as xs:float) then xs:float(text()) else text(), '|', @rdf:datatype, @xml:lang)" select="."/>
                </xsl:for-each>
            </xsl:map>
        </xsl:variable>
        <xsl:variable name="triples-local" as="map(xs:string, element())">
            <xsl:map>
                <xsl:for-each select="$local-doc/rdf:RDF/rdf:Description/*">
                    <xsl:map-entry key="concat(../@rdf:about, '|', namespace-uri(), local-name(), '|', @rdf:resource, @rdf:nodeID, if (text() castable as xs:float) then xs:float(text()) else text(), '|', @rdf:datatype, @xml:lang)" select="."/>
                </xsl:for-each>
            </xsl:map>
        </xsl:variable>

        <xsl:variable name="properties-original" select="for $triple-key in ac:value-except(map:keys($triples-original), map:keys($triples-local)) return map:get($triples-original, $triple-key)" as="element()*"/>
        <xsl:if test="exists($properties-original)">
            <div>
                <h2 class="nav-header btn">
                    <xsl:value-of>
                        <xsl:apply-templates select="key('resources', 'from-origin', document('translations.rdf'))" mode="ac:label"/>
                    </xsl:value-of>
                </h2>

                <xsl:variable name="definitions" as="document-node()">
                    <xsl:document>
                        <dl class="dl-horizontal">
                            <xsl:apply-templates select="$properties-original" mode="#current">
                                <xsl:sort select="ac:property-label(.)" order="ascending" lang="{$ldt:lang}"/>
                                <xsl:sort select="if (exists((text(), @rdf:resource, @rdf:nodeID))) then ac:object-label((text(), @rdf:resource, @rdf:nodeID)[1]) else()" order="ascending" lang="{$ldt:lang}"/>
                            </xsl:apply-templates>
                        </dl>
                    </xsl:document>
                </xsl:variable>

                <xsl:apply-templates select="$definitions" mode="bs2:PropertyListIdentity"/>
            </div>
        </xsl:if>

        <xsl:variable name="properties-local" select="for $triple-key in ac:value-except(map:keys($triples-local), map:keys($triples-original)) return map:get($triples-local, $triple-key)" as="element()*"/>
        <xsl:if test="exists($properties-local)">
            <div>
                <h2 class="nav-header btn">
                    <xsl:value-of>
                        <xsl:apply-templates select="key('resources', 'local', document('translations.rdf'))" mode="ac:label"/>
                    </xsl:value-of>
                </h2>
                
                <xsl:variable name="definitions" as="document-node()">
                    <xsl:document>
                        <dl class="dl-horizontal">
                            <xsl:apply-templates select="$properties-local" mode="#current">
                                <xsl:sort select="ac:property-label(.)" order="ascending" lang="{$ldt:lang}"/>
                                <xsl:sort select="if (exists((text(), @rdf:resource, @rdf:nodeID))) then ac:object-label((text(), @rdf:resource, @rdf:nodeID)[1]) else()" order="ascending" lang="{$ldt:lang}"/>
                            </xsl:apply-templates>
                        </dl>
                    </xsl:document>
                </xsl:variable>

                <xsl:apply-templates select="$definitions" mode="bs2:PropertyListIdentity"/>
            </div>
        </xsl:if>
        
        <xsl:variable name="properties-common" select="for $triple-key in ac:value-intersect(map:keys($triples-original), map:keys($triples-local)) return map:get($triples-original, $triple-key)" as="element()*"/>
        <xsl:if test="exists($properties-common)">
            <div>
                <h2 class="nav-header btn">
                    <xsl:value-of>
                        <xsl:apply-templates select="key('resources', 'common', document('translations.rdf'))" mode="ac:label"/>
                    </xsl:value-of>
                </h2>

                <xsl:variable name="definitions" as="document-node()">
                    <xsl:document>
                        <dl class="dl-horizontal">
                            <xsl:apply-templates select="$properties-common" mode="#current">
                                <xsl:sort select="ac:property-label(.)" order="ascending" lang="{$ldt:lang}"/>
                                <xsl:sort select="if (exists((text(), @rdf:resource, @rdf:nodeID))) then ac:object-label((text(), @rdf:resource, @rdf:nodeID)[1]) else()" order="ascending" lang="{$ldt:lang}"/>
                            </xsl:apply-templates>
                        </dl>
                    </xsl:document>
                </xsl:variable>

                <xsl:apply-templates select="$definitions" mode="bs2:PropertyListIdentity"/>
            </div>
        </xsl:if>
    </xsl:template>
    
    <!-- ADD DATA -->
    
    <xsl:template match="rdf:RDF[$acl:mode = '&acl;Append']" mode="bs2:AddData" priority="1">
        <div class="btn-group pull-left">
            <button type="button" title="{ac:label(key('resources', 'add-data-title', document('translations.rdf')))}" class="btn btn-primary btn-add-data">
                <xsl:value-of>
                    <xsl:apply-templates select="key('resources', 'add-data', document('translations.rdf'))" mode="ac:label"/>
                </xsl:value-of>
            </button>
        </div>
    </xsl:template>
    
    <xsl:template match="*" mode="bs2:AddData"/>
    
    <!-- MODE LIST -->
        
    <xsl:template match="rdf:RDF[key('resources-by-type', '&http;Response')][not(key('resources-by-type', '&spin;ConstraintViolation'))]" mode="bs2:ModeList" priority="1"/>

    <xsl:template match="rdf:RDF[ac:uri()]" mode="bs2:ModeList">
        <div class="btn-group pull-right">
            <button type="button" title="{ac:label(key('resources', 'mode-list-title', document('translations.rdf')))}">
                <xsl:apply-templates select="key('resources', $ac:mode, document(ac:document-uri('&ac;'))) | key('resources', $ac:mode, document(ac:document-uri('&apl;')))" mode="apl:logo">
                    <xsl:with-param name="class" select="'btn dropdown-toggle'"/>
                </xsl:apply-templates>
                <xsl:text> </xsl:text>
                <span class="caret"></span>
            </button>

            <ul class="dropdown-menu">
                <xsl:for-each select="key('resources-by-type', '&ac;Mode', document(ac:document-uri('&ac;'))) | key('resources', ('&ac;QueryEditorMode'), document(ac:document-uri('&ac;')))">
                    <xsl:sort select="ac:label(.)"/>
                    <xsl:apply-templates select="." mode="bs2:ModeListItem">
                        <xsl:with-param name="active" select="$ac:mode"/>
                    </xsl:apply-templates>
                </xsl:for-each>
            </ul>
        </div>
    </xsl:template>
       
    <xsl:template match="*" mode="bs2:ModeListItem"/>

    <!-- MEDIA TYPE LIST  -->
        
    <xsl:template match="rdf:RDF" mode="bs2:MediaTypeList" priority="1">
        <div class="btn-group pull-right">
            <button type="button" id="export-rdf" title="{ac:label(key('resources', 'nav-bar-action-export-rdf-title', document('translations.rdf')))}">
                <xsl:apply-templates select="key('resources', '&ac;Export', document(ac:document-uri('&ac;')))" mode="apl:logo">
                    <xsl:with-param name="class" select="'btn dropdown-toggle'"/>
                </xsl:apply-templates>
                
                <span class="caret"></span>
            </button>
            <ul class="dropdown-menu">
                <li>
                    <a title="application/rdf+xml">RDF/XML</a>
                </li>
                <li>
                    <a title="text/turtle">Turtle</a>
                </li>
            </ul>
        </div>
    </xsl:template>
    
    <!-- HEADER  -->

    <!-- TO-DO: move http:Response templates to error.xsl -->
    <xsl:template match="*[rdf:type/@rdf:resource = '&http;Response'][lacl:requestAccess/@rdf:resource][$acl:Agent]" mode="bs2:Header" priority="2">
        <xsl:param name="id" as="xs:string?"/>
        <xsl:param name="class" select="'alert alert-info well'" as="xs:string?"/>

        <div>
            <xsl:if test="$id">
                <xsl:attribute name="id"><xsl:value-of select="$id"/></xsl:attribute>
            </xsl:if>
            <xsl:if test="$class">
                <xsl:attribute name="class"><xsl:value-of select="$class"/></xsl:attribute>
            </xsl:if>

            <h2>
                <xsl:apply-templates select="." mode="apl:logo"/>
                
                <a href="{if (not(starts-with(lacl:requestAccess/@rdf:resource, $ldt:base))) then ac:build-uri($ldt:base, map{ 'uri': string(lacl:requestAccess/@rdf:resource), 'access-to': string(ac:uri()) }) else concat(lacl:requestAccess/@rdf:resource, '&amp;access-to=', encode-for-uri(ac:uri()))}" class="btn btn-primary pull-right">Request access</a>
            </h2>
        </div>
    </xsl:template>
    
    <xsl:template match="*[rdf:type/@rdf:resource = '&http;Response']" mode="bs2:Header" priority="1">
        <xsl:param name="id" as="xs:string?"/>
        <xsl:param name="class" select="'alert alert-error well'" as="xs:string?"/>

        <div>
            <xsl:if test="$id">
                <xsl:attribute name="id"><xsl:value-of select="$id"/></xsl:attribute>
            </xsl:if>
            <xsl:if test="$class">
                <xsl:attribute name="class"><xsl:value-of select="$class"/></xsl:attribute>
            </xsl:if>

            <h2>
                <xsl:value-of>
                    <xsl:apply-templates select="." mode="ac:label"/>
                </xsl:value-of>
            </h2>
        </div>
    </xsl:template>

    <!-- CONTENT HEADER -->

    <!-- hide the header of def:SelectChildren content -->
    <xsl:template match="*[*][@rdf:about = '&def;SelectChildren']" mode="apl:ContentHeader"/>

    <!-- FORM CONTROL -->
    
    <xsl:template match="*[@rdf:about or @rdf:nodeID][$ac:forClass]/sioc:has_parent/@rdf:nodeID | *[@rdf:about or @rdf:nodeID][$ac:forClass]/sioc:has_container/@rdf:nodeID" mode="bs2:FormControl">
        <xsl:param name="class-containers" as="map(xs:string, xs:anyURI)">
            <xsl:map>
                <xsl:map-entry key="'&def;GenericService'" select="resolve-uri('services/', $ldt:base)"/>
                <xsl:map-entry key="'&def;DydraService'" select="resolve-uri('services/', $ldt:base)"/>
                <xsl:map-entry key="'&def;File'" select="resolve-uri('files/', $ldt:base)"/>
                <xsl:map-entry key="'&def;Construct'" select="resolve-uri('queries/', $ldt:base)"/>
                <xsl:map-entry key="'&def;Describe'" select="resolve-uri('queries/', $ldt:base)"/>
                <xsl:map-entry key="'&def;Select'" select="resolve-uri('queries/', $ldt:base)"/>
                <xsl:map-entry key="'&def;Ask'" select="resolve-uri('queries/', $ldt:base)"/>
                <xsl:map-entry key="'&def;RDFImport'" select="resolve-uri('imports/', $ldt:base)"/>
                <xsl:map-entry key="'&def;CSVImport'" select="resolve-uri('imports/', $ldt:base)"/>
                <xsl:map-entry key="'&def;GraphChart'" select="resolve-uri('charts/', $ldt:base)"/>
                <xsl:map-entry key="'&def;ResultSetChart'" select="resolve-uri('charts/', $ldt:base)"/>
            </xsl:map>
        </xsl:param>
        <xsl:param name="container" select="if (map:contains($class-containers, $ac:forClass)) then map:get($class-containers, $ac:forClass) else ac:uri()" as="xs:anyURI"/>

        <xsl:next-match>
            <xsl:with-param name="container" select="$container" as="xs:anyURI"/>
        </xsl:next-match>
    </xsl:template>
    
    <!-- NAVBAR ACTIONS -->

    <xsl:template match="rdf:RDF" mode="bs2:NavBarActions" priority="1">
        <xsl:if test="$acl:Agent//@rdf:about">
            <div class="pull-right">
                <button type="button" title="{ac:label(key('resources', 'nav-bar-action-delete-title', document('translations.rdf')))}">
                    <xsl:apply-templates select="key('resources', '&ac;Delete', document(ac:document-uri('&ac;')))" mode="apl:logo">
                        <xsl:with-param name="class" select="'btn'"/>
                    </xsl:apply-templates>
                </button>
            </div>

            <xsl:if test="not($ac:mode = '&ac;EditMode')">
                <div class="pull-right">
                    <xsl:variable name="graph-uri" select="ac:build-uri(ac:uri(), map{ 'mode': '&ac;EditMode' })" as="xs:anyURI"/>
                    <button type="button" title="{ac:label(key('resources', 'nav-bar-action-edit-graph-title', document('translations.rdf')))}">
                        <xsl:apply-templates select="key('resources', '&ac;EditMode', document(ac:document-uri('&ac;')))" mode="apl:logo">
                            <xsl:with-param name="class" select="'btn'"/>
                        </xsl:apply-templates>

                        <input type="hidden" value="{$graph-uri}"/>
                    </button>
                </div>
            </xsl:if>
            
            <div class="pull-right">
                <button type="button" title="{ac:label(key('resources', 'skolemize-title', document('translations.rdf')))}">
                    <xsl:apply-templates select="key('resources', 'skolemize', document('translations.rdf'))" mode="apl:logo">
                        <xsl:with-param name="class" select="'btn'"/>
                    </xsl:apply-templates>
                </button>
            </div>
            
            <div class="pull-right">
                <button type="button" title="{key('resources', 'save-as-title', document('translations.rdf'))}">
                    <xsl:apply-templates select="key('resources', 'save-as', document('translations.rdf'))" mode="apl:logo">
                        <xsl:with-param name="class" select="'btn'"/>
                    </xsl:apply-templates>

                    <xsl:value-of>
                        <xsl:apply-templates select="key('resources', 'save-as', document('translations.rdf'))" mode="ac:label"/>
                        <xsl:text>...</xsl:text>
                    </xsl:value-of>
                </button>
            </div>
            
<!--            <div class="pull-right">
                <form action="{ac:uri()}?ban=true" method="post">
                    <input type="hidden" name="ban" value="true"/>
                    <button type="submit" title="{ac:label(key('resources', 'nav-bar-action-refresh-title', document('translations.rdf')))}">
                        <xsl:apply-templates select="key('resources', '&aplt;Ban', document(ac:document-uri('&aplt;')))" mode="apl:logo">
                            <xsl:with-param name="class" select="'btn'"/>
                        </xsl:apply-templates>
                    </button>
                </form>
            </div>-->
            
            <div class="btn-group pull-right">
                <button type="button" title="{ac:label(key('resources', 'acl-list-title', document('translations.rdf')))}">
                    <xsl:apply-templates select="key('resources', '&acl;Access', document(ac:document-uri('&acl;')))" mode="apl:logo">
                        <xsl:with-param name="class" select="'btn dropdown-toggle'"/>
                    </xsl:apply-templates>
                    <xsl:text> </xsl:text>
                    <span class="caret"></span>
                </button>

                <ul class="dropdown-menu">
                    <xsl:for-each select="key('resources-by-subclass', '&acl;Access', document(ac:document-uri('&acl;')))">
                        <xsl:sort select="ac:label(.)"/>
                        <xsl:apply-templates select="." mode="bs2:AccessListItem">
                            <xsl:with-param name="enabled" select="$acl:mode"/>
                        </xsl:apply-templates>
                    </xsl:for-each>
                </ul>
            </div>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="*[@rdf:about]" mode="bs2:AccessListItem" priority="1">
        <xsl:param name="enabled" as="xs:anyURI*"/>
        <xsl:variable name="href" select="ac:uri()" as="xs:anyURI"/>

        <li>
            <a title="{@rdf:about}">
                <xsl:choose>
                    <xsl:when test="@rdf:about = $enabled">
                        <xsl:text>&#x2714;</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>&#x2718;</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:text> </xsl:text>
                <xsl:value-of>
                    <xsl:apply-templates select="." mode="ac:label"/>
                </xsl:value-of>
            </a>
        </li>
    </xsl:template>
        
    <!-- SETTINGS -->
    
    <xsl:template match="rdf:RDF" mode="bs2:Settings" priority="1">
        <div class="btn-group pull-right">
            <button type="button" title="{ac:label(key('resources', 'nav-bar-action-settings-title', document('translations.rdf')))}">
                <xsl:apply-templates select="key('resources', 'settings', document('translations.rdf'))" mode="apl:logo">
                    <xsl:with-param name="class" select="'btn dropdown-toggle'"/>
                </xsl:apply-templates>
            </button>

            <ul class="dropdown-menu">
                <xsl:if test="$acl:Agent//@rdf:about and $lapp:Application//*[ldt:base/@rdf:resource = $ldt:base]/rdf:type/@rdf:resource = '&lapp;EndUserApplication'">
                    <li>
                        <xsl:for-each select="$lapp:Application">
                            <a href="{key('resources', //*[ldt:base/@rdf:resource = $ldt:base]/lapp:adminApplication/(@rdf:resource, @rdf:nodeID))/ldt:base/@rdf:resource[starts-with(., $ac:contextUri)]}" target="_blank">
                                Administration
                            </a>
                        </xsl:for-each>
                    </li>
                    <li>
                        <a href="{resolve-uri('admin/model/ontologies/namespace/', $ldt:base)}" target="_blank">Namespace</a>
                    </li>
                </xsl:if>
                <li>
                    <a href="https://atomgraph.github.io/LinkedDataHub/linkeddatahub/docs/" target="_blank">Documentation</a>
                </li>
            </ul>
        </div>
    </xsl:template>

    <!-- SPARQL QUERY -->
    
    <!-- Query over POST does not work -->
    <xsl:template match="*[sp:text]" mode="bs2:Actions" priority="2">
        <xsl:param name="method" select="'get'" as="xs:string"/>
        <xsl:param name="action" select="xs:anyURI('')" as="xs:anyURI"/>
        <xsl:param name="id" as="xs:string?"/>
        <xsl:param name="class" as="xs:string?"/>
        <xsl:param name="accept-charset" select="'UTF-8'" as="xs:string?"/>
        <xsl:param name="enctype" as="xs:string?"/>
        
        <div class="pull-right">
            <form method="{$method}" action="{$action}" class="form-open-query">
                <xsl:if test="$id">
                    <xsl:attribute name="id"><xsl:value-of select="$id"/></xsl:attribute>
                </xsl:if>
                <xsl:if test="$class">
                    <xsl:attribute name="class"><xsl:value-of select="$class"/></xsl:attribute>
                </xsl:if>
                <xsl:if test="$accept-charset">
                    <xsl:attribute name="accept-charset"><xsl:value-of select="$accept-charset"/></xsl:attribute>
                </xsl:if>
                <xsl:if test="$enctype">
                    <xsl:attribute name="enctype"><xsl:value-of select="$enctype"/></xsl:attribute>
                </xsl:if>

                <xsl:for-each select="apl:service/@rdf:resource">
                    <input type="hidden" name="service" value="{.}"/>
                </xsl:for-each>
                <input type="hidden" name="mode" value="&ac;QueryEditorMode"/>
                <input type="hidden" name="query" value="{sp:text}"/>

                <button type="submit" class="btn btn-primary">Open</button>
            </form>
        </div>
        
        <xsl:next-match/>
    </xsl:template>

    <!-- FOOTER -->
    
    <xsl:template match="rdf:RDF" mode="bs2:Footer">
        <div class="footer container-fluid">
            <div class="row-fluid">
                <div class="offset2 span8">
                    <div class="span3">
                        <h2 class="nav-header">About</h2>
                        <ul class="nav nav-list">
                            <li>
                                <a href="https://atomgraph.github.io/LinkedDataHub/linkeddatahub/docs/about/" target="_blank">LinkedDataHub</a>
                            </li>
                            <li>
                                <a href="https://atomgraph.com" target="_blank">AtomGraph</a>
                            </li>
                        </ul>
                    </div>
                    <div class="span3">
                        <h2 class="nav-header">Resources</h2>
                        <ul class="nav nav-list">
                            <li>
                                <a href="https://atomgraph.github.io/LinkedDataHub/linkeddatahub/docs/" target="_blank">Documentation</a>
                            </li>
                            <li>
                                <a href="https://www.youtube.com/channel/UCtrdvnVjM99u9hrjESwfCeg" target="_blank">Screencasts</a>
                            </li>
                        </ul>
                    </div>
                    <div class="span3">
                        <h2 class="nav-header">Support</h2>
                        <ul class="nav nav-list">
                            <li>
                                <a href="https://groups.io/g/linkeddatahub" target="_blank">Mailing list</a>
                            </li>
                            <li>
                                <a href="https://github.com/AtomGraph/LinkedDataHub/issues" target="_blank">Report issues</a>
                            </li>
                            <li>
                                <a href="mailto:support@linkeddatahub.com">Contact support</a>
                            </li>
                        </ul>
                    </div>
                    <div class="span3">
                        <h2 class="nav-header">Follow us</h2>
                        <ul class="nav nav-list">
                            <li>
                                <a href="https://twitter.com/atomgraphhq" target="_blank">@atomgraphhq</a>
                            </li>
                            <li>
                                <a href="https://github.com/AtomGraph" target="_blank">github.com/AtomGraph</a>
                            </li>
                            <li>
                                <a href="https://www.facebook.com/AtomGraph" target="_blank">facebook.com/AtomGraph</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </xsl:template>
    
</xsl:stylesheet>