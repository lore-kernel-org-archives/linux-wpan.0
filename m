Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A24C6FD1D
	for <linux-wpan@archiver.kernel.org>; Thu, 23 Mar 2023 12:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbjCWM7n (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Thu, 23 Mar 2023 08:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjCWM7m (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 23 Mar 2023 08:59:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1E62914B
        for <linux-wpan@vger.kernel.org>; Thu, 23 Mar 2023 05:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679576337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5fCUALEp/A6z+MmJJ2SbjeHDveL1HTRdJjFfUfUGUA8=;
        b=danasvM6SAefM0Yz6SngcwDPLazIQqakMoCL4kpD559d82ZeThy2Ox2DFhug7x2Nhf4qvg
        s5or+qePkm7Xe0Ne5aygR151j55c9U4hiprzU9OgyCuiD3spgXiHubZEbX4AfxgWtbibtF
        1Qj+p1+AXT26XqFOzbSYfcCYhL/FGfA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-2SYStGiQMH6vj9sh7j7nJg-1; Thu, 23 Mar 2023 08:58:55 -0400
X-MC-Unique: 2SYStGiQMH6vj9sh7j7nJg-1
Received: by mail-ed1-f71.google.com with SMTP id i22-20020a05640242d600b004f5962985f4so32570376edc.12
        for <linux-wpan@vger.kernel.org>; Thu, 23 Mar 2023 05:58:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679576334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5fCUALEp/A6z+MmJJ2SbjeHDveL1HTRdJjFfUfUGUA8=;
        b=Qk8H+4F8/1uzasylvu6B9VRvsrZaCEg4ySq5KBe/L3AqQVgMo9XQYj2Ubmo5x4/ptp
         yTANjN+N6PNYHZY5IHODPm54dOJkHIqsRGERkHqOmoM6+RtDSqMLKo0rXOTf/K35k0Wz
         TMSSmz7a5psmbG0ADf2WRlgkNhZ+4O+N73PB3lGFW792ztpfkym84ZSK46Nfu6zrw2AQ
         olunLfBsZKxF4lLU1Zm0gS3XRHdDeqznmgBQuNiSFsQYtkTWqMwoqxbg1hdWiOgkFPu4
         ee5o8u3dyTbMMnFnwQt9Cd1Td2uOuLO4hQo1E6mki2l57S3o+jwkjMSzupe/xvrZOu/u
         fbHw==
X-Gm-Message-State: AO0yUKXJpFbBjtGqrTc6BqPRYveoLEjOTIT1BrrgYZN+QP028Mjtyez+
        8JhoVLxo7yGwv/mWvR3ptwLtdzZGS1oceb1Z0ed+Fj9nj7cU16yspiPV6L0tkrYBGItOXPorc/b
        MSk3YFvxa0859BZaCOE3XwjrA9WP82PxewVnXTA==
X-Received: by 2002:a17:906:49b:b0:931:7350:a7cd with SMTP id f27-20020a170906049b00b009317350a7cdmr4899966eja.9.1679576334465;
        Thu, 23 Mar 2023 05:58:54 -0700 (PDT)
X-Google-Smtp-Source: AK7set/vXgrdjFRtCQr4t+491GvB6Zofa42jpAcZHsjbnGSvJs+zpAsisLCqA88WJNMH7TV0tqMr3BakEhlkNv0lJgA=
X-Received: by 2002:a17:906:49b:b0:931:7350:a7cd with SMTP id
 f27-20020a170906049b00b009317350a7cdmr4899958eja.9.1679576334227; Thu, 23 Mar
 2023 05:58:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230310145346.1397068-1-miquel.raynal@bootlin.com>
In-Reply-To: <20230310145346.1397068-1-miquel.raynal@bootlin.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Thu, 23 Mar 2023 08:58:43 -0400
Message-ID: <CAK-6q+iw6V5qDCux0E4xE3wMuCc1u8tc26kzwQFyHbMcyFr4iQ@mail.gmail.com>
Subject: Re: [PATCH wpan-next v2 0/4] ieee802154: Active scan support
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan@vger.kernel.org,
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

On Fri, Mar 10, 2023 at 10:12=E2=80=AFAM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
>
> Hello,
> Following the initial support for passive scan and beaconing, here is an
> addition to support active scans.
> Thanks,
> Miqu=C3=A8l

Acked-by: Alexander Aring <aahringo@redhat.com>

but I need to admit those are more scan mechanism related work and I
trust Miquel he does the right thing, because he is actually more into
this topic as me and worked previously on it.
For me, I do not see anything that will break something e.g.
overwriting framebuffer/dealing with frame filter levels and I am
pretty sure Miquel already knows to take care of it.

Even if there would later be a problem regarding that, we can
hopefully work things out.

Thanks.

Sorry for the late reply.

- Alex

