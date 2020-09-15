Return-Path: <SRS0=wjm+=CY=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51FB0C433E2
	for <linux-wpan@archiver.kernel.org>; Tue, 15 Sep 2020 22:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B6E720809
	for <linux-wpan@archiver.kernel.org>; Tue, 15 Sep 2020 22:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5CCe/cs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbgIOWIF (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 15 Sep 2020 18:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728122AbgIOWHV (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 15 Sep 2020 18:07:21 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB70C061788
        for <linux-wpan@vger.kernel.org>; Tue, 15 Sep 2020 15:07:20 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id x69so5689597oia.8
        for <linux-wpan@vger.kernel.org>; Tue, 15 Sep 2020 15:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6gaA2gF0K2Qy2FxnQy1g4sbMF8jQE2gDwQ1iWtX+Xu0=;
        b=B5CCe/cspAQAQW68h3MhR0DDVUbD0t0zk4ieGN0mDm3seEsFTxv/0LyPiH/lSRV9qD
         7ghzgPUUAdnMIjLLIYVGRZgglI1l3ML3NKoHJ/tjbJxHgc9Y1uCPyW8bSTK8X5sYEMt5
         QyriVdbeg13O4rcjGS/6OV+TR/+Pcr55BcJpWSMHTH2IrPLUsoslPfDtvWFn2sqwy45h
         KxaN79sSgInG3KfYAXbwpph8XqC17ncCqA6AjI3hIxDLrPGaulq9FzX3MfaQ+tJyBseD
         R80tGlPpjFYQdclsB1bD+Fir4HLAeJ512bHYg5qGjQGMn67TbxruEMCTJt2BYwDZr9/z
         UUPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6gaA2gF0K2Qy2FxnQy1g4sbMF8jQE2gDwQ1iWtX+Xu0=;
        b=XX2p1JAqMC4VQVbpBVxol+chPbkvTrVxwhp+AXuOR9ouW2zgE1wpv2nId/vWQ2fqYR
         Q4c4rvzihlNj/O0pJhSlzmJqkhczz4RWDZNuMxGukWA7xrlDyHvPgjU1EPjQs1g7TR7B
         trbVndCgWyrbtlNhTgP7ZAd5YllIQjiMIWtTw8W4xIUoKT3nlAbPHCe66myIa53nbXbZ
         5shYqO3EJsqbnh5mT/uR6ZYZHGzEkHYeVWJ1VtLosLYb9DeWneM38k0L4LBiL5A95qsb
         XNGhde0wLdUDYD6c35gAZFMsotZK9UjHdSDM6j5CECOGyA2pkjyw/YXDyaTkxqDfkv8c
         allg==
X-Gm-Message-State: AOAM531RfvTkaGW55WcL5GfD20Byp8508tixULSqJdo/4BiNaKsVG1n3
        +lHO+gLQgft0Z7TLqTM73IE9mYgjK0y6hrYRgm4=
X-Google-Smtp-Source: ABdhPJyMLKw2G9p4BQXE3G86Mszkc/Hm1wwZ5rcJog0rOypBT9GFEuxGn3+k4WS7HkWvX01w2Hs+L60QL1B0dyMfP5o=
X-Received: by 2002:aca:4894:: with SMTP id v142mr1073684oia.157.1600207640237;
 Tue, 15 Sep 2020 15:07:20 -0700 (PDT)
MIME-Version: 1.0
References: <f1acad10-2fb3-a402-df58-907c2580c5ab@gmx.net> <21010.1600201310@localhost>
In-Reply-To: <21010.1600201310@localhost>
From:   Alexander Aring <alex.aring@gmail.com>
Date:   Tue, 15 Sep 2020 18:07:08 -0400
Message-ID: <CAB_54W6S3+kf1Uowt9Y+nJVNOG4SS8GFwdd7F+6WJ8=W4Pbahg@mail.gmail.com>
Subject: Re: 6lowpan Support for Raspberry PI 3B+ - CYW43455
To:     Michael Richardson <mcr@sandelman.ca>
Cc:     Achim Kraus <achimkraus@gmx.net>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wpan-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Tue, 15 Sep 2020 at 16:35, Michael Richardson <mcr@sandelman.ca> wrote:
>
>
> Achim Kraus <achimkraus@gmx.net> wrote:
>     > it seems to be possible for the hardware, but I could not find hints,
>     > that it is working with the software. According
>
>     > https://linux-wpan.org/hardware
>
>     > it's not listed, but the nrf52840 is also not listed (but working with
>     > the openthread setup from nordic).
>
>     > So:
>     > Does someone have tried to use a Raspberry PI 3B+ native CYW43455 for
>     > 6lowpan?
>
> I don't think anyone has done RFC7668
>   _IPv6 over BLUETOOTH(R) Low Energy_
>

I tried to use BT 6LoWPAN and experienced a lot of races there, sadly
nobody is fixing it. I sent a RFC some years ago to tackle these
issues, also that the link-layer address is reconstructed by L3
address and not by a ndisc lookup is very weird. I don't know if this
is fixed or not.  However it was nothing related to the new BT mesh
stuff.

> for any BT device.  I would love to be wrong!!
>
> Running BTLE mesh is something I'd really like to do.
> My guess is that one could probably prototype this in userspace on top of
> bluez, and then use Alex' 6lowpan tap interface.

I did not do the "6lowpan tap" interface, the bluetooth people did
that and I complained about it and I never would accept this upstream.
It basically was working to "map" bluetooth link-layer addresses to an
ethernet interface (remember in Linux world TAP is an ethernet
specific interface only). Then the code was somewhat doing parsing the
ethernet link-layer addresses to feed the bt 6lowpan decompression
algorithm.
This might work until there is any draft which wants more than just
link-layer addresses from L2 header, I think you would agree here?
There are also corner cases that a bluetooth address is not an
ethernet address...

I am not against a "tap like" interface, but then the whole L2 header
needs to feed to a, I name it "generic tap" interface from userspace
(only describe receiving side, it's easier).

I _think_ we also need to have not just L2 headers... all layers below
6LoWPAN adaptation because the compression can use _any_ of this
information. You agree?

However, basically when people talk about TAP/TUN 6lowpan interfaces
my thoughts are:

6LoWPAN TAP:

Ethernet specific, need to be a generic TAP interface to feed all
layers below 6lowpan to kernel space/from kernel space. Ideal would be
that the kernel 6lowpan stack creates/receives all layers below
6lowpan... but then such interface makes no sense because it will
require a kernel stack for all these layers and you want to run these
in user space.
I think about an own header format which describes "6lowpan parameters
for everything to do in layers 6lowpan and above". Each is adaptation
specific, I would like to see a draft about that! It's not the full
info of all layers below, only the one what the upper-layer (6lowpan,
etc) needs.

That is for me the only thing that makes sense for me...

6LoWPAN TUN:

That wording makes no sense, TUN is RAW IPv6, there can't be RAW
6LoWPAN without having information below that, see 6LoWPAN TAP.

- Alex
