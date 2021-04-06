Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FFAC433ED
	for <linux-wpan@archiver.kernel.org>; Tue,  6 Apr 2021 20:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FD9A613D4
	for <linux-wpan@archiver.kernel.org>; Tue,  6 Apr 2021 20:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347247AbhDFUoP (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 6 Apr 2021 16:44:15 -0400
Received: from proxima.lasnet.de ([78.47.171.185]:55614 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347223AbhDFUoK (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 6 Apr 2021 16:44:10 -0400
Received: from [IPv6:2003:e9:d71d:a9d1:9fa1:9dd5:9888:d937] (p200300e9d71da9d19fa19dd59888d937.dip0.t-ipconnect.de [IPv6:2003:e9:d71d:a9d1:9fa1:9dd5:9888:d937])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id 71BA9C00BF;
        Tue,  6 Apr 2021 22:43:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
        s=2021; t=1617741839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tlgBoaL+vctmwHsEHYSEqQ5I9wqONxWSV632d4u05iE=;
        b=TIYmRswcDPiMSc3Dgwig5xnQGuPkG/h7cM78u4XkaDyMOba6gt5XBr5wSd3Yn9vgNKo8M4
        tEdX8yeb6RzTmt2twp3zKECeVHDxbBi2UVwLAYDvGSBIKz+ZdMv6DjekjVSYeVAtmQftgo
        6FJxYc8qBnkgFLQQRKGiRRfakOY36yYBAAP5LJzWoRoAYLjpDfiuZLaFDxlTnN8qtHsQix
        FiK5BRgisTmVAMOiNgjbo9/Xn1ewAWLb8uUV9xSY+0bLJfjs7n3i4648d9jx3ABcgjxpdJ
        UryqJHFHcpqYEKmjE3nQeo7aQvHpokZ0JOibP7ybKscBelXpKiHsiRRk8mh4vA==
Subject: Re: [PATCH v2] net: mac802154: Fix general protection fault
To:     Alexander Aring <alex.aring@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        syzbot+9ec037722d2603a9f52e@syzkaller.appspotmail.com
References: <CAB_54W7v1Dk9KjytfO8hAGfiqPJ6qO0SdgwDQ-s4ybA2yvuoCg@mail.gmail.com>
 <20210304152125.1052825-1-paskripkin@gmail.com>
 <CAB_54W6BmSuRo5pwGEH_Xug3Fo5cBMjmMAGjd3aaWJaGZpSsHQ@mail.gmail.com>
 <9435f1052a2c785b49757a1d3713733c7e9cee0e.camel@gmail.com>
 <CAB_54W6Js5JD126Bduf1FjDLpOiCYmLX+MZzqP9dVupSUDO8tw@mail.gmail.com>
From:   Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <151ad0e0-3502-e0a0-1651-8d1778e48de1@datenfreihafen.org>
Date:   Tue, 6 Apr 2021 22:43:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAB_54W6Js5JD126Bduf1FjDLpOiCYmLX+MZzqP9dVupSUDO8tw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello.

On 05.04.21 13:50, Alexander Aring wrote:
> Hi,
> 
> On Mon, 5 Apr 2021 at 01:45, Pavel Skripkin <paskripkin@gmail.com> wrote:
>>
>> Hi!
>>
> ...
>>>
>>
>> I forgot to check the patch with ./scripts/checkpatch.pl :(
>>
>>> Dumb question: What is the meaning of it?
>>
>> This is for gerrit code review. This is required to push changes to
>> gerrit public mirror. I'm using it to check patches with syzbot. Change
>> ids are useless outside gerrit, so it shouldn't be here.
>>
>> Btw, should I sent v2 or this is already fixed?
> 
> Otherwise the patch looks good. May Stefan can fix this.
> 
> Acked-by: Alexander Aring <aahringo@redhat.com>

I removed the Change-ID locally here.

This patch has been applied to the wpan tree and will be
part of the next pull request to net. Thanks!

regards
Stefan Schmidt
