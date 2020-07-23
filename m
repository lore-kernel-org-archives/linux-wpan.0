Return-Path: <SRS0=qhZ0=BC=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61117C433E0
	for <linux-wpan@archiver.kernel.org>; Thu, 23 Jul 2020 08:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4709120888
	for <linux-wpan@archiver.kernel.org>; Thu, 23 Jul 2020 08:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbgGWIPo (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Thu, 23 Jul 2020 04:15:44 -0400
Received: from proxima.lasnet.de ([78.47.171.185]:37730 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbgGWIPn (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 23 Jul 2020 04:15:43 -0400
Received: from localhost.localdomain (p200300e9d73716751580db7264bb53cc.dip0.t-ipconnect.de [IPv6:2003:e9:d737:1675:1580:db72:64bb:53cc])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id 48130C25CC;
        Thu, 23 Jul 2020 10:15:41 +0200 (CEST)
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
 <8ddb855b-e9fb-6fb2-cb1f-38a7b7064683@datenfreihafen.org>
 <3993a752-bb9c-ab25-7b2f-0cbf27c2cd6a@datenfreihafen.org>
 <CAF4BF-TdLpg6hCc8iiR40tGmV9C5EPDF6c6Qr5m5CfDWOVJUMA@mail.gmail.com>
From:   Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <682cd659-c63e-1991-7c57-8804edb6e3aa@datenfreihafen.org>
Date:   Thu, 23 Jul 2020 10:15:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAF4BF-TdLpg6hCc8iiR40tGmV9C5EPDF6c6Qr5m5CfDWOVJUMA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello.

On 21.07.20 19:11, Christopher Friedt wrote:
> +Erik
> 
> Sorry for my late response.
> 
> On Mon, Jul 6, 2020 at 10:42 AM Stefan Schmidt 
> <stefan@datenfreihafen.org <mailto:stefan@datenfreihafen.org>> wrote:
> 
>     If we want this moving forward we need to push it ourselves.
>     Christopher, as you brought this up I am wondering if you have any plan
>     to work on the wpanusb driver side? Koen offered to work on the RIOT
>     side, but this does need the linux kernel driver as well.
> 
> 
> Erik is also actively looking at wpan-usb for the BeagleConnect currently.
> 
> I'm sure I could get it up to snuff. In particular, it should be 
> straight-forward to do with the nice list of TODO items that Stefan 
> outlined earlier in the thread :-) 
> [1]<https://marc.info/?t=159041047800001&r=1&w=2>

Koen will also have some time in August and expressed interest in 
working on it. I will be away on vacation first half of August. It would 
be great if you three can coordinate this a bit.

> 
>     With the other changes we discussed as changes before we should have a
>     first target of what we wanted to get implemented. (and see what we
>     forgot when the pieces are coming together)
> 
> 
> Exactly.
> 
> I had one question, specifically because it impacts the BeagleConnect 
> project, but also because it's been a while since I've done any 15.4 
> hacking in Linux.
> 
> Does Linux already support the 900 MHz phy and IEEE bits?
> 
> If possible, we're hoping to be able to use it for the 2.4 GHz band and 
> the 900 MHz band.

We have drivers for the sub-GHz band (at86rf212 and the HUL USB support 
in atusb which also uses the 212). We also have support for a 
listen-before-talk (LBT) driver operation to make that part work with 
the drivers.

To be honest I have not done sub-GHz testing myself here, but given the 
work people put into the at86rf212 support I would think it should work 
for some first tries. Reports welcome!

regards
Stefan Schmidt
