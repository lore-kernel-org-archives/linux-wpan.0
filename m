Return-Path: <SRS0=ZGJA=DD=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52324C2D0A8
	for <linux-wpan@archiver.kernel.org>; Sat, 26 Sep 2020 12:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B66C238E6
	for <linux-wpan@archiver.kernel.org>; Sat, 26 Sep 2020 12:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgIZMfI (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sat, 26 Sep 2020 08:35:08 -0400
Received: from proxima.lasnet.de ([78.47.171.185]:47580 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgIZMfI (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sat, 26 Sep 2020 08:35:08 -0400
X-Greylist: delayed 381 seconds by postgrey-1.27 at vger.kernel.org; Sat, 26 Sep 2020 08:35:07 EDT
Received: from localhost.localdomain (p200300e9d725e64e42f193950a5662a1.dip0.t-ipconnect.de [IPv6:2003:e9:d725:e64e:42f1:9395:a56:62a1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id D8A0AC22D3;
        Sat, 26 Sep 2020 14:28:45 +0200 (CEST)
Subject: Re: wpanusb?
From:   Stefan Schmidt <stefan@datenfreihafen.org>
To:     Koen Zandberg <koen@bergzand.net>,
        Christopher Friedt <chrisfriedt@gmail.com>
Cc:     linux-wpan@vger.kernel.org,
        Andrei Emeltchenko <andrei.emeltchenko@intel.com>,
        erik@statropy.com
References: <CAF4BF-SFHA=mPHLxpDHGMLvgu0UKO-6ujfYB+n2a6=XhFvT6DA@mail.gmail.com>
 <b009a2a8-64a5-fe66-a53e-5a93135cf1f8@datenfreihafen.org>
 <CAF4BF-SNRyXQzUBqx5k014nZou4q7=Gd8=dbUyK7JiDkaEEvFA@mail.gmail.com>
 <f98b4515-9570-ad48-2d8f-dcc5482a21a1@datenfreihafen.org>
 <CAF4BF-SipApoY=7CY8fWs8cSi8rKZaYMxOZHAqoKv=poAgVm=Q@mail.gmail.com>
 <61ffa93d-f8cf-b059-358c-84a6e04b96ac@bergzand.net>
 <CAF4BF-Re1CoR8abM=hvKN=TojDoLL_PRAJTvjWzB-Ak8tKTvRg@mail.gmail.com>
 <e5d22300-fccc-5a0f-6776-5438bfad57e1@datenfreihafen.org>
 <0ccbc151-cf8e-cd56-28f8-f1594d226056@bergzand.net>
 <6d787a84-56ba-2dcf-af5c-6f05cec6194a@datenfreihafen.org>
Message-ID: <71f4ce0f-5614-6410-9c8b-72a87ab7473d@datenfreihafen.org>
Date:   Sat, 26 Sep 2020 14:28:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <6d787a84-56ba-2dcf-af5c-6f05cec6194a@datenfreihafen.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello.

On 24.07.20 15:41, Stefan Schmidt wrote:
> Hello.
> 
> [Added Erik here to be part of the discussion]
> 
> This mostly goes to Koen and Erik. Please coordinate how you are wanting 
> to work on this. And be pro-active. Waiting for the other one to start 
> will just lead to starving :-)

With silence from both of you on this I would assume neither had time to 
look over this. Correct?

> I started to hack together some parts as I would do them. Really not 
> working at all right now and only compile tested. I will give more 
> details below. I am not sure if I will find time to work more on this 
> next week before I go on vacation, so here is what I have:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/sschmidt/wpan-next.git/log/?h=wpanusb-original 

If nobody else has time I will start looking into this again over the 
next weeks.

regards
Stefan Schmidt
