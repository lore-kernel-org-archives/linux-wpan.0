Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B428C4332F
	for <linux-wpan@archiver.kernel.org>; Tue, 18 Oct 2022 22:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiJRW5F (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 18 Oct 2022 18:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJRW5E (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 18 Oct 2022 18:57:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3798270E57
        for <linux-wpan@vger.kernel.org>; Tue, 18 Oct 2022 15:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666133823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=++gePNcxRlYQ7u6sjqQhm9MC+GRvONvqYTnuH8fpUXY=;
        b=Kzn2EQCnQcw/38vEypMAiro7UrDUkax63rZE/05sHeyOXN63UvvzlzJi5R8qKN2CLTk95X
        XHTOGEABPf+1+VL1n4GDMdZ/tt2+4NqVYQzcYf/JwVn7h3y6HLWSH4wbKy30vSQDEyP/nv
        /iHXx/7mFBrGW2GGzvSNUccd6oie8aI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-346-rDpAt4OlMTOPCSzRQZXdrw-1; Tue, 18 Oct 2022 18:57:02 -0400
X-MC-Unique: rDpAt4OlMTOPCSzRQZXdrw-1
Received: by mail-wm1-f69.google.com with SMTP id t20-20020a7bc3d4000000b003c6bfea856aso7347074wmj.1
        for <linux-wpan@vger.kernel.org>; Tue, 18 Oct 2022 15:57:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=++gePNcxRlYQ7u6sjqQhm9MC+GRvONvqYTnuH8fpUXY=;
        b=UCvY2KMei4EEKuzq9ET9jCfYYHMFT/wp+kVacKBICDwlDo1HoJRgZ2b1dFzmmwXJlw
         x3vDG9u1IYNAaLZfQhIG4UHcHZN45/mCNYo0/2PYlsz2NEcl+joP+lfH3OjlZkuxcDJ7
         yWhDGy632itFQkT1+ZmIIL2c4vjn+EiZB1NN2o9j4ToKTg7nqtwQqcjkg9RoMTP2vsAE
         sGrzny+3FM0YHRBLwAGV4EVtW8sLiYIp356PGaej0UCcf9GD5MJp7cdnigSke57Y8fFQ
         ebvbZhgBqYEdGw/RgBX5rFc38vXkE8Ey6khDHy5Rll8/tzkZLUBEc8o8qdef5gwEbQ7q
         duuA==
X-Gm-Message-State: ACrzQf1BWrg7CosZ7ZZ4wITN8k/gx4gJaeQm8B35N1gbTdBYF4idqxH+
        ApfQe9MMgs6pSLdmA2Q60nf6Ww2wEWdSmfb5U770v6EYPbpsaZ+dtEP5BJfRwWfKyBhbYiY8bF2
        Ukg+fVxUxpy1q+wSooh0sQ+Z1LmDuAVhwPnCHpw==
X-Received: by 2002:a05:600c:348f:b0:3c6:fff4:3a6a with SMTP id a15-20020a05600c348f00b003c6fff43a6amr2869457wmq.47.1666133820729;
        Tue, 18 Oct 2022 15:57:00 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6t9nDJj1v4/kC2hj0cxRwNrAzmRaV4HqZF/GiLji09cEXPDMjxC5pZcLLbkL+69C0AY1TegdgJj3f1nsx7l1c=
X-Received: by 2002:a05:600c:348f:b0:3c6:fff4:3a6a with SMTP id
 a15-20020a05600c348f00b003c6fff43a6amr2869442wmq.47.1666133820569; Tue, 18
 Oct 2022 15:57:00 -0700 (PDT)
MIME-Version: 1.0
References: <20221018183540.806471-1-miquel.raynal@bootlin.com>
 <CAK-6q+gRMG64Ra9ghAUVHXkJoGB1b5Kd6rLTiUK+UArbYhP+BA@mail.gmail.com> <20221019000329.2eacd502@xps-13>
In-Reply-To: <20221019000329.2eacd502@xps-13>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Tue, 18 Oct 2022 18:56:49 -0400
Message-ID: <CAK-6q+hB2883Jb=X90-wSj9PAhaAMQtxhbc3y2nYsMW5pb4ZvA@mail.gmail.com>
Subject: Re: [PATCH wpan-next v5] mac802154: Ensure proper scan-level filtering
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
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Tue, Oct 18, 2022 at 6:03 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hi Alexander,
>
> aahringo@redhat.com wrote on Tue, 18 Oct 2022 16:54:13 -0400:
>
> > Hi,
> >
> > On Tue, Oct 18, 2022 at 2:35 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > >
> > > We now have a fine grained filtering information so let's ensure proper
> > > filtering in scan mode, which means that only beacons are processed.
> > >
> >
> > Is this a fixup? Can you resend the whole series please?
>
> Hmm no? Unless I understood things the wrong way, Stefan applied
> patches 1 to 7 of my v4, and asked me to make a change on the 8th
> patch.
>
> This is v5 just for patch 8/8 of the previous series, I just changed
> a debug string actually...
>

Okay, I see there are multiple new patches on the list, can you resend
them in one series? Then we have the right order how they need to be
applied without figuring it "somehow" out.

> There was a conflict when he applied it but I believe this is because
> wpan-next did not contain one of the fixes which made it to Linus' tree
> a month ago. So in my branch I still have this fix prior to this patch,
> because otherwise there will be a conflict when merging v6.1-rc1 (which
> I believe was not done yet).
>

I see. Thanks.

- Alex

