Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED74C38142
	for <linux-wpan@archiver.kernel.org>; Sat, 28 Jan 2023 01:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjA1B6M (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 27 Jan 2023 20:58:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjA1B6L (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 27 Jan 2023 20:58:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512C87B7A6
        for <linux-wpan@vger.kernel.org>; Fri, 27 Jan 2023 17:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674871043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ev6Iprgm0BfLCNvx4GMlcEnMLp0hyf/TajiPKchsa84=;
        b=JYj2q57K+lcn26jTP6gz38CaDOUXjzV+mDItMzl6Kj+/PZKMYbVV7WNCbAJGHHSgyZ5lKc
        RdCslDZMnL1dB7tHlMxEtCm1v1ejhUBpH8eDUDUTZonmiZrJ24XT1vbKMLjOqP6ep6NGVT
        b4Ci/IuryCKq8KTIFjWXXPWg8AFt0Nc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-630-Kp-roZRIOPaPbKQbkSMprw-1; Fri, 27 Jan 2023 20:57:20 -0500
X-MC-Unique: Kp-roZRIOPaPbKQbkSMprw-1
Received: by mail-ed1-f70.google.com with SMTP id h18-20020a05640250d200b0049e0e9382c2so4687465edb.13
        for <linux-wpan@vger.kernel.org>; Fri, 27 Jan 2023 17:57:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ev6Iprgm0BfLCNvx4GMlcEnMLp0hyf/TajiPKchsa84=;
        b=SNsP62B05VhiUhmHrbArxLuuKzABi14JCs3stzzWeonQOLYI3zTrShexaBVHw3vpRY
         ez34lhpq6RGQDDU0iS+JXQp7yvdH7KhcdfMWgDKYCH4burwmCtHR6Mkxk881Pj8lwUbg
         79Abqzg6SvldgmUN7yWg24pa+/w8EZLYIeSFmtxtnNGLErZKhXygtcp7ryAbDHuSwWgD
         ev8hWqhLa2NdDB55eAkNyQFJEf9Wm2oMOqaWi8gMu7hDhMG0n7eCEI8xzSI3X/xcUsX7
         Sg82tGvUmhafgsd2YrfntLg74XroY31v+Gd66H8ULK2tl6nIadr6/+bJut0jYN7tns45
         qBuw==
X-Gm-Message-State: AFqh2kqZkVaNWEZ2o823KqPsFf+fXW9dCXpH46T75kDWwaS27JDDOPqY
        ryASu3q5cOEcjsHhIutWeaVZNYeX+8Kuf2aQmnLi24FnDFXUxRtlsRkVj1a9JLw3wUpFFxDLGd1
        unvMxRRIUardKHqa2yhd2GnyFKA0QO5sVo9OYAQ==
X-Received: by 2002:a17:906:3a5b:b0:870:baa6:676c with SMTP id a27-20020a1709063a5b00b00870baa6676cmr6119217ejf.132.1674871039888;
        Fri, 27 Jan 2023 17:57:19 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtanqSd7MgToKGma445A3qz4TJxSYPH1M8+rA1DH+9zaVF6lXc4fT4gfM9QDUQKrssiLkQG8gIzdAgJAoggFxU=
X-Received: by 2002:a17:906:3a5b:b0:870:baa6:676c with SMTP id
 a27-20020a1709063a5b00b00870baa6676cmr6119210ejf.132.1674871039681; Fri, 27
 Jan 2023 17:57:19 -0800 (PST)
MIME-Version: 1.0
References: <20230106113129.694750-1-miquel.raynal@bootlin.com>
 <CAK-6q+jNmvtBKKxSp1WepVXbaQ65CghZv3bS2ptjB9jyzOSGTA@mail.gmail.com>
 <20230118102058.3b1f275b@xps-13> <CAK-6q+gwP8P--5e9HKt2iPhjeefMXrXUVy-G+szGdFXZvgYKvg@mail.gmail.com>
 <CAK-6q+gn7W9x2+ihSC41RzkhmBn1E44pKtJFHgqRdd8aBpLrVQ@mail.gmail.com>
 <20230124110814.6096ecbe@xps-13> <CAB_54W69KcM0UJjf8py-VyRXx2iEUvcAKspXiAkykkQoF6ccDA@mail.gmail.com>
 <20230125105653.44e9498f@xps-13> <CAK-6q+irhYroxV_P5ORtO9Ui9-Bs=SNS+vO5bZ7_X-geab+XrA@mail.gmail.com>
 <1322777.1674848380@dyas>
In-Reply-To: <1322777.1674848380@dyas>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Fri, 27 Jan 2023 20:57:08 -0500
Message-ID: <CAK-6q+ix3PybA-Af-QRRZ2BwSLYH76SnqhRCsmRpiy_6PFrorw@mail.gmail.com>
Subject: Re: [PATCH wpan-next 0/2] ieee802154: Beaconing support
To:     Michael Richardson <mcr@sandelman.ca>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Alexander Aring <alex.aring@gmail.com>,
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
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Fri, Jan 27, 2023 at 2:52 PM Michael Richardson <mcr@sandelman.ca> wrote:
>
>
> Alexander Aring <aahringo@redhat.com> wrote:
>     >> - MLME ops without feedback constraints like beacons -> should go
>     >> through the hot path, but not through the whole net stack, so
>     >> ieee802154_subif_start_xmit()
>     >>
>
>     > it will bypass the qdisc handling (+ some other things which are around
>     > there). The current difference is what I see llsec handling and other
>     > things which might be around there? It depends if other "MLME-ops" need
>     > to be e.g. encrypted or not.
>
> I haven't followed the whole thread.
> So I am neither agreeing nor disagreeing, just clarifying.
> Useful beacons are "signed" (have integrity applied), but not encrypted.
>

I see. But that means they need to be going through llsec, just the
payload isn't encrypted and the MIC is appended to provide integrity.

> It's important for userspace to be able to receive them, even if we don't
> have a key that can verify them.  AFAIK, we have no specific interface to
> receive beacons.
>

This can be done over multiple ways. Either over a socket
communication or if they appear rarely we can put them into a netlink
event. In my opinion we already put that in a higher level API in
passive scan to interpret the receiving of a beacon on kernel level
and trigger netlink events.

I am not sure how HardMAC transceivers handle them on the transceiver
side only or if they ever provide them to the next layer or not?
For SoftMAC you can actually create a AF_PACKET raw socket, and you
should see everything which bypass hardware address filters and kernel
filters. Then an application can listen to them.

- Alex

