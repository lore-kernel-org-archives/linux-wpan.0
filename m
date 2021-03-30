Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA58C433C1
	for <linux-wpan@archiver.kernel.org>; Tue, 30 Mar 2021 07:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F031C61959
	for <linux-wpan@archiver.kernel.org>; Tue, 30 Mar 2021 07:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbhC3HiC (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 30 Mar 2021 03:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbhC3Hh3 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 30 Mar 2021 03:37:29 -0400
Received: from proxima.lasnet.de (proxima.lasnet.de [IPv6:2a01:4f8:121:31eb:3::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CA9C061762
        for <linux-wpan@vger.kernel.org>; Tue, 30 Mar 2021 00:37:28 -0700 (PDT)
Received: from [IPv6:2003:e9:d726:e14c:1577:8d47:675:6abb] (p200300e9d726e14c15778d4706756abb.dip0.t-ipconnect.de [IPv6:2003:e9:d726:e14c:1577:8d47:675:6abb])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id 9EBFAC0769;
        Tue, 30 Mar 2021 09:37:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
        s=2021; t=1617089845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yITNb4/vYCkiu/3mhGofwAOxAtAUEfHMKz+FpjwX+XU=;
        b=f5Ea85UYfF915jQt1Ve8ZL1N+CzERKTcBfnOf+ms5Q8l1WC9EQ/yaTxJzZr3myeT5aqZDf
        JuTNz+YX2gLEJIJGkkMH3NM624BMetFzg5RENf/vIzfKj/atX+mRWVzIKp2+Ze5Nd2JdaZ
        TM4wTgfiBwOH4/R+hVpKG3yiq79bkP6iFEodOSk4yADVEcTGCid6SB9U9pvzbLe/c+KEuD
        NQwb7LgU1wMuQ9zN9BsqJVxyJKT8dMB/CxZr/9GW2JSBObEo5bqfeg2ZCsvsPoCfXGVq4N
        JLnNx5YON9deGkg0zz0dJ1SNBRtZhakfDts5uMdDGtfo+1Zc5m32KeoiG7AbrQ==
Subject: Re: Plumbers / IoT MC Sep 27-29, Dublin
To:     Christopher Friedt <chrisfriedt@gmail.com>,
        linux-wpan@vger.kernel.org
References: <CAF4BF-QJ4WRgSQZUS2+amNLX5H5CyvB+C81gQrrB16eh+hqKcw@mail.gmail.com>
From:   Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <93781356-4bd7-8a9b-7e52-ecc622fc6ec2@datenfreihafen.org>
Date:   Tue, 30 Mar 2021 09:37:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAF4BF-QJ4WRgSQZUS2+amNLX5H5CyvB+C81gQrrB16eh+hqKcw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello.

On 29.03.21 17:55, Christopher Friedt wrote:
> Hi everyone,
> 
> LPC is happening Sept 27-29 this year and is tentatively scheduled to
> occur in Dublin, Ireland. However, there is a small chance it might be
> virtual again. Things were obviously very crazy for a lot of people in
> 2020 and it's continuing into 2021 for many parts of the globe, so I
> hope everyone is hanging in there.
> 
> Likely I will submit the IoT MC proposal today and I'm hopeful that it
> will be accepted again. I don't have statistics handy, but I think our
> attendance was actually up last year. Maybe being virtual actually
> helped in that regard.
> 
> In any case, I also wanted to get everyone's gears turning to inspire
> others to give a talk. I know that a number of us were working on
> wpanusb for both Zephyr & RIOT and there was some momentum to get MLME
> / MAC Layer changes in as well.
> 
> If there are any cool developments that are happening, please don't
> hesitate to reach out :-)

Looking forward to it. Let us know when the MC gets accepted. I have 
some ideas for topics starting to take shape in my head.

regards
Stefan Schmidt
