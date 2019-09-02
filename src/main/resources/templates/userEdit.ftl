<#import "./parts/page.ftl" as p>
<@p.page "Edit user">
    Edit User
    <form action="/user" method="post">
        <label>
            <input type="text" name="username" value="${user.username}">
            <#list roles as role>
        </label>
        <div>
            <label>
                <input type="checkbox" name="${role}" ${user.roles?seq_contains(role)?string("checked", "")}/>${role}
            </label>
        </div>
        </#list>
        <input type="hidden" name="userId" value="${user.id}">
        <input type="hidden" name="_csrf" value="${_csrf.token}">
        <button type="submit">save</button>
    </form>
</@p.page>