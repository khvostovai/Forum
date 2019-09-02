<#import "./parts/page.ftl" as p>
<#include "./parts/security.ftl">
<#import "./parts/pager.ftl" as pager>

<@p.page "themes">
<#--button which colapse panel for add new theme-->
    <div class="text-center mb-3">
        <button class="btn btn-primary" data-toggle="modal" data-target="#addTheme">add new theme</button>
    </div>

    <!-- Modal -->
    <div class="modal fade" id="addTheme" tabindex="-1" role="dialog" aria-labelledby="ModalLabel"
         aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="ModalLabel">Add Theme</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">

                    <#--it show if theme exist (user entered invalid data to field)-->
                    <form method="post" action="/themes">
                        <#--row for title of theme -->
                        <div class="form-group row">
                            <label for="title" class="col-sm-3 col-form-label">Title of theme</label>
                            <div class="col-sm-8">
                                <#--title of theme-->
                                <input id="title" type="text" name="title"
                                       class="form-control ${(titleError??)?string('is-invalid','')}"
                                        <#if theme?? >
                                            value="${theme.title}"
                                        </#if>
                                />
                                <#--shor error if title is invalid-->
                                <#if titleError??>
                                    <div class="invalid-feedback">
                                        ${titleError}
                                    </div>
                                </#if>
                                <#--end of invalid section-->
                            </div>
                        </div>
                        <#--end of row -->

                        <#--row for description of theme -->
                        <div class="form-group row">
                            <label for="description" class="col-sm-3 col-form-label">Description of theme</label>
                            <div class="col-sm-8">
                                <input id="description" type="text" name="description"
                                       class="form-control ${(descriptionError??)?string('is-invalid', '')}"
                                        <#if theme?? >
                                            value="${theme.description}"
                                        </#if>
                                />
                                <#--show error if description is invalid-->
                                <#if descriptionError??>
                                    <div class="invalid-feedback">
                                        ${descriptionError}
                                    </div>
                                <#--end of invalid section-->
                                </#if>
                            </div>
                        </div>
                        <#--end row with descritpion of theme-->

                        <#--hidden field for right worl back end-->
                        <input type="hidden" name="_csrf" value="${_csrf.token}"/>

                        <#--button for sumbit data to server-->
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            <button class="btn btn-primary" type="submit">Create</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>


<#--Show list of themes-->
    <div class="text-center mt-3"><h5>List of themes</h5></div>
<#--if themes is exists-->
    <#if page.content??>
        <@pager.pager page url/>
        <#list page.content as theme>
        <#--for each theme show theme as card(BootStrap)-->
            <div class="card mt-3" style="cursor: pointer;" onclick="window.location='/theme/${theme.id}'">
                <#--card header-->
                <div class="card-header">
                    <h6 class="card-title">${theme.title}</h6>
                </div>
                <#--end of card-header-->
                <#--card-body-->
                <div class="card-body">
                    <p class="card-text">${theme.description}</p>
                    <h6 class="card-subtitle">Author: <i>${theme.author.username}</i></h6>
                    <h6 class="card-subtitle mt-1">Last modify: <i>${theme.date?datetime}</i></h6>
                </div>
                <#--end of card-body -->
                <#--card-footer-->
                <div class="card-footer">
                    <#--action whith theme only for admin and owner theme-->
                    <#if isAdmin>
                        <form method="post" action="/delTheme">
                            <#--hidden field-->
                            <input type="hidden" name="theme_id" value="${theme.id}"/>
                            <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                            <input type="hidden" name="page" value="${page.getNumber()}">
                            <#--sublit button-->
                            <button class="btn btn-link">Delete</button>
                        </form>
                    </#if>
                </div>
                <#--end of card-footer-->
            </div>
        <#--end of card-->
        </#list>
    <#--end of list themes-->
    </#if>
</@p.page>