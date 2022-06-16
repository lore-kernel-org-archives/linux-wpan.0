Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44DB0C433EF
	for <linux-wpan@archiver.kernel.org>; Thu, 16 Jun 2022 12:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376439AbiFPM5h (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Thu, 16 Jun 2022 08:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376402AbiFPM5h (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 16 Jun 2022 08:57:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CB918A181
        for <linux-wpan@vger.kernel.org>; Thu, 16 Jun 2022 05:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655384255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PJVjgB1WV8axjnD/ZQGZ1cJuRqJKIs9CwL3dt0JUN1o=;
        b=aE2n36vB80rR6zSiU3OIefyFdNBLckLgeFFPv7Q6qoVf01D5RMpbfLEtJsCM0Huuj5SuJq
        sxAJkUgaAsQIdTqGVY++6pldLB0tNLRXLXBQp16gxtNz53vk8obJ2BFbsUWPg0KBOqS+P/
        kf+An35DITN2cxwk0593geo852mV38E=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-558-lm7v1q5UPAKOxMaDJJlRWQ-1; Thu, 16 Jun 2022 08:57:26 -0400
X-MC-Unique: lm7v1q5UPAKOxMaDJJlRWQ-1
Received: by mail-qk1-f199.google.com with SMTP id k13-20020a05620a414d00b006a6e4dc1dfcso1599269qko.19
        for <linux-wpan@vger.kernel.org>; Thu, 16 Jun 2022 05:57:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PJVjgB1WV8axjnD/ZQGZ1cJuRqJKIs9CwL3dt0JUN1o=;
        b=iH84RsRuG3OZDkc2tQWegdv9puWaQ39Abgf6RaQ2MT9xDOQaA+dgaRCAavQqkfMZko
         xGzBagCFzTM69z+tBPXw8ya1+H8Z3Ie2b0q6s5N0RXNUv+hp5BmnjwR4jBfuqk54XeX9
         Pc2p/f7fc85oSaKrOcBp6kqth7Ue4wMdvvPSGIFQcnzl06h6h46/iJIR21VL4M6E3IRN
         h1LHCmt0dlUjLk6QqnC9LPmIIZ9LBfUww03e3iRlMFpbml3EdvtDQcd2ZGNwB64ddfg1
         pJaoezHssfyCuF98Yd3o6GYbblfsMk2xtGYkzxNs2Vn4mkDw64VL7kEizzGHoF1zQ/rl
         YvPQ==
X-Gm-Message-State: AJIora8bHddf6tVTY07Tq1lFiiy2TjCUsql/diJN3WaDgahzM/GIWh2h
        OEKJZZCqQSy0DTpvHVVO1o3sUgyswQWLi2w+UpZfbr9xto5rqzOMG41cSi7v95+QXgRikWWr4UK
        uAIFnHT2paNzPiPe5cvohfzEt9p2niiAuB6mntA==
X-Received: by 2002:ad4:594d:0:b0:46b:9c03:4fd1 with SMTP id eo13-20020ad4594d000000b0046b9c034fd1mr3802384qvb.92.1655384245579;
        Thu, 16 Jun 2022 05:57:25 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ukGxTO+VKqdTBk2Vgne3ZioipDrRA+O1zB9SXLtMaJG21eu2euN8ScJErYqjnPyjwRthzssZduk3HqZTRQ89U=
X-Received: by 2002:ad4:594d:0:b0:46b:9c03:4fd1 with SMTP id
 eo13-20020ad4594d000000b0046b9c034fd1mr3802374qvb.92.1655384245372; Thu, 16
 Jun 2022 05:57:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220613032922.1030739-1-aahringo@redhat.com> <20220613032922.1030739-2-aahringo@redhat.com>
 <3b7a9363-1fea-d4a3-360d-a2e60b1038c7@datenfreihafen.org>
In-Reply-To: <3b7a9363-1fea-d4a3-360d-a2e60b1038c7@datenfreihafen.org>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Thu, 16 Jun 2022 08:57:14 -0400
Message-ID: <CAK-6q+hT4-w4Hw5wq_7orUffkDPWYxJ50kurqy+hPxyH91WC5Q@mail.gmail.com>
Subject: Re: [PATCH wpan-next 2/2] 6lowpan: nhc: drop EEXIST limitation
To:     Stefan Schmidt <stefan@datenfreihafen.org>
Cc:     linux-wpan - ML <linux-wpan@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org,
        Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Thu, Jun 16, 2022 at 3:57 AM Stefan Schmidt
<stefan@datenfreihafen.org> wrote:
>
>
> Hello Alex.
>
> On 13.06.22 05:29, Alexander Aring wrote:
> > In nhc we have compression() and uncompression(). Currently we have a
> > limitation that we return -EEXIST when it's the nhc is already
> > registered according the nexthdr. But on receiving handling and the
> > nhcid we can indeed support both at the same time.
>
> The sentence above is not really clear to me. Do you want to say that on
> rx we can support more than one nhcid? I am a bit confused why you write
> both here. Where does the limit to two come from?
>

It's simple when you look at how it's working. On rx we have nhcid
lookup and on tx we have nexthdr lookup. These are two different
registration numbers and there can be multiple compression for one
nexthdr:

N:1

The limit was always there because we did not support multiple nexthdr
registrations.

> We remove the current
> > static array implementation and replace it by a dynamic list handling to
> > get rid of this limitation.
> >
> > Signed-off-by: Alexander Aring <aahringo@redhat.com>
> > ---
> >   net/6lowpan/nhc.c | 69 ++++++++++++++++++++++++++++++-----------------
> >   1 file changed, 44 insertions(+), 25 deletions(-)
> >
> > diff --git a/net/6lowpan/nhc.c b/net/6lowpan/nhc.c
> > index 7b374595328d..3d7c50139142 100644
> > --- a/net/6lowpan/nhc.c
> > +++ b/net/6lowpan/nhc.c
> > @@ -12,13 +12,30 @@
> >
> >   #include "nhc.h"
> >
> > -static const struct lowpan_nhc *lowpan_nexthdr_nhcs[NEXTHDR_MAX + 1];
> > +struct lowpan_nhc_entry {
> > +     const struct lowpan_nhc *nhc;
> > +     struct list_head list;
> > +};
> > +
> >   static DEFINE_SPINLOCK(lowpan_nhc_lock);
> > +static LIST_HEAD(lowpan_nexthdr_nhcs);
> > +
> > +const struct lowpan_nhc *lowpan_nhc_by_nexthdr(u8 nexthdr)
> > +{
> > +     const struct lowpan_nhc_entry *e;
> > +
> > +     list_for_each_entry(e, &lowpan_nexthdr_nhcs, list) {
> > +             if (e->nhc->nexthdr == nexthdr &&
> > +                 e->nhc->compress)
> > +                     return e->nhc;
>
> We will always go with the first one we find? Do I miss something or
> does that mean the one registered as seond and above will never be taken
> into acount?

That is currently true for the tx side. This just allows more than we
currently support without breaking the past.

- Alex

