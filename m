Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDDA4E7F150
	for <linux-wpan@archiver.kernel.org>; Wed, 27 Sep 2023 02:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234279AbjI0COw (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 26 Sep 2023 22:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjI0CMw (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 26 Sep 2023 22:12:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E8E5273
        for <linux-wpan@vger.kernel.org>; Tue, 26 Sep 2023 18:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695778657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8FSPOrGsZPPuOb1xbGdmbpSAkvWmok6p4XRywUEGr6A=;
        b=ekzavyuxZooeRE7dRcjGA9FpYorHnY2Zs0g6S/TtxlnRcCaJo5xkhjaHkNQhm+eIwgllSA
        V/UbQLsvO2pgmt155OZw/XzzJmqkorfoWYiv25qCPNlprhSbT1Ifk08sUhf4uZfb09gQXh
        G1xA/mFjKEtAFK/AeWpPtmZiphOQb98=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-paxZwhdIOVWXTbr5FDY0Bg-1; Tue, 26 Sep 2023 21:37:35 -0400
X-MC-Unique: paxZwhdIOVWXTbr5FDY0Bg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9ae12311183so839111566b.2
        for <linux-wpan@vger.kernel.org>; Tue, 26 Sep 2023 18:37:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695778654; x=1696383454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8FSPOrGsZPPuOb1xbGdmbpSAkvWmok6p4XRywUEGr6A=;
        b=pA4Z007BgcBc9r1KsxkxLYb7gj24mM9IXJtDxhkrSFgJ/WRtHgLrdgCyEinQodxs7Q
         wmtrByAc/kZVNf5W41FcUpRqf3D7gUGEI6z0x/pyt6LdrUp4U5puaRrrlQbFmn3wy1OM
         zGyG64KkW5VQSDZ0PxOldZw5Q7EUj4H3DjfGKxv3xNdIhPrYsgTxbKJLmk6tXrEj46lc
         xZ9vejrnzGV3Z5cxGbUeo9jBcCpg1EscpZ6ndBZnVYzOhQZwgR1Xu21mBa+PDBJQK6SA
         V87mU8YUasUHoTfJURGbrjh3Sb1vVJ+YKZSVlZnCskaXPic3bXy4cXZt3CM8q/1aGbdM
         TJeA==
X-Gm-Message-State: AOJu0Yxdod821wDYa8E3BWTbLarXjkC0iumZ+qdYnYluEmvs4dn58Xhi
        YC849VVOt+CeIkTIUUHMlGehUVlruYF/hjuBmnwqU3y/GygR8XmvrCKbhJ0Vv+EiWhiiRsCI1Zc
        +uNl7UOTcNnnlUTQl6j1N1zSqxc6vtd7C8i0LjA==
X-Received: by 2002:a17:906:5dae:b0:9a1:ea01:35b1 with SMTP id n14-20020a1709065dae00b009a1ea0135b1mr303931ejv.62.1695778654758;
        Tue, 26 Sep 2023 18:37:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFo3vNisBp7330YnyG4faJfX+OOPuaqXwu9lTZhRetZ+vqzEwSOWdTF5BN2y7CPnYMMgixy3MJG1blaQjXsgE=
X-Received: by 2002:a17:906:5dae:b0:9a1:ea01:35b1 with SMTP id
 n14-20020a1709065dae00b009a1ea0135b1mr303908ejv.62.1695778654503; Tue, 26 Sep
 2023 18:37:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230922155029.592018-1-miquel.raynal@bootlin.com> <20230922155029.592018-8-miquel.raynal@bootlin.com>
In-Reply-To: <20230922155029.592018-8-miquel.raynal@bootlin.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Tue, 26 Sep 2023 21:37:23 -0400
Message-ID: <CAK-6q+j_vgK_5JQH0YZbqZq30J3eGccMdwB-AHKV6pQKJGmMwA@mail.gmail.com>
Subject: Re: [PATCH wpan-next v4 07/11] mac802154: Handle association requests
 from peers
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        David Girault <david.girault@qorvo.com>,
        Romuald Despres <romuald.despres@qorvo.com>,
        Frederic Blain <frederic.blain@qorvo.com>,
        Nicolas Schodet <nico@ni.fr.eu.org>,
        Guilhem Imberton <guilhem.imberton@qorvo.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Fri, Sep 22, 2023 at 11:51=E2=80=AFAM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
>
> Coordinators may have to handle association requests from peers which
> want to join the PAN. The logic involves:
> - Acknowledging the request (done by hardware)
> - If requested, a random short address that is free on this PAN should
>   be chosen for the device.
> - Sending an association response with the short address allocated for
>   the peer and expecting it to be ack'ed.
>
> If anything fails during this procedure, the peer is considered not
> associated.

I thought a coordinator can also reject requests for _any_ reason and
it's very user specific whatever that reason is.

If we have such a case (that it is very user specific what to do
exactly) this should be able to be controlled by the user space to
have there a logic to tell the kernel to accept or reject the
association.

However, I am fine with this solution, but I think we might want to
change this behaviour in the future so that an application in the user
space has the logic to tell the kernel to accept or reject an
association. That would make sense?

- Alex

