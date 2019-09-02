<#import "./parts/page.ftl" as p>
<#import "./parts/login.ftl" as l>

<@p.page "Registration">
    <#if message??>
        <div>
            ${message}
        </div>
    </#if>
        <@l.login true/>
</@p.page>