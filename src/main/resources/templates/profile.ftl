<#import "./parts/page.ftl" as p>

<@p.page "profile">
    <#if message??>
        <div>
            ${message}
        </div>
    </#if>
    <#if user??>
        <h5>${username}</h5>
    </#if>
    <form method="post">

        <div class="form-group row">
            <label for="email" class="col-sm-2 col-form-label">Email</label>
            <div class="col-sm-6">
                <input id="email" class="form-control" type="email" name="email" placeholder="some@some.com" value="${email!""}"/>
            </div>
        </div>
        <div class="form-group row">
            <label for="password" class="col-sm-2 col-form-label">Password</label>
            <div class="col-sm-6">
                <input id="password" class="form-control" type="password" name="password" placeholder="Password"/>
            </div>
        </div>
        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
        <button type="submit" class="btn btn-primary">Save</button>
    </form>
</@p.page>