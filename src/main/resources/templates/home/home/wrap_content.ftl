<ul class="tabHF-content list-mendian">
    <li class="current">
        <div class="mendian-wrap">
            <dl class="dl-mendian clearfix">
            <#list userList as user>
                <dd>
                    <span sid="${user.id}"   dd="${user.longitudeAndLatitude}" s="*${user.type}" add="${user.site}" time="${user.closeOfBusiness}"
                         onclick="getUserId(this)" from_time="${user.openingHours}"
                          rel="${user.shopName}" p="${user.mobile}">
                        <em title="${user.shopName}">${user.shopName}</em>
                    </span>
                </dd>
            </#list>
        </div>
    </li>
</ul>
