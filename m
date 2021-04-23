Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC34C433ED
	for <linux-wpan@archiver.kernel.org>; Fri, 23 Apr 2021 15:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A51D46141C
	for <linux-wpan@archiver.kernel.org>; Fri, 23 Apr 2021 15:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243287AbhDWPAq (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 23 Apr 2021 11:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242953AbhDWPAF (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 23 Apr 2021 11:00:05 -0400
Received: from proxima.lasnet.de (proxima.lasnet.de [IPv6:2a01:4f8:121:31eb:3::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDE0C06138F
        for <linux-wpan@vger.kernel.org>; Fri, 23 Apr 2021 07:59:28 -0700 (PDT)
Received: from [IPv6:2003:e9:d72f:be76:f08b:2b88:fdb6:ca12] (p200300e9d72fbe76f08b2b88fdb6ca12.dip0.t-ipconnect.de [IPv6:2003:e9:d72f:be76:f08b:2b88:fdb6:ca12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id 1337CC0415;
        Fri, 23 Apr 2021 16:59:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
        s=2021; t=1619189965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A5hj1CYkQHpWX8gvpmHJaJvsPr9XdPFXJhjmLkETq9c=;
        b=w2J0Jh/4LaATGXD0LquZGrz5PrZvcBKqnGb3/5eqPnI1NsPxaIVrvw1Y7P8pcMTKkpN0gw
        nYq45OkVqDZbDskVWDl3utPWeBa8CfPDZR/Wg4PW8P1JEneREbJ2tKa5ZP5KiI3YRtuq4G
        jPWZmZ3oc7QW4spZ6mgnqKiUsqQ9p91MzmDlNU2maMr6SzBeb5VyAIiLThMm7luMwiv19K
        9P9/jXe+gPB+4NYmXFJnyyayzDwtOyode7Rp25yFf2rvjAEFwA+aOHFg4raVV5GsN18DZR
        YA4ttzFgT05Fsjqi/aYSU0AV0geZWU15oe/9CQ3GsgrhMKsK6+9XWDlU3ez/5A==
Subject: Re: [PATCH 2/2] net: ieee802154: fix null deref in parse key id
To:     Dan Robertson <dan@dlrobertson.com>,
        Alexander Aring <alex.aring@gmail.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>
References: <20210423040214.15438-1-dan@dlrobertson.com>
 <20210423040214.15438-3-dan@dlrobertson.com>
 <CAB_54W557gEShnirMUfa1Y0MM0ho=At-sbuW10HbY=HEAX91AQ@mail.gmail.com>
 <YILbFi7LQb40lTkP@dlrobertson.com>
From:   Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <559dae4a-ed56-c264-e0d1-4a3ea6f5e439@datenfreihafen.org>
Date:   Fri, 23 Apr 2021 16:59:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YILbFi7LQb40lTkP@dlrobertson.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello.

On 23.04.21 16:35, Dan Robertson wrote:
> On Fri, Apr 23, 2021 at 09:28:48AM -0400, Alexander Aring wrote:
>> Hi,
>>
>> On Fri, 23 Apr 2021 at 00:03, Dan Robertson <dan@dlrobertson.com> wrote:
>>>
>>> Fix a logic error that could result in a null deref if the user does not
>>> set the PAN ID but does set the address.
>>
>> That should already be fixed by commit 6f7f657f2440 ("net: ieee802154:
>> nl-mac: fix check on panid").
> 
> Ah right. I didn't look hard enough for an existing patch :) Thanks!
> 
>   - Dan
> 

Dropped from my patchwork queue.

regards
Stefan Schmidt
