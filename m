Return-Path: <SRS0=aDGC=7U=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FD6C433E0
	for <linux-wpan@archiver.kernel.org>; Sun,  7 Jun 2020 12:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 076F02064C
	for <linux-wpan@archiver.kernel.org>; Sun,  7 Jun 2020 12:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbgFGMRU (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sun, 7 Jun 2020 08:17:20 -0400
Received: from proxima.lasnet.de ([78.47.171.185]:52474 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbgFGMRU (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 7 Jun 2020 08:17:20 -0400
Received: from localhost.localdomain (p200300e9d7315a641eb0dd42bd7fb6d2.dip0.t-ipconnect.de [IPv6:2003:e9:d731:5a64:1eb0:dd42:bd7f:b6d2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id 4983AC051E;
        Sun,  7 Jun 2020 14:17:13 +0200 (CEST)
Subject: Re: wpanusb?
To:     Koen Zandberg <koen@bergzand.net>,
        Christopher Friedt <chrisfriedt@gmail.com>
Cc:     linux-wpan@vger.kernel.org,
        Andrei Emeltchenko <andrei.emeltchenko@intel.com>
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
Message-ID: <8ddb855b-e9fb-6fb2-cb1f-38a7b7064683@datenfreihafen.org>
Date:   Sun, 7 Jun 2020 14:17:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <0ccbc151-cf8e-cd56-28f8-f1594d226056@bergzand.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hallo.

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

That sounds fine to me. Adrei, what do you think about this change?

>>
>> o Add a GET_EXTENDED_ADDR command to receive the extended address
>> provided by the transceiver itself, or firmware in some way.
> +1
>>
>> o Adding a GET_CAPABILITIES command to query device capabilities
>>   during init to enable and set needed ieee802154_ops based on the
>> device. Given that we aim to support as many transceivers as possible
>> we can't rely on static device knowledge to configure wpanusb correctly.
> Does it make sense to include also a "protocol" version here, to allow
> extending the feature set of the driver later without causing
> compatibility issues between the firmware and the kernel?

I was hoping that we could cover what we need with the current spec and 
we could just add more capability flags for new things. We could got the 
full way to have a protocol version during the init as well.

>>
>> o Add opcode for set_lbt in USB spec
> This requires some clarification for me how the radio should be
> configured. Is this just a CSMA/CCA switch?

 From what I have seen this listen before talk is often (always?) a 
hardware feature of sub GHz (where its needed) transceivers. I would 
assume this just makes sure we pass the config from linux stack through 
the driver to the firmware.

>>
>> o Add opcode for set_frame_retries USB spec. (If a transceiver does
>> not support AutoACK in hardware do Zephyr and RIOT support a software
>> fallback to handle AutoACK?)
> This can be implemented in RIOT. I don't think there is something in
> place at the moment, most of our radios support this in hardware, but I
> see no technical reason why not to support this.

Good

>>
>> o How are we going to handle transceiver which allow MTUs > 127? Not a
>> high priority as the kernel part does not support this either right now.
> There is some preliminary support for 802.15.4g radios in RIOT. I know
> some developers that would prefer not to have to have the MTU limited to
> 127 bytes :)

While we do not support this in the Linux stack yet, we should still 
make sure the spec here is capable of supporting this.

>>
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

Hmm, we do not have that. But getting the info from the firmware would 
be useful.


>   - Ack config settings
>   - CCA and CSMA configuration, enabling/disabling, retries and backoff
> exponent (max/min)
>   - CCA threshold and mode

Is there a way to the device in promiscuous mode?

> 
> Furthermore, it is possible to get frame metadata such as the received
> signal strength and the number of retries required for the frame

Currently the spec only covers LQI, but getting extra stats on the 
reliability could bring in some extra benefit for routing decisions.

> transmit. All these settings depend a bit on the radio hardware features
> of course, but thats what we have the GET_CAPABILITIES for.

Yes, exactly, with the capabilities we get during init from the firmware 
it can be signalled what it supports and we would enable the needed 
device ops for the Linux stack ased on this.

regards
Stefan Schmidt
