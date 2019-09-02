<#import "./parts/page.ftl" as p>
<#import "./parts/login.ftl" as l>
<#include "./parts/security.ftl">
<#import "./parts/pager.ftl" as pager>


<@p.page "messages">
<#--title of theme -->
    <h5 class="text-center">${title}</h5>
<#--if messages is exists-->
    <#if page.content??>
        <div>
            <#--iteration on message -->
            <#list page.content as message>
            <#--each messages represent as card(Bootstrap)-->
                <div class="card my-3">
                    <#--header of card is autor and date of message create-->
                    <div class="card-header">
                        <strong>${message.authorName}</strong> <i>${message.date?datetime}</i>
                    </div>
                    <#--end of header -->
                    <#--body of card is text message-->
                    <div class="card-body">
                        ${message.text}
                    </div>
                    <#--end of body -->
                    <#--footer of card for operation with message (ex delete) only for admin and author message -->
                    <div class="card-footer">
                        <#if isAdmin || currentUserID == message.author.id>
                            <form action="/delMessage" method="post">
                                <button class="btn btn-link">Delete</button>
                                <#--hidden field for right work back end-->
                                <input type="hidden" name="theme_id" value="${message.theme.id}">
                                <input type="hidden" name="message_id" value="${message.id}"/>
                                <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                                <input type="Hidden" name="page" value="${page.getNumber()}"/>
                            </form>
                        </#if>
                    </div>
                    <#--end of fooler-->
                </div>
            <#--end of message card-->
            </#list>
        </div>
    </#if>

<#-- show form on last page-->
    <#if (page.getNumber() + 1)== page.getTotalPages() || page.getTotalPages() == 0>

    <#--    form for sending new message-->
        <div class="container mar">
            <form action="/addMessage" method="post">
                <div class="form-group row justify-content-center">
                    <div class="col-sm-6 ">
                <textarea id="text" name="text" placeholder="Enter your message"
                          class="form-control ${(textError??)?string('is-invalid','')}"
                ><#if message??>${message.text}</#if></textarea>
                        <#--validation section of textarea-->
                        <#if textError??>
                            <div class="invalid-feedback">
                                ${textError}
                            </div>
                        </#if>
                        <#--end of validation section-->
                    </div>
                    <div>
                        <button type="submit" name="addBtn">Send message</button>
                    </div>
                </div>
                <#-- hidden field for right request        -->
                <input type="hidden" name="theme_id" value="${theme_id}">
                <input type="hidden" name="_csrf" value="${_csrf.token}"/>
            </form>
        </div>
    <#--    end of form sending new message-->
    </#if>

    <#--end of iteration on message-->
    <@pager.pager page url/>
</@p.page>