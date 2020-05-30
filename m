Return-Path: <SRS0=4IKq=7M=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3971C433DF
	for <linux-wpan@archiver.kernel.org>; Sat, 30 May 2020 11:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 993F820776
	for <linux-wpan@archiver.kernel.org>; Sat, 30 May 2020 11:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbgE3LeC (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sat, 30 May 2020 07:34:02 -0400
Received: from proxima.lasnet.de ([78.47.171.185]:44762 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728304AbgE3LeB (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sat, 30 May 2020 07:34:01 -0400
Received: from localhost.localdomain (p200300e9d73e5028ff9ac83b7a5b2645.dip0.t-ipconnect.de [IPv6:2003:e9:d73e:5028:ff9a:c83b:7a5b:2645])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id B416BC234D;
        Sat, 30 May 2020 13:33:54 +0200 (CEST)
Subject: Re: wpanusb?
To:     Christopher Friedt <chrisfriedt@gmail.com>
Cc:     linux-wpan@vger.kernel.org
References: <CAF4BF-SFHA=mPHLxpDHGMLvgu0UKO-6ujfYB+n2a6=XhFvT6DA@mail.gmail.com>
 <b009a2a8-64a5-fe66-a53e-5a93135cf1f8@datenfreihafen.org>
 <CAF4BF-SNRyXQzUBqx5k014nZou4q7=Gd8=dbUyK7JiDkaEEvFA@mail.gmail.com>
From:   Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <f98b4515-9570-ad48-2d8f-dcc5482a21a1@datenfreihafen.org>
Date:   Sat, 30 May 2020 13:33:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAF4BF-SNRyXQzUBqx5k014nZou4q7=Gd8=dbUyK7JiDkaEEvFA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello.

On 29.05.20 21:33, Christopher Friedt wrote:
> Hi Stefan!
> 
> On Tue, May 26, 2020 at 3:38 PM Stefan Schmidt
> <stefan@datenfreihafen.org> wrote:
>> On 25.05.20 14:39, Christopher Friedt wrote:
>>> Hi all,
>>>
>>> Bouncing around a bit, but in Zephyr, there is reference to a
>>> "wpanusb" Linux kernel driver here:
>>>
>>> https://docs.zephyrproject.org/latest/samples/net/wpanusb/README.html
>>>
>>> This *might* be the driver in question:
>>>
>>> https://github.com/finikorg/wpanusb
>>>
>>> Just wondering if anyone has made any attempts to submit that, or
>>> would that go directly upstream these days?
>>
>> I had a chance to talk to the author a while back. Not much activity
>> from his side.
> 
> I was chatting with him as well on Zephyr Slack and let him know that
> there was significant interest in it going upstream. I worry though
> that it might not be a high priority for his employer.
> 
> Is there a linux-wpan IRC? Would be nice to chat in real-time at some point.

#linux-wpan at Freenode :-)

>> For me this needs to be designed in a way where we could have bare
>> metal, Zephyr, RIOT or Contiki based firmware implementing the interface
>> and the driver would just work. The code available is a good start but
>> needs more work.
> 
> I agree mostly. Of course each RTOS has their own headers, way of
> declaring things, etc, but for the most part it could be platform
> independent.

I would still expect that each RTOS has their own firmware to adapt 
their ieee802154 abstraction and supported hw to the generic wpanusb 
driver. The USB interface they expose would be the same, and behave the 
same though.

>> I was, and somehow still am, planning on working on this. But with the
>> world turned upside down there was always something else to look at
>> before. Its on my list, just not very high. If anyone wants to have a
>> stab at this feel free and let me know.
> 
> I'll bring it up in the Zephyr Slack. They want to incorporate it into
> their "tools" repository, but it really should go into Linux at some
> point.

I agree.

> We'll probably end up working on this for BB.O - even just having a
> single driver that works for all boards in Zephyr is a pretty large
> step.

If work is going on for this and you are getting an idea on the level of 
abstraction I would be happy to discuss how this should result in a 
generic wpanusb driver.

> Lastly, I feel like this is a recurring question, but a number of us
> will likely need a bunch of 802.15.4 USB dongle to speak to our 15.4
> nodes. I have a couple of ATUSB on my desk, but are there others in
> our group that don't have any idea where to get parts, and likely
> building one from scratch would be more time than they want to take.
> 
> Do you know of an off-the-shelf product that works with existing
> drivers upstream?

ATUSB are still being produced and sold:
http://shop.sysmocom.de/products/atusb

Sysmocom is doing small batches (100-200 pieces) whenever their stock 
goes low. The price is not really making money for them and is mostly 
covering their expenses. Its one of their many contributions to help 
Open Source projects with hardware. (As you most likely can read from 
this I am _very_ happy they are handling all the hardware manufacturing 
and logistics for this).

I am flashing every single one of these atusb's by hand as well (for 
free, just to keep the supply alive). :-)

The available CC2531 dongles would be available for ~10 USD from China, 
but there is no driver support (it would be a perfect candidate for the 
wpanusb driver with a bare-metal firmware).

If the need it not USB but SPI there are plenty to choose from.

regards
Stefan Schmidt
