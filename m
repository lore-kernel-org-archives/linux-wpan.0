Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84EE6C77B7D
	for <linux-wpan@archiver.kernel.org>; Sun, 14 May 2023 19:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjENT4o (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sun, 14 May 2023 15:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjENT4o (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 14 May 2023 15:56:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214CD199
        for <linux-wpan@vger.kernel.org>; Sun, 14 May 2023 12:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684094155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uaucQgFhY1E9Fd41MHtEXN2t8Fd1tN1mlHEdGfY/pP8=;
        b=W+DLQQHBHrKXs3EWySwCPXprCbTVL9gedlz0y4JVJVWc6MY58NrCOq8InIK0eEGlqSJbqY
        rUDusJVMdgkJ+LfPUNoZBJRdpKQdYzdP6CuKcSeZGt01bYh7VbAg7tn2g0R1EfwXWbBFen
        tfzDwmvdJnxBn/TZaQX4wouyy+CmcxA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-UQyit6EdPzux2DTkCjWYCg-1; Sun, 14 May 2023 15:55:53 -0400
X-MC-Unique: UQyit6EdPzux2DTkCjWYCg-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-50bc456a94dso10654786a12.1
        for <linux-wpan@vger.kernel.org>; Sun, 14 May 2023 12:55:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684094152; x=1686686152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uaucQgFhY1E9Fd41MHtEXN2t8Fd1tN1mlHEdGfY/pP8=;
        b=hKBs3QddSeJd26OLC1kyG41V8kD3EyaQeycwHTBagV1kceRYZlE58GVKOECHhX3WO5
         38txPZDnobW0tMqMo1DOTkaK0JNSpu87laPiIbS5LyoquMmUmybRCx2lPE+TXTEHsenI
         7vMBmra5lvm3chdcRtyw9siTZOny9lNfA3dtuXVUMMDZS33wdBVUu1LbTD1NSdIGhZlr
         ne61dhGIkMzaXwapO93ie/cEvBlM09knzJbFEsH0ehh32eAg/Rc9M5sXZYARPMO0no5r
         mHwXhAdWuwJQjT+ZQ237RZClvMmGP5KwV0o15LRdwAM7YDHK4ty3WfjT7Jg0NGPGdbRe
         tGrw==
X-Gm-Message-State: AC+VfDxt0/1eOEG1Ki5lURwtHeB869Satz3zJgTeqJOoGP9USOdqysGU
        KcjdksgmMbLS5hlsj+NnNrAT5tDzQD57FusspcvgXamHf01YAXKQtQpyQn1Jg9KMcJxtdf4fdOl
        X1/WdtICx6mvTRTLbfFWi7QlICSZTEacnBGftTA==
X-Received: by 2002:a05:6402:1482:b0:50d:8add:3169 with SMTP id e2-20020a056402148200b0050d8add3169mr23975026edv.31.1684094152507;
        Sun, 14 May 2023 12:55:52 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7f4XCi1CMm6omEJEjxOtqMz6QYWJiRjeGI3jG7IAh2N2nrMRMZTzBMry3J85AsZR/BjWV+GM6W55arylF9hVQ=
X-Received: by 2002:a05:6402:1482:b0:50d:8add:3169 with SMTP id
 e2-20020a056402148200b0050d8add3169mr23975016edv.31.1684094152159; Sun, 14
 May 2023 12:55:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAK-6q+j8T0WFX0XSFk+=7R4=LHOYLo87AN0bHFy=nZc8YkbQ+A@mail.gmail.com>
 <20230512170044.15c2a272@xps-13>
In-Reply-To: <20230512170044.15c2a272@xps-13>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Sun, 14 May 2023 15:55:40 -0400
Message-ID: <CAK-6q+idjnfcJHP=j09gxL-L0yBT9O9sGbyf4CcsDhjYBi5iWQ@mail.gmail.com>
Subject: Re: ieee802154_hot_tx() and return value TX_BUSY/TX_OK
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-wpan - ML <linux-wpan@vger.kernel.org>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Michael Richardson <mcr@sandelman.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Fri, May 12, 2023 at 11:00=E2=80=AFAM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
>
> Hello,
>
> aahringo@redhat.com wrote on Wed, 12 Apr 2023 08:28:42 -0400:
>
> > Hi,
> >
> > I am asking myself if we do the right return value in
> > ieee802154_hot_tx(). Currently we transmit and stop the queue as we
> > know the transceiver (currently only has one tx buffer (sometimes
> > tx/rx is the same buffer)) is busy. As:
> >
> > ieee802154_hot_tx() - we transmit
> > ieee802154_hold_queue()
> > return NETDEV_TX_OK
> >
> > but I think or I have the feeling it should be run like this:
> >
> > ieee802154_hot_tx() - we transmit
> > return NETDEV_TX_OK
> > ieee802154_hot_tx() - we are busy
> > ieee802154_hold_queue()
> > return NETDEV_TX_BUSY
> >
> > The side effects are probably how the qdisc implementation handles the
> > different return values. Some qdisc implementations are evaluating
> > this and need to know that it hits hardware limitation... Some qdiscs
> > don't evaluate this value.
>
> I get what you mean regarding the return value despite my limited
> knowledge about qdiscs. But I am wondering how we would be supposed to
> return two values upon transmission. Is net/ providing an
> infrastructure for the second time we need to do that?
>

Honestly, we still need to figure out if we really have a problem
here. Quick lookup I think we need to figure out how [0] somehow
works. Maybe we don't have no issue because it looks like this
"translates" if a queue is

if (!netif_xmit_frozen_or_stopped(txq))

to return "NETDEV_TX_BUSY" when the queue is stopped and it already
works like it should be. But I am asking myself why we have some
"NETDEV_TX_BUSY" then for the driver level? Maybe some historic return
value?

> > This is just a brainstorming here to find if what we do is currently
> > correct or not correct... we can move this discussion to netdev to
> > clarify this... or we figure it out by ourselves? Somehow it bothers
> > me that there is an additional extra callback to detect it is busy and
> > I can't believe this is not optimized yet.
> >
> > However we should keep that in mind that I think there is some
> > clarification needed.
> >
> > btw: I also have some other things in my mind that currently could
> > make problems in the qdisc handling related to 802.15.4 (and may with
> > 6LoWPAN on top).
>
> I have no idea how qdiscs policies are chosen, but are we supposed to
> support all of them? Maybe all are not relevant to 802.15.4?

That is a BIG todo here because the qdisc should be optimized for the
network that we have here, which is a LLN, Low-power and lossy
network. It's not, because the tx queue length is currently at 300
[1], which is ridiculous for 802.15.4, it should be lower but don't
ask me about the exact numbers... There needs to be more research
regarding qdisc and tx queue length and how everything works together.
I am not sure if some IEEE/IETF papers exist regarding this. I am
seeing papers evaluating Linux 802.15.4 but they completely ignore the
current situation here, that is what I mean with "it's in a working
condition only".

I cc mcr here, he is active at the IETF ROLL group and may know more
about the topic.

I know  we have a very ugly behaviour in 6LoWPAN (and I think in
general in IPv4/v6) that we don't drop all fragments in the queue when
one gets dropped. I asked this at [2] and what I got is a confirmation
that this "ugly" behaviour is currently the case. Fragments are frames
belonging to something bigger in upper layer protocols, if one gets
dropped it can never be reassembled at the receiver's side. This might
have "okay" effects on ethernet and co, but on LNNs it is terrible.

This is however a problem which I know exists. And don't ask me if a
user space protocol doing fragments can give the kernel "hints" that
everything belongs to something bigger... this is a topic for Linux
networking conferences.

- Alex

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/net/sched/sch_generic.c#n314
[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/net/mac802154/iface.c?h=3Dv6.4-rc1#n543
[2] https://www.spinics.net/lists/netdev/msg373970.html

