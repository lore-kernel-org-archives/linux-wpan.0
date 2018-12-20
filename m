Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:56200 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725440AbeLTPbl (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Thu, 20 Dec 2018 10:31:41 -0500
Subject: Re: [PATCH v5 5/6] net: maclorawan: Implement maclorawan class module
References: <CAC=mGziyi1ierhg++SUcHMrq1JQ0vH4gZCKUZgchzb8aD1Rv5Q@mail.gmail.com>
 <20181216101858.9585-6-starnight@g.ncu.edu.tw>
 <20181217140233.GG2096@nanopsycho>
 <CAC=mGziN5KrXPMAXoN_hhfQrtofCeyzTr4AjbbJLOoJ+p2+Nng@mail.gmail.com>
 <60ff6940-4bcc-750c-ad38-0a183375169f@suse.de>
 <BY1PR02MB11148DBF420DCAC7CCDD8A79E7BE0@BY1PR02MB1114.namprd02.prod.outlook.com>
 <CAC=mGzg4TGCaNUbq=_kFqmF5VNFR6rWHVBwO_5Fprt0u3m1O9g@mail.gmail.com>
 <BY1PR02MB1114B352A3A73F8478AE667DE7BF0@BY1PR02MB1114.namprd02.prod.outlook.com>
From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Message-ID: <cd61fd58-02c0-8d1e-e194-cec3f0dea65c@suse.de>
Date: Thu, 20 Dec 2018 16:31:34 +0100
MIME-Version: 1.0
In-Reply-To: <BY1PR02MB1114B352A3A73F8478AE667DE7BF0@BY1PR02MB1114.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Ben Whitten <Ben.Whitten@lairdtech.com>
Cc: Jian-Hong Pan <starnight@g.ncu.edu.tw>, Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, "linux-lpwan@lists.infradead.org" <linux-lpwan@lists.infradead.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Marcel Holtmann <marcel@holtmann.org>, Dollar Chen <dollar.chen@wtmec.com>, Ken Yu <ken.yu@rakwireless.com>, linux-wpan - ML <linux-wpan@vger.kernel.org>

Am 20.12.18 um 11:19 schrieb Ben Whitten:
>>>> The hard-MAC implementations will be on my plate mostly, as both SX1276
>>>> and SX1301 need the soft-MAC.
>>>
>>> On the SX1301 side of things, the ability to send messages as a LoRaWAN
>>> node device is a niche use case, the majority if not all people will use the
>>> concentrator card as the pass through gateway to the node.
>>>
>>> In this mode of operation the parameters for transmission such as;
>> frequency,
>>> spreading factor / data rate, power, are given by a remote server and passed
>>> in from the userspace application which received it.
>>> Eventually in the kernel these need to be checked locally to ensure
>> regulatory
>>> compliance.
>>> To that end I have experimented with framing, as CAN does, so that this
>>> metadata can be provided on a write from userspace to the SX1301 driver.
>>>
>>> Sounds like we need different protocols for framing within the protocol
>> family.
>>> Raw in the case of nodes and framed with metadata in the case of
>> concentrator
>>> cards, thoughts?
>>
>> Yes, I have thought the roles of node and gateway.  They may have
>> different skb passing paths.
>> As you mentioned, many things of the gateway is controlled by the
>> remote server.  So, I only implement the path for nodes right now.
>> Maybe, we can have a role flag: node, gateway which can be assigned by
>> some way.  Then, the skb can be decode, checked and passed according
>> to the role flag.  And module also checks the integrity (MIC, length
>> ...) and filter out the bad skb before sends to next stop.
> 
> As IP have IPPROTO_TCP, IPPROTO_UDP, etc maybe we can have
> LORA_PROTO_MODULE, LORA_PROTO_GATEWAY which dictates the
> pathway and skb format.

No, please don't. You were on track with your earlier comment: The user
decides what he wants to do by selecting PF_LORAWAN with
SOCK_DGRAM/_SEQPACKET vs. SOCK_RAW (or PF_PACKET with ETH_P_LORA[WAN]).

The terminology "gateway" has little to do with it. I've heard of packet
forwarders using JSON format for communication with their backend, so it
appears to highly depend on what exactly the gateway wants to do and how
the user wants to access the needed data.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
