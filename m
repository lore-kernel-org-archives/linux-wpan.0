Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54624C433E0
	for <linux-wpan@archiver.kernel.org>; Wed,  3 Mar 2021 03:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DD8064E6F
	for <linux-wpan@archiver.kernel.org>; Wed,  3 Mar 2021 03:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350009AbhCCDlV (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 2 Mar 2021 22:41:21 -0500
Received: from proxima.lasnet.de ([78.47.171.185]:37508 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382352AbhCBVpr (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 2 Mar 2021 16:45:47 -0500
Received: from [IPv6:2003:e9:d72a:21a0:8b4a:5ec4:afc4:817c] (p200300e9d72a21a08b4a5ec4afc4817c.dip0.t-ipconnect.de [IPv6:2003:e9:d72a:21a0:8b4a:5ec4:afc4:817c])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id 68498C07F4;
        Tue,  2 Mar 2021 22:45:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
        s=2021; t=1614721504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jxEb6AzB4Hi58jqmVNIl9Zsljq62e2w8j1ymEKI1zLE=;
        b=GsuNc//hjk3gmxmB/bAC4o3j+AMEFaotT6lIXcs91jawxmXXqUTlBvklujchB4EuHmtyrf
        cHVWRaNNz2zV+MXrHH/9aOuDGVWXJL3zw321uN2F+qdpepQsoonEX2VnVF2zstNuioxe+u
        pg7Rhtq+mXkDfYeOI3OYewJNQIDvucbN9//E90qzDltGFR+4Xl05037ZRrp7EgQcidcSgV
        6HPgfn4U4AIWudcBc3f41biKu97oH61/joNNs1eAUxM4ZOwUPIsdc1VZJYhZhjcvwO59WE
        iNc8eJKfXytlhb7IROPSzDnY2XFStp7IHSJIg0Zf95nCGGowlUcOIc9OjZpFDQ==
Subject: Re: [PATCH wpan 04/17] net: ieee802154: forbid monitor for set llsec
 params
To:     Alexander Aring <aahringo@redhat.com>
Cc:     linux-wpan@vger.kernel.org, netdev@vger.kernel.org
References: <20210228151817.95700-1-aahringo@redhat.com>
 <20210228151817.95700-5-aahringo@redhat.com>
From:   Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <f4599ca2-31c3-a08e-fad8-444f35cc6f6b@datenfreihafen.org>
Date:   Tue, 2 Mar 2021 22:45:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210228151817.95700-5-aahringo@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello Alex.

On 28.02.21 16:18, Alexander Aring wrote:
> This patch forbids to set llsec params for monitor interfaces which we
> don't support yet.
> 
> Reported-by: syzbot+8b6719da8a04beeafcc3@syzkaller.appspotmail.com
> Signed-off-by: Alexander Aring <aahringo@redhat.com>
> ---
>   net/ieee802154/nl802154.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
> index 3ee09f6d13b7..67f0dc622bc2 100644
> --- a/net/ieee802154/nl802154.c
> +++ b/net/ieee802154/nl802154.c
> @@ -1384,6 +1384,9 @@ static int nl802154_set_llsec_params(struct sk_buff *skb,
>   	u32 changed = 0;
>   	int ret;
>   
> +	if (wpan_dev->iftype == NL802154_IFTYPE_MONITOR)
> +		return -EOPNOTSUPP;
> +
>   	if (info->attrs[NL802154_ATTR_SEC_ENABLED]) {
>   		u8 enabled;
>   
> 

I am fine with this patch and all the rest up to 17. They just do not 
apply for me with 1 and 2 left out and only 3 applied.

Could you resend 3-17 as a series and we can discuss 1 & 2 separately?

regards
Stefan Schmidt
