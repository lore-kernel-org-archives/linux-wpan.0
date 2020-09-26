Return-Path: <SRS0=ZGJA=DD=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70812C2D0A8
	for <linux-wpan@archiver.kernel.org>; Sat, 26 Sep 2020 12:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 252032080C
	for <linux-wpan@archiver.kernel.org>; Sat, 26 Sep 2020 12:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="JjSeOEgh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbgIZM4y (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sat, 26 Sep 2020 08:56:54 -0400
Received: from mout.gmx.net ([212.227.17.20]:44359 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729217AbgIZM4y (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Sat, 26 Sep 2020 08:56:54 -0400
X-Greylist: delayed 306 seconds by postgrey-1.27 at vger.kernel.org; Sat, 26 Sep 2020 08:56:54 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601125013;
        bh=hKDuFYMzf0ybfRHiXA16+/7bATdQUDfOjTI8StAmkkY=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=JjSeOEghujUV9Q+c8j+0BxkN/uZEh1f46hNAm6xZPpVWL/AdPV5mc1NWK4XmY9kFL
         QVGcNAnuZ6cgDn9r9hRXGbML6xyEdi31KuGzSBqAO1HfZxbp5qqxeyUsL3Dx7SwVYw
         UImN48igCUAUGWRSA3filNEmwh1d2UxJV24G6BJU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.100] ([88.64.94.23]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MgNh1-1kvkGq3SPv-00hsrN; Sat, 26
 Sep 2020 14:51:39 +0200
Subject: Re: 6lowpan Support for Raspberry PI 3B+ - CYW43455
From:   Achim Kraus <achimkraus@gmx.net>
To:     Alexander Aring <alex.aring@gmail.com>,
        Michael Richardson <mcr@sandelman.ca>
Cc:     linux-wpan - ML <linux-wpan@vger.kernel.org>
References: <f1acad10-2fb3-a402-df58-907c2580c5ab@gmx.net>
 <21010.1600201310@localhost>
 <CAB_54W6S3+kf1Uowt9Y+nJVNOG4SS8GFwdd7F+6WJ8=W4Pbahg@mail.gmail.com>
 <a9280f74-54f0-917f-22a7-8907afd33c95@gmx.net>
Message-ID: <0d77ac6a-c90e-8113-4554-6fc3a444bea9@gmx.net>
Date:   Sat, 26 Sep 2020 14:51:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a9280f74-54f0-917f-22a7-8907afd33c95@gmx.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-AT-frami
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:m9Z9ddqXEN4Xz0UWMCRGfUVJWkHI9SUgdeMuUBbT+brpAzEijUA
 O10wMtHYRVQdChpcewbBfDQrNyyesOIynLc2ndjQrSArglFGvOymJGa4DP6gbczutgdaHSf
 cEo0hKHY5k+j/C/LZPEq3EZSTJ0ZpM8K61nbVVIsyZhd4FMe/NNR/qU7f8+zz50Kf5FZ6Da
 e22XJNVQT+lalsPNA5B0w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0eQzYxyASKI=:0jNglmSO0y5Grm35eraj9l
 0XM0o+//Pd1QZ8HX0JSU0Cbho9P9u8z5pVIht+OwpBXi1DcsamZu0v3opYc4ezJgo6fyHKV2V
 mS1/+XroZmyvpyySQJENEPpLkrkF20M3v+GYIq7hhPEvP3br4NlI005ffCi9/CoublJBQNlZK
 +XbHdQ+GpQMWFWiIRC0ni7TLS3E041xlorOZZK/pp0JVovBb9OuWID+GGUSevO0MncOmgPuQG
 OSkxE84F0Wok3JDyHjYBLJ3cc+ArotDbeEyXPPHxyOecBHgRoTH/MSM2PwRGgW5PSmlV7EJBB
 CP6w818V/KTh26Te6vZqgEjTvFrvn9McX3Zhg3hmVGGjH5KFnD8OH/qG9nGW0Dphat5aSCR54
 bnnrmvepQpXTCVQIfLYcTvrQ5FXfQcJz6XZRwWd8fhSpVRItdvcZuyLxryd9RuLO5ORLykSJy
 w/kmMJhQHlqPTMyGpgEg/WM/l+gBoApRVerbgh7dEEWpEAO9+jdzkhUeGZ6aTNfxnwPjTax5P
 BqZ5ag2p+Ap3M48FEIurh0HpBxz/JH9Nz91MMKBRoh1iQJes8fmFZM9fZCcmIsY22NPVtwwN+
 jZkPzQT62z6lSMj/uPGEJeDduP1mhcwqpCGizyEhHkbX8bZCl9hQ2xVFErc1wgBaiBZI7GBpu
 9IysK2SV2Tg4S1hGVnb7P/l9LnnSCD7vVOk5gOKBmPD6L0DbNiTcbxs1OhBfMJ7dJtU0OjHDW
 Y2K/51QYMXnOHyAYdacChuMBgY2WM1HTGKN1tKNB9wG60iK+aZDZeCk603Vs9E7RYIyNlxNKa
 yUTiW6BOgQ/+BDoHYonwr2e6naPQPqzO0MAMVLups3BbkBQ3rzcrDJufWXBfHyhrVhPVF2/px
 rZGuv90Dg5HzvnCLDrBYoneRuyqzXyRRqTABMu7jHmfi7oNO8nsUCni8XeIlB1jKy6uDNQqPe
 yVetDczcIBqMNUb1LzTM8qtKagEGxtorLgE9hcnlroRYzwnd3UA7FzTQlAC/AvE1wHyAn6y4j
 7LLNRmyrYOTUmGqEXRr5fIr3HQOp/A2TZFTrLe4DJ9ZIyh+BLkSwO9xiiA5cUfRSPQIVGDZuL
 LcH98Rn9Fr9wyGTgbnAOjoKrQrUP1WQ35sWJC8a7drGTYSYBW/uFtwDljpauywN706r5CL2qS
 4EN6QW9DFvZ2cEc8IeXUoeBYNhPAowouhDMt4fbpzNLN6vIPeTszSNsrFnyJNH1FmA699o7ES
 WWVelLMkXZ9ZsYxZrLHoNpAvJCcnd8+BM+qXiAg==
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi Alex,
Hi Michael,

after using the firmware with compliant address mapping for the
nrf52840, it starts to work.

With a linux kernel 4.15.0 stable over a couple of hours.
With a linux kernel5.4.0 or 5.4.51 it's possible to connect, but that
connection is dropped after a couple of seconds (30-40s).

So, seems, that the "old bug" is back in 5.4.

With "kernel lockdown", it seems to be not possible to connect.
At least I didn't find out how.

best regards
Achim

Am 16.09.20 um 07:38 schrieb Achim Kraus:
> Hi Alex,
>
>> I tried to use BT 6LoWPAN and experienced a lot of races there, sadly
>> nobody is fixing it. I sent a RFC some years ago to tackle these
>> issues, also that the link-layer address is reconstructed by L3
>> address and not by a ndisc lookup is very weird. I don't know if this
>> is fixed or not.=C2=A0 However it was nothing related to the new BT mes=
h
>> stuff.
>
> "a lot of races", recently? Or some time ago?
>
>>
>>> for any BT device.=C2=A0 I would love to be wrong!!
>>>
>
> Hi Michael,
>
> The current Raspi OS (based on Debian, kernel 5.4) contains a
> bluetooth_6lowpan module. With that it's possible to connect the
> nrf52840 using a "plain raspi 3b+" (without extra rf module).
>
> Unfortunately, nordic decided to provide precompile examples with the
> old, deprecated address mapping and so I need to spend some time in
> compile these examples before I can report, if it works at all, and the
> experienced stability.
>
> best regards
> Achim
>
> P.S.: though linux-wpan is not bluetooth, I hope the misuse of this list
> is still OK ;-). But I guess, moving it to the right list will alos have
> advantages. Does anyone know, which would be the proper list for that?

