Return-Path: <SRS0=7WB1=7Q=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB20C433DF
	for <linux-wpan@archiver.kernel.org>; Wed,  3 Jun 2020 18:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D40620734
	for <linux-wpan@archiver.kernel.org>; Wed,  3 Jun 2020 18:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbgFCSSy (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Wed, 3 Jun 2020 14:18:54 -0400
Received: from proxima.lasnet.de ([78.47.171.185]:52968 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbgFCSSy (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 3 Jun 2020 14:18:54 -0400
Received: from localhost.localdomain (p200300e9d73e502a3bbb1ba9adfd15cb.dip0.t-ipconnect.de [IPv6:2003:e9:d73e:502a:3bbb:1ba9:adfd:15cb])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id D894DC0499;
        Wed,  3 Jun 2020 20:18:49 +0200 (CEST)
Subject: Re: wpanusb?
To:     Christopher Friedt <chrisfriedt@gmail.com>,
        Koen Zandberg <koen@bergzand.net>
Cc:     linux-wpan@vger.kernel.org,
        Andrei Emeltchenko <andrei.emeltchenko@intel.com>
References: <CAF4BF-SFHA=mPHLxpDHGMLvgu0UKO-6ujfYB+n2a6=XhFvT6DA@mail.gmail.com>
 <b009a2a8-64a5-fe66-a53e-5a93135cf1f8@datenfreihafen.org>
 <CAF4BF-SNRyXQzUBqx5k014nZou4q7=Gd8=dbUyK7JiDkaEEvFA@mail.gmail.com>
 <f98b4515-9570-ad48-2d8f-dcc5482a21a1@datenfreihafen.org>
 <CAF4BF-SipApoY=7CY8fWs8cSi8rKZaYMxOZHAqoKv=poAgVm=Q@mail.gmail.com>
 <61ffa93d-f8cf-b059-358c-84a6e04b96ac@bergzand.net>
 <CAF4BF-Re1CoR8abM=hvKN=TojDoLL_PRAJTvjWzB-Ak8tKTvRg@mail.gmail.com>
From:   Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <e5d22300-fccc-5a0f-6776-5438bfad57e1@datenfreihafen.org>
Date:   Wed, 3 Jun 2020 20:18:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAF4BF-Re1CoR8abM=hvKN=TojDoLL_PRAJTvjWzB-Ak8tKTvRg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello.

[Putting Adrei in CC as well, not sure if he is subscribed to linux-wpan]

On 31.05.20 18:13, Christopher Friedt wrote:
> Hi Koen,
> 
> On Sat, May 30, 2020 at 2:10 PM Koen Zandberg <koen@bergzand.net> wrote:
>>
>> Hello all,
>>
>> Long term RIOT maintainer here.
>>
>> I'm willing to work on this for a RIOT implementation, assuming there is
>> some documentation available on the USB protocol side :)
>> I think I should be able to get a relative generic firmware application
>> able to run on any of our hardware boards as long as they have a radio
>> and a USB interface.
> 
> That's great news!
> 
> Also, I heard from the original wpanusb author and he said he'll put
> submitting a patch any day now.

Happy to see that we finally have the critical mass to get this moved 
forward. :-)

Here is my take on what I think needs to be done.

On a first review I found nothing wrong with the design. It needs 
further extending and flexibility in my opinion, though.

o Add a GET_EXTENDED_ADDR command to receive the extended address 
provided by the transceiver itself, or firmware in some way.

o Adding a GET_CAPABILITIES command to query device capabilities
  during init to enable and set needed ieee802154_ops based on the 
device. Given that we aim to support as many transceivers as possible we 
can't rely on static device knowledge to configure wpanusb correctly.

o Add opcode for set_lbt in USB spec

o Add opcode for set_frame_retries USB spec. (If a transceiver does not 
support AutoACK in hardware do Zephyr and RIOT support a software 
fallback to handle AutoACK?)

o How are we going to handle transceiver which allow MTUs > 127? Not a 
high priority as the kernel part does not support this either right now.

o Do Zephyr or RIOT expose additional functionality we should support here?

o Koen, you offered to look into implementing the firmware support for 
the USB spec in RIOT. Does the spec fit what RIOT has as abstraction for 
ieee802154?

o Adrei, Chris, I understand it you would work on the wpanusb as well as 
the Zephyr firmware side, correct?

o I see additional use cases for a bare metal firmwares (a different fw 
to support wpanusb on the atusb device or CC2531 comes to mind). But 
none of those are critical in the beginning.

regards
Stefan Schmidt
