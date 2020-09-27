Return-Path: <SRS0=cNrF=DE=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18274C4346E
	for <linux-wpan@archiver.kernel.org>; Sun, 27 Sep 2020 08:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAB0F23977
	for <linux-wpan@archiver.kernel.org>; Sun, 27 Sep 2020 08:59:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgI0I7n (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sun, 27 Sep 2020 04:59:43 -0400
Received: from proxima.lasnet.de ([78.47.171.185]:53416 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgI0I7n (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 27 Sep 2020 04:59:43 -0400
Received: from localhost.localdomain (p200300e9d725e64e42f193950a5662a1.dip0.t-ipconnect.de [IPv6:2003:e9:d725:e64e:42f1:9395:a56:62a1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id 2AF33C293D;
        Sun, 27 Sep 2020 10:59:41 +0200 (CEST)
Subject: Re: wpanusb?
To:     Christopher Friedt <chrisfriedt@gmail.com>
Cc:     Koen Zandberg <koen@bergzand.net>, linux-wpan@vger.kernel.org,
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
 <71f4ce0f-5614-6410-9c8b-72a87ab7473d@datenfreihafen.org>
 <CAF4BF-TG4wpX8TdEXY=EeTz4HV0b-nceFwKb=VkFBkMjfSLPew@mail.gmail.com>
From:   Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <e75f3fd8-fa0c-7708-e914-f757965920c0@datenfreihafen.org>
Date:   Sun, 27 Sep 2020 10:59:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAF4BF-TG4wpX8TdEXY=EeTz4HV0b-nceFwKb=VkFBkMjfSLPew@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello.

On 26.09.20 14:47, Christopher Friedt wrote:
> On Sat, Sep 26, 2020 at 8:28 AM Stefan Schmidt
> <stefan@datenfreihafen.org> wrote:
>> On 24.07.20 15:41, Stefan Schmidt wrote:
>>> [Added Erik here to be part of the discussion]
>>>
>>> This mostly goes to Koen and Erik. Please coordinate how you are wanting
>>> to work on this. And be pro-active. Waiting for the other one to start
>>> will just lead to starving :-)
>>
>> With silence from both of you on this I would assume neither had time to
>> look over this. Correct?
> 
> On the contrary, Erik & I are working on it right now (although mostly
> from the Zephyr side) ;-)
> 
> We expect to have something demonstrable with the cc1352r within a
> week or 2, at which point I would very much like to work on
> upstreaming wpanusb with the additional features.

Perfect, glad to hear! If I am going to touch the wpanusb driver in my 
branch I will let you know.

> 
> In Zephyr, I recently got Sub GHz IEEE 802.15.4g running on the
> cc1352r1_launchxl. Did a fairly big overhaul of the 2.4 GHz driver as
> well. SubG should be able to run simultaneously to 2.4 GHz, and beyond
> that, the driver is written so that BLE will work concurrently at 2.4
> GHz (with arbitration).

Oh, so we need to think about having 2.4 and SubG phy's exposed in one 
wpanusb driver instance.

> I might need to send you one more dev board though for testing
> purposes, because the cc1352r requires a second chip for USB.
> BeagleBoard.org is currently preparing for manufacturing of the
> BeagleConnect which includes the cc1352 and the USB chip The official
> release date is not announced yet.

OK, fair enough.

> Also, somewhat annoying, but a shoddy USB hub damaged my ATUSB :( I
> ordered 2 more, so hopefully they get to me shortly!

Sorry to hear. :(

regards
Stefan Schmidt
