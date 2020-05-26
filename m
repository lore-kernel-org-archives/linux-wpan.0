Return-Path: <SRS0=3J/k=7I=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450F2C433E1
	for <linux-wpan@archiver.kernel.org>; Tue, 26 May 2020 19:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FBB82086A
	for <linux-wpan@archiver.kernel.org>; Tue, 26 May 2020 19:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388900AbgEZTit (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 26 May 2020 15:38:49 -0400
Received: from proxima.lasnet.de ([78.47.171.185]:45134 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389149AbgEZTis (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 26 May 2020 15:38:48 -0400
Received: from localhost.localdomain (p200300e9d73e50f8e294df709518846d.dip0.t-ipconnect.de [IPv6:2003:e9:d73e:50f8:e294:df70:9518:846d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id 9C54EC022A;
        Tue, 26 May 2020 21:38:46 +0200 (CEST)
Subject: Re: wpanusb?
To:     Christopher Friedt <chrisfriedt@gmail.com>,
        linux-wpan@vger.kernel.org
References: <CAF4BF-SFHA=mPHLxpDHGMLvgu0UKO-6ujfYB+n2a6=XhFvT6DA@mail.gmail.com>
From:   Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <b009a2a8-64a5-fe66-a53e-5a93135cf1f8@datenfreihafen.org>
Date:   Tue, 26 May 2020 21:38:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAF4BF-SFHA=mPHLxpDHGMLvgu0UKO-6ujfYB+n2a6=XhFvT6DA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello.

On 25.05.20 14:39, Christopher Friedt wrote:
> Hi all,
> 
> Bouncing around a bit, but in Zephyr, there is reference to a
> "wpanusb" Linux kernel driver here:
> 
> https://docs.zephyrproject.org/latest/samples/net/wpanusb/README.html
> 
> This *might* be the driver in question:
> 
> https://github.com/finikorg/wpanusb

It is.

> 
> Just wondering if anyone has made any attempts to submit that, or
> would that go directly upstream these days?

I had a chance to talk to the author a while back. Not much activity 
from his side.

For me this needs to be designed in a way where we could have bare 
metal, Zephyr, RIOT or Contiki based firmware implementing the interface 
and the driver would just work. The code available is a good start but 
needs more work.

I was, and somehow still am, planning on working on this. But with the 
world turned upside down there was always something else to look at 
before. Its on my list, just not very high. If anyone wants to have a 
stab at this feel free and let me know.

> Hope you are well.
> 
> Incidentally, we're hoping to do a microconference at Linux Plumbers
> again this year again, virtually of course.

Feel free to keep me in the loop. Would be happy to participate again if 
time allows.

regards
Stefan Schmidt
