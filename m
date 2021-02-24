Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308B5C433E0
	for <linux-wpan@archiver.kernel.org>; Wed, 24 Feb 2021 15:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6A1060241
	for <linux-wpan@archiver.kernel.org>; Wed, 24 Feb 2021 15:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbhBXPPO (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Wed, 24 Feb 2021 10:15:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237389AbhBXNkR (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 24 Feb 2021 08:40:17 -0500
Received: from proxima.lasnet.de (proxima.lasnet.de [IPv6:2a01:4f8:121:31eb:3::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF531C06178B;
        Wed, 24 Feb 2021 05:38:52 -0800 (PST)
Received: from [IPv6:2003:e9:d72b:2a0f:18df:1c4d:541:33a8] (p200300e9d72b2a0f18df1c4d054133a8.dip0.t-ipconnect.de [IPv6:2003:e9:d72b:2a0f:18df:1c4d:541:33a8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id 1BFC6C056C;
        Wed, 24 Feb 2021 14:38:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
        s=2021; t=1614173931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xefk2pAULhAC+MPw3uNOF/vTixpSOHMgRJgcdVP7rU4=;
        b=BGQurs3aC+FTrRnkUZaFV4DCArK0pHvZrklIZ/ZP0OKThE40YmyTE+kwsQLG22iN+lf9xp
        ybv0mo+jJxJacSq7xlXdmake9VArZdM2KpCr0XxBVNil9ENixNrVv2uQz3ejiMkXjk3AlL
        PIddCEVJAf5w49PDxMxYqfHdlWbrbtMTwgaplsCKAG59UpFQR9Zy4kdJzMyIKtQ8Jk64kL
        efts159gescdWFM6zTaJJnd0INk6t9D0oKXpfRk2BXOzlEGliodlnQ3pZZiyPpPA4ahph3
        bQLhQ3043DTEGMhEveYe86ayMBeoknYP6HdxAK1QzAapW8Tdn0NExjLIIZ7fuw==
Subject: Re: [PATCH wpan 3/4] net: ieee802154: fix nl802154 add llsec key
To:     Alexander Aring <aahringo@redhat.com>
Cc:     linux-wpan@vger.kernel.org, netdev@vger.kernel.org
References: <20210221174321.14210-1-aahringo@redhat.com>
 <20210221174321.14210-3-aahringo@redhat.com>
From:   Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <fe2296ea-59df-e8de-e60d-521597c134fa@datenfreihafen.org>
Date:   Wed, 24 Feb 2021 14:38:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210221174321.14210-3-aahringo@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello.

On 21.02.21 18:43, Alexander Aring wrote:
> This patch fixes a nullpointer dereference if NL802154_ATTR_SEC_KEY is
> not set by the user. If this is the case nl802154 will return -EINVAL.
> 
> Reported-by: syzbot+ce4e062c2d51977ddc50@syzkaller.appspotmail.com
> Signed-off-by: Alexander Aring <aahringo@redhat.com>
> ---
>   net/ieee802154/nl802154.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
> index 063b12cba71f..3f6d86d63923 100644
> --- a/net/ieee802154/nl802154.c
> +++ b/net/ieee802154/nl802154.c
> @@ -1544,7 +1544,8 @@ static int nl802154_add_llsec_key(struct sk_buff *skb, struct genl_info *info)
>   	struct ieee802154_llsec_key_id id = { };
>   	u32 commands[NL802154_CMD_FRAME_NR_IDS / 32] = { };
>   
> -	if (nla_parse_nested_deprecated(attrs, NL802154_KEY_ATTR_MAX, info->attrs[NL802154_ATTR_SEC_KEY], nl802154_key_policy, info->extack))
> +	if (!info->attrs[NL802154_ATTR_SEC_KEY] ||
> +	    nla_parse_nested_deprecated(attrs, NL802154_KEY_ATTR_MAX, info->attrs[NL802154_ATTR_SEC_KEY], nl802154_key_policy, info->extack))
>   		return -EINVAL;
>   
>   	if (!attrs[NL802154_KEY_ATTR_USAGE_FRAMES] ||
> 

This patch has been applied to the wpan tree and will be
part of the next pull request to net. Thanks!

regards
Stefan Schmidt
