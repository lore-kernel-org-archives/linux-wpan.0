Return-Path: <SRS0=gm5i=BD=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75706C433E0
	for <linux-wpan@archiver.kernel.org>; Fri, 24 Jul 2020 13:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59683206D8
	for <linux-wpan@archiver.kernel.org>; Fri, 24 Jul 2020 13:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbgGXNlv (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 24 Jul 2020 09:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726235AbgGXNlv (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 24 Jul 2020 09:41:51 -0400
X-Greylist: delayed 887 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 24 Jul 2020 06:41:50 PDT
Received: from proxima.lasnet.de (proxima.lasnet.de [IPv6:2a01:4f8:121:31eb:3::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8C8C0619D3
        for <linux-wpan@vger.kernel.org>; Fri, 24 Jul 2020 06:41:50 -0700 (PDT)
Received: from localhost.localdomain (p200300e9d737162aa82ed0ab184b2e96.dip0.t-ipconnect.de [IPv6:2003:e9:d737:162a:a82e:d0ab:184b:2e96])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id 12EDBC234F;
        Fri, 24 Jul 2020 15:41:49 +0200 (CEST)
Subject: Re: wpanusb?
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
From:   Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <6d787a84-56ba-2dcf-af5c-6f05cec6194a@datenfreihafen.org>
Date:   Fri, 24 Jul 2020 15:41:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <0ccbc151-cf8e-cd56-28f8-f1594d226056@bergzand.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello.

[Added Erik here to be part of the discussion]

This mostly goes to Koen and Erik. Please coordinate how you are wanting 
to work on this. And be pro-active. Waiting for the other one to start 
will just lead to starving :-)


I started to hack together some parts as I would do them. Really not 
working at all right now and only compile tested. I will give more 
details below. I am not sure if I will find time to work more on this 
next week before I go on vacation, so here is what I have:

https://git.kernel.org/pub/scm/linux/kernel/git/sschmidt/wpan-next.git/log/?h=wpanusb-original

Feel free to use any of it or ignore it if you have something better.
Really just my take in a really rushed break.

On 05.06.20 13:07, Koen Zandberg wrote:
> Hello
> 
> On 03-06-2020 20:18, Stefan Schmidt wrote:
>> Hello.
>>
>> Happy to see that we finally have the critical mass to get this moved
>> forward. :-)
>>
>> Here is my take on what I think needs to be done.
>>
>> On a first review I found nothing wrong with the design. It needs
>> further extending and flexibility in my opinion, though.
> I would suggest using USB bulk endpoints for both the tx and rx paths.
> An interrupt IN endpoint might be useful for events from the radio back
> to the host such as ack information from a transmit. This way we can
> keep the control messages to configuration only. This is similar to how
> USB ethernet devices are using different USB endpoints. I also see
> issues with transferring large 802.15.4g frames over control endpoints.
> Something similar like CDC-ECM would be my preference here: Split the
> frame in multiple bulk transfers and detect the end of the frame by a
> transfer size not equal to the endpoint size.

For the above I completely ignore the move to bulk. This still needs doing.

>> o Add a GET_EXTENDED_ADDR command to receive the extended address
>> provided by the transceiver itself, or firmware in some way.
> +1

My take on this is in the above branch.

>> o Adding a GET_CAPABILITIES command to query device capabilities
>>   during init to enable and set needed ieee802154_ops based on the
>> device. Given that we aim to support as many transceivers as possible
>> we can't rely on static device knowledge to configure wpanusb correctly.

I started to work on this. The real questions is are we passing all the 
frequency bands and others settings through the USB spec or are we going 
with tables for these inside the firmware and driver and only reference 
them? The later is more efficient the first one is more flexible and 
likely more extensible for future changes.


> Does it make sense to include also a "protocol" version here, to allow
> extending the feature set of the driver later without causing
> compatibility issues between the firmware and the kernel?

How about we are using the USB version part of the descriptor for this? 
We would identify a newer version device not only the spec. The device 
handling could work on both.

>>
>> o Add opcode for set_lbt in USB spec

Added a first take on this.

> This requires some clarification for me how the radio should be
> configured. Is this just a CSMA/CCA switch?
>>
>> o Add opcode for set_frame_retries USB spec. (If a transceiver does
>> not support AutoACK in hardware do Zephyr and RIOT support a software
>> fallback to handle AutoACK?)

Added a first take on this. Needs USB helper functions to handle the 
config data being passed to the device.

> This can be implemented in RIOT. I don't think there is something in
> place at the moment, most of our radios support this in hardware, but I
> see no technical reason why not to support this.
>>
>> o How are we going to handle transceiver which allow MTUs > 127? Not a
>> high priority as the kernel part does not support this either right now.
> There is some preliminary support for 802.15.4g radios in RIOT. I know
> some developers that would prefer not to have to have the MTU limited to
> 127 bytes :)

This is completely ignored for now.

>> o Do Zephyr or RIOT expose additional functionality we should support
>> here?
>>
>> o Koen, you offered to look into implementing the firmware support for
>> the USB spec in RIOT. Does the spec fit what RIOT has as abstraction
>> for ieee802154?
> 
> Yes, implementing configuration settings as USB control messages makes
> glueing them to the radio abstraction layer very easy. For now RIOT has
> configuration for:
> 
>   - reading and writing channel/page settings
>   - read/write to addresses, both long and short
>   - PAN ID
>   - TX power settings
>   - reading the max PSDU size
>   - Ack config settings
>   - CCA and CSMA configuration, enabling/disabling, retries and backoff
> exponent (max/min)
>   - CCA threshold and mode
> 
> Furthermore, it is possible to get frame metadata such as the received
> signal strength and the number of retries required for the frame
> transmit. All these settings depend a bit on the radio hardware features
> of course, but thats what we have the GET_CAPABILITIES for.

If I have time to do more work on this I will update you folks. As I 
wrote above. Read over it and feel free to use any of the above or 
implement it yourself.

Looking forward to the progress on this when back from my vacation. :-)

regards
Stefan Schmidt
