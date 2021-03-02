Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5075BC433E0
	for <linux-wpan@archiver.kernel.org>; Wed,  3 Mar 2021 03:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 041CF64E6F
	for <linux-wpan@archiver.kernel.org>; Wed,  3 Mar 2021 03:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235119AbhCCDkt (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 2 Mar 2021 22:40:49 -0500
Received: from proxima.lasnet.de ([78.47.171.185]:43404 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243409AbhCBMqt (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 2 Mar 2021 07:46:49 -0500
Received: from [IPv6:2003:e9:d72a:21a0:8b4a:5ec4:afc4:817c] (p200300e9d72a21a08b4a5ec4afc4817c.dip0.t-ipconnect.de [IPv6:2003:e9:d72a:21a0:8b4a:5ec4:afc4:817c])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id 788FEC0C3A;
        Tue,  2 Mar 2021 13:43:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
        s=2021; t=1614688997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k4cDsSMEoBl+WI1nsm3Xy99TFgQIfTj9lZa4tbXwYQg=;
        b=i0phIXFrMPbKYZp4uh/XWMcNPas1PBmISHKnsqZ3J8NcNkrIBAWM7uKgWwf4z75C2g4fZX
        1e/50XH5XR7Lu+M1HCsGwbcNXpna27+tuhhNLbrR1C8hz2m8DNQQlDfJGxcg/mau3n83Oe
        C2Ivz+oRmDjnZduJRhK7EzJD6EgwVwwrKZ5j/pzO1ShN09AIJTy6irbHOs0m/SNX7Jka5p
        ygMYc39TeIHbnOVOResj7YiPRP7bhq+EqUpNK7nZD5nGhRlCyKSo2RLnvgzEDoP6Y6b/Na
        SIIfpnKq2sOeBAt3aiShPO8cdrIt3hPTxB5mOOb/6VMJm9kUOSyZ5x1ZosJhyg==
Subject: Re: [PATCH wpan 02/17] net: ieee802154: fix memory leak when deliver
 monitor skbs
To:     Alexander Aring <alex.aring@gmail.com>,
        Alexander Aring <aahringo@redhat.com>
Cc:     linux-wpan - ML <linux-wpan@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>
References: <20210228151817.95700-1-aahringo@redhat.com>
 <20210228151817.95700-3-aahringo@redhat.com>
 <CAB_54W4Lo7TKnqWm_xH=SncTYXTrvT3JCGxTNamagPQ4e0Vs0g@mail.gmail.com>
From:   Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <1855c82f-df0b-4c72-9cfe-5eb312b6b41a@datenfreihafen.org>
Date:   Tue, 2 Mar 2021 13:43:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAB_54W4Lo7TKnqWm_xH=SncTYXTrvT3JCGxTNamagPQ4e0Vs0g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello Alex.

On 01.03.21 04:16, Alexander Aring wrote:
> Hi Stefan,
> 
> On Sun, 28 Feb 2021 at 10:21, Alexander Aring <aahringo@redhat.com> wrote:
>>
>> This patch adds a missing consume_skb() when deliver a skb to upper
>> monitor interfaces of a wpan phy.
>>
>> Reported-by: syzbot+44b651863a17760a893b@syzkaller.appspotmail.com
>> Signed-off-by: Alexander Aring <aahringo@redhat.com>
>> ---
>>   net/mac802154/rx.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
>> index b8ce84618a55..18abc1f49323 100644
>> --- a/net/mac802154/rx.c
>> +++ b/net/mac802154/rx.c
>> @@ -244,6 +244,8 @@ ieee802154_monitors_rx(struct ieee802154_local *local, struct sk_buff *skb)
>>                          sdata->dev->stats.rx_bytes += skb->len;
>>                  }
>>          }
>> +
>> +       consume_skb(skb);
> 
> Please drop this patch. It's not correct. I will look next weekend at
> this one again.
> The other patches should be fine, I hope.

Thanks for the heads up. I dropped this patch and will take a look at 
the rest of the  series today or tomorrow.

regards
Stefan Schmidt
