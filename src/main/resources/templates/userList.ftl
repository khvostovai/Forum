<#import "./parts/page.ftl" as p>

<@p.page "User List">
    <table>
        <thead>
            <tr>
                <th>user</th>
                <th>roles</th>
            </tr>
        </thead>
        <tbody>
            <#list users as user>
                <tr>
                    <td>${user.username}</td>
                    <td><#list user.roles as role>${role}<#sep>, </#list></td>
                    <td><a href="/user/${user.id}">edit</a></td>
                </tr>
            </#list>
        </tbody>
    </table>
</@p.page>