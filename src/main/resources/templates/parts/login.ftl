<#macro login isRegistration>
    <form action="<#if isRegistration>/registration<#else>/login</#if>" method="post">
        <#--field for login-->
        <div class="form-group row">
            <label for="username" class="col-sm-2 col-form-label">User Name</label>
            <div class="col-sm-6">
                <input id="username" type="text" name="username" placeholder="Login"
                       class="form-control ${(usernameError??)?string('is-invalid','')}"
                       value="<#if user??>${user.username}</#if>"
                />
                <#if usernameError??>
                    <div class="invalid-feedback">
                        ${usernameError}
                    </div>
                </#if>
            </div>
        </div>
        <#--field for first name only registration form-->
        <#if isRegistration>
            <div class="form-group row">
                <label for="firstname" class="col-sm-2 col-form-label">First name</label>
                <div class="col-sm-6">
                    <input id="firstname" type="text" name="firstname" placeholder="First name"
                           class="form-control ${(firstnameError??)?string('is-invalid','')}"
                           value="<#if user??>${user.firstname}</#if>"
                    />
                    <#if firstnameError??>
                        <div class="invalid-feedback">
                            ${firstnameError}
                        </div>
                    </#if>
                </div>
            </div>
        </#if>

        <#--field for last name only registration form-->
        <#if isRegistration>
            <div class="form-group row">
                <label for="lastname" class="col-sm-2 col-form-label">Last name</label>
                <div class="col-sm-6">
                    <input id="lastname" type="text" name="lastname" placeholder="Last name"
                           class="form-control ${(lastnameError??)?string('is-invalid','')}"
                           value="<#if user??>${user.lastname}</#if>"
                    />
                    <#if lastnameError??>
                        <div class="invalid-feedback">
                            ${lastnameError}
                        </div>
                    </#if>
                </div>
            </div>
        </#if>

        <#--field for password registration form and login form-->
        <div class="form-group row">
            <label for="password" class="col-sm-2 col-form-label">Password</label>
            <div class="col-sm-6">
                <input id="password" type="password" name="password" placeholder="Password"
                       class="form-control ${(passwordError??)?string('is-invalid', '')}"
                />
                <#if passwordError??>
                    <div class="invalid-feedback">
                        ${passwordError}
                    </div>
                </#if>
            </div>
        </div>

        <#--field for confirmation password only registration form-->
        <#if isRegistration>
            <div class="form-group row">
                <label for="password2" class="col-sm-2 col-form-label"></label>
                <div class="col-sm-6">
                    <input id="password2" type="password" name="password2" placeholder="Retype password"
                           class="form-control ${(password2Error??)?string('is-invalid', '')}"
                    />
                    <#if password2Error??>
                        <div class="invalid-feedback">
                            ${password2Error}
                        </div>
                    </#if>
                </div>
            </div>
        </#if>

        <#--hidden field -->
        <input type="hidden" name="_csrf" value="${_csrf.token}"/>

        <#--button for sign in(login form) or registation(registration form)-->
        <button type="submit" class="btn btn-primary"><#if isRegistration>Registration<#else>Sign in</#if></button>

        <#--button for redirect to registration form-->
        <#if !isRegistration>
            <a class="btn btn-primary" href="/registration">Registration</a>
        </#if>
    </form>
</#macro>

<#macro logout>
    <form action="/logout" method="post">
        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
        <button class="btn btn-light">Sign Out</button>
    </form>
</#macro>