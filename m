Return-Path: <SRS0=f8AC=DZ=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D91C433E7
	for <linux-wpan@archiver.kernel.org>; Sun, 18 Oct 2020 23:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E288222266
	for <linux-wpan@archiver.kernel.org>; Sun, 18 Oct 2020 23:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qQDs5njN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729694AbgJRXcN (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sun, 18 Oct 2020 19:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbgJRXcN (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 18 Oct 2020 19:32:13 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEA9C061755
        for <linux-wpan@vger.kernel.org>; Sun, 18 Oct 2020 16:32:13 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id u17so10501456oie.3
        for <linux-wpan@vger.kernel.org>; Sun, 18 Oct 2020 16:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wFVz1oodG8vEZ772ddhoCzJi/iDbmJXycexIPJOsAT4=;
        b=qQDs5njNn7OTEXyp+c0FLwbLDuSkk12Fufw3kvYUVGY3aPQw54qltgBLK3LOnXcZeE
         x1gvrP1ubfcHFJzZ4W6U/E6n8TcsxGtjZTY+sOr4Fwg/+9qt+a5ePF9zdJ9ZlxKheO9j
         QaaTOck9/DkP1icKH6jEM7KSZMU0WsWj8isKb3Zdx5VHSaCX05uRj81ycQ1r9uBB5f0f
         3tz8hHcBK75wOzxUNS7I7nC/MVB+b3ETyz6qJapA8KKpuz3EVJuIfbm1d60n5PEfC/gs
         gCAdzANFsSIviNDunwkeHB7QyL6IMlhKEIMLf3rj7M28QgRW9PHoiRHgfjE7Ztz+l141
         uZsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wFVz1oodG8vEZ772ddhoCzJi/iDbmJXycexIPJOsAT4=;
        b=fzJvsnQdI7Cs9AoGEiYp51Bp67EmQFw9b0q1yWOiob06FaCh/ktEGp/znsX8Pyznk+
         W9y+G7F8CShW/JjFN9O50hv/VpkjkK8krTl8MsRKkd8h2F/aKueZB7rZQc3LtfSCwWA1
         B2MH4STpgcBFlQqF332vJkbyfSTIqc/wYhvWS3Oh+ZjGXskCFSpHInkaeEuNNs7UjH9O
         sCw4Z95mcm4m5TfTSM9oGilfI/nqYMIFURPVRVCHqfsFczXTTN/ALavTppfSS+G/sugk
         ZMp/r7zm96FUHbr2mfXTaZOc2X1Sxu9JGQ5JdCXqfsaUJPNOjk6Zgo1sKXnz9Y1c2Ywm
         tBUA==
X-Gm-Message-State: AOAM530PpP2cZVLWlF4OYf8hiDU0THxZ9Xw1VOnrr+JfktLbR90c31JU
        i7NFyJnM1toeTSMDhK+xQU6M3E+QSf4d5E26V7PHsyXD
X-Google-Smtp-Source: ABdhPJxYFaDAFQxzV0UeooKCxHF4dr7oxd7Ub+vQWLEOl8Zq9kLNI3oJe1o4Hwzth3AlIq0o1UavH4TT/GwC9NIszLQ=
X-Received: by 2002:a05:6808:4d3:: with SMTP id a19mr9065443oie.10.1603063932782;
 Sun, 18 Oct 2020 16:32:12 -0700 (PDT)
MIME-Version: 1.0
References: <f1acad10-2fb3-a402-df58-907c2580c5ab@gmx.net> <21010.1600201310@localhost>
 <CAB_54W6S3+kf1Uowt9Y+nJVNOG4SS8GFwdd7F+6WJ8=W4Pbahg@mail.gmail.com> <9724.1600275702@localhost>
In-Reply-To: <9724.1600275702@localhost>
From:   Alexander Aring <alex.aring@gmail.com>
Date:   Sun, 18 Oct 2020 19:32:01 -0400
Message-ID: <CAB_54W786Cfox4_CLMa1SteX_xab4X1bbwBsgqb_Ok5rQBS_8w@mail.gmail.com>
Subject: Re: 6lowpan Support for Raspberry PI 3B+ - CYW43455
To:     Michael Richardson <mcr@sandelman.ca>
Cc:     Achim Kraus <achimkraus@gmx.net>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Wed, 16 Sep 2020 at 13:01, Michael Richardson <mcr@sandelman.ca> wrote:
>
>
> Alexander Aring <alex.aring@gmail.com> wrote:
>     > I tried to use BT 6LoWPAN and experienced a lot of races there, sadly
>     > nobody is fixing it. I sent a RFC some years ago to tackle these
>     > issues, also that the link-layer address is reconstructed by L3
>     > address and not by a ndisc lookup is very weird. I don't know if this
>     > is fixed or not.  However it was nothing related to the new BT mesh
>     > stuff.
>
>     >> for any BT device.  I would love to be wrong!!
>     >>
>     >> Running BTLE mesh is something I'd really like to do.
>     >> My guess is that one could probably prototype this in userspace on top of
>     >> bluez, and then use Alex' 6lowpan tap interface.
>
>     > I did not do the "6lowpan tap" interface, the bluetooth people did
>     > that and I complained about it and I never would accept this upstream.
>
> okay, what did you use to connect the OpenThread native-build processes together?
>

sorry for the late reply. This was doing L2 and above in user space,
it was the Linux driver layer only... I thought it was about using
6LoWPAN until the transport layer in kernel and link-layer in user
space.
It also had some problems with ack handling and you will not really
use Linux then, however I was always thinking about to wrap a whole
library around openthread and do some daemon to using Linux then,
instead running an OS on an OS.

- Alex
