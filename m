Return-Path: <SRS0=reTu=IG=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E49C433E0
	for <linux-wpan@archiver.kernel.org>; Mon,  8 Mar 2021 13:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 223BF651C2
	for <linux-wpan@archiver.kernel.org>; Mon,  8 Mar 2021 13:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhCHNuJ (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 8 Mar 2021 08:50:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhCHNtl (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 8 Mar 2021 08:49:41 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6B8C06174A;
        Mon,  8 Mar 2021 05:49:41 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id 18so7191272pfo.6;
        Mon, 08 Mar 2021 05:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=eQwRtbX/qelnXJ0mD+nXyW4BoJMODIcVPIEa9An6gk0=;
        b=a4wFIWeG1QUK/t916dCxk2t6szKETTA50kuDRj+1p0f88ahZmapC7Syh9Za0Ecg/y/
         x9WtAQSS4CU50BKPfFZiBYQJ7nwLHqwYqcler+0KQMa80Sn9ecZ1/pbsQAUQRxo44pG4
         HADukWENMV3CF2+b4ocXxgdQIZvmVnGf5W87REoIZqEpyfcPTW/hkuLh4MeUrY3d6vVQ
         OQwniZkrWjvBvh/NCe8dTcownj0ln4toqKfWK0KercmQBPvLyyUF5GE/G8yqaQwB76hi
         0TZwLls0QawfMjso1Wwre0oJH6N6kTVxV5ul0MCuqmkcQYZNkTuJ+g6t9DbbR2yBTN8X
         QMkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=eQwRtbX/qelnXJ0mD+nXyW4BoJMODIcVPIEa9An6gk0=;
        b=pxNEF3nL7ts+kVL8KWlbKDHxUTi5/gKLdzcs7YyNlkUabI4o8lJIJtWA8mH3oUhN7y
         VSdKyyhafLfe2Aio33nqok4JfM4P/1QTZ5kahhw1xDWPcA83MWnL9VfvPLPJySOF57Pl
         PuocWZGJtQXbYl6g0qchHXfXg4e95ps4jcRGDiLZ0J98lIM7wqXwpjFJxf9SgxWGWSoj
         SU+ugYSP/R9oKR7/QgLbiqy3g8JmEoLlgb/ZjfJXe98rfPUlL/7QnIaR43duuvXeFiR3
         MpP/rGQ8c1om7BEuhCJXUg0dclV3A2Z1vUnd+l+/t5kdQ7FvoboGC2RMEEPsavkQE6n1
         bROw==
X-Gm-Message-State: AOAM5305GffW3k5FWvk/jg2s8UoeUTC6zFVYTH74uikFq4EsAWYf79Le
        LW7rCCo2Wzpf+6BMfo87mu0=
X-Google-Smtp-Source: ABdhPJx/kVgWyUbCGPDo//gH2mvskgWuJMfVClUx4f/UQqbkkLDzzT68sVSr14caqVml/eM9kgtw/A==
X-Received: by 2002:a63:5a0c:: with SMTP id o12mr20332952pgb.76.1615211380571;
        Mon, 08 Mar 2021 05:49:40 -0800 (PST)
Received: from [10.98.0.110] ([45.135.186.97])
        by smtp.gmail.com with ESMTPSA id o3sm10076476pgm.60.2021.03.08.05.49.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Mar 2021 05:49:40 -0800 (PST)
Subject: Re: [PATCH] net: ieee802154: fix error return code of dgram_sendmsg()
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, alex.aring@gmail.com,
        davem@davemloft.net, kuba@kernel.org, stefan@datenfreihafen.org
References: <20210308093106.9748-1-baijiaju1990@gmail.com>
 <d373b42c-0057-48b3-4667-bfa53a99f040@gmail.com>
 <3634b7c6-340b-3d6d-ccce-c2a95319ca9e@gmail.com>
 <44ee06c9-b99c-8758-a045-ea7d17a6dbf3@gmail.com>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <39964925-e95a-6844-afeb-2d995a8a3afd@gmail.com>
Date:   Mon, 8 Mar 2021 21:49:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <44ee06c9-b99c-8758-a045-ea7d17a6dbf3@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org



On 2021/3/8 21:33, Heiner Kallweit wrote:
> On 08.03.2021 13:18, Jia-Ju Bai wrote:
>>
>> On 2021/3/8 18:19, Heiner Kallweit wrote:
>>> On 08.03.2021 10:31, Jia-Ju Bai wrote:
>>>> When sock_alloc_send_skb() returns NULL to skb, no error return code of
>>>> dgram_sendmsg() is assigned.
>>>> To fix this bug, err is assigned with -ENOMEM in this case.
>>>>
>>> Please stop sending such nonsense. Basically all such patches you
>>> sent so far are false positives. You have to start thinking,
>>> don't blindly trust your robot.
>>> In the case here the err variable is populated by sock_alloc_send_skb().
>> Ah, sorry, it is my fault :(
>> I did not notice that the err variable is populated by sock_alloc_send_skb().
>> I will think more carefully before sending patches.
>>
>> By the way, I wonder how to report and discuss possible bugs that I am not quite sure of?
>> Some people told me that sending patches is better than reporting bugs via Bugzilla, so I write the patches of these possible bugs...
>> Do you have any advice?
>>
> If you're quite sure that something is a bug then sending a patch is fine.
> Your submissions more or less all being false positives shows that this
> takes more than just forwarding bot findings, especially if you have no
> idea yet regarding the quality of the bot.
> Alternatively you can contact the maintainer and respective mailing list.
> But again, maintainers typically are very busy and you should have done
> all you can to analyze the suspected bug.
>
> What I'd do being in your shoes:
> Take the first 10 findings of a new bot and analyze in detail whether
> findings are correct or false positives. Of course this means you
> need to get familiar with the affected code in the respective driver.
> If false positive ratio is > 5% I wouldn't send out patches w/o more
> detailed analysis per finding.
>
> Worst case a maintainer is busy and can't review your submission in time,
> and the incorrect fix is applied and breaks the driver.
> Typically this shouldn't happen however because Dave/Jakub won't apply
> a patch w/o Ack from the respective maintainer.
>
> Disclaimer:
> I can only speak for myself. Other maintainers may see this differently.

Okay, thanks a lot for the very helpful advice :)
I will carefully check the bug report and try my best to write correct 
patches.


Best wishes,
Jia-Ju Bai
