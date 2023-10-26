Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB58C25B48
	for <linux-wpan@archiver.kernel.org>; Thu, 26 Oct 2023 12:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbjJZMk4 (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Thu, 26 Oct 2023 08:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjJZMkz (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 26 Oct 2023 08:40:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B757910E
        for <linux-wpan@vger.kernel.org>; Thu, 26 Oct 2023 05:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698324009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xGu3rbQKn8+hwo2dXu04vv81c64gHLRd1reIvEj8x3w=;
        b=TtFRcgr/IJ1PLifMCVuD5Aq00x0SHMy7fjULaQdrBdnxOhRHYIQOQw4v+DNqiOeDFyZAKv
        R0xuQHGgttiJ//f+l2GdUpyurEm0/r19dQ5rZQU+Zexm1KaQqwLfti3c26mHpXENpwSdtO
        bLjsGoquWmgAmd1VInjKRMr9ImxXvu0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-AuW_zjCyOrCq-JKPiqd5lw-1; Thu, 26 Oct 2023 08:40:08 -0400
X-MC-Unique: AuW_zjCyOrCq-JKPiqd5lw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9c7558b838aso62963366b.2
        for <linux-wpan@vger.kernel.org>; Thu, 26 Oct 2023 05:40:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698324007; x=1698928807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xGu3rbQKn8+hwo2dXu04vv81c64gHLRd1reIvEj8x3w=;
        b=ZsOyefPucWeQywHj5pc90hUS+NFkunbQjnuHZicTlsUq4dgl/VkwfC0Y73BzkNbH6N
         YwhgU4xCndkyHsl7xArpWEzJ8CFkyVZaxTDFsJ1zoPGC1pY3AcKJII3VV5V4TEBLOcI2
         HyL09QO86BWd79GtmNCKjuur3nil+n+Of0QIXkmIMeqmXvZYO1AiplUDXKnzC/tLttjv
         hqnqht+EduAQU8S1/KCXIfmb0BBgy9hCFHdXuKdffj4ayVNhG/Z5WsqpVEX6Tt+SL8RP
         Ez86YpjK4T7Xg5mYbo/pFLAl7swclMN5j5tLIV/fCfOo+jFkCflmY9+acV4MEwv5LH3Q
         /c2A==
X-Gm-Message-State: AOJu0Ywva/tswg2lgb+LHcXGlew++ceFDZzdvKQcb7CmQ0aCWp0kZ5Hs
        88uX1K7cD/dylpZVvLD44mQprxXElPdB0W6r8SbNBqgn3F4N8hWfaZ/6B6+YHiADeOlWtPyJjl5
        rT89K8Ks8Zq8f9AJefherDtpXmGZSDgTx1/tUchyqPYREyw==
X-Received: by 2002:a17:906:fe4c:b0:9b8:7709:6360 with SMTP id wz12-20020a170906fe4c00b009b877096360mr15561757ejb.40.1698324006956;
        Thu, 26 Oct 2023 05:40:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbO82fcLQT0RB/hSqWG2LjR0kLLbrirYB53KbY0ezj1atc8PvF4d9Mmgw1LHLyOzb53j1yeXQzWtin/MahmPQ=
X-Received: by 2002:a17:906:fe4c:b0:9b8:7709:6360 with SMTP id
 wz12-20020a170906fe4c00b009b877096360mr15561739ejb.40.1698324006686; Thu, 26
 Oct 2023 05:40:06 -0700 (PDT)
MIME-Version: 1.0
References: <d25926f8-84bd-4eef-9e44-86fb1e3e5932@silabs.com>
 <13794.1698248146@localhost> <CAK-6q+jCpWpoaX5acNEdOv=CybGUXUzNJ6Saa-s7ADevi5LjSA@mail.gmail.com>
In-Reply-To: <CAK-6q+jCpWpoaX5acNEdOv=CybGUXUzNJ6Saa-s7ADevi5LjSA@mail.gmail.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Thu, 26 Oct 2023 08:39:55 -0400
Message-ID: <CAK-6q+jygLMq3Seso_SxFYYn3DKSJx0T+c77pYro_5RTMoB58A@mail.gmail.com>
Subject: Re: RPL lwtunnel encapsulation
To:     Michael Richardson <mcr@sandelman.ca>
Cc:     Mathis Marion <mathis.marion@silabs.com>,
        linux-wpan@vger.kernel.org,
        =?UTF-8?B?SsOpcsO0bWUgUG91aWxsZXI=?= <jerome.pouiller@silabs.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Wed, Oct 25, 2023 at 9:03=E2=80=AFPM Alexander Aring <aahringo@redhat.co=
m> wrote:
>
> Hi Michael,
>
> On Wed, Oct 25, 2023 at 11:45=E2=80=AFAM Michael Richardson <mcr@sandelma=
n.ca> wrote:
> >
> >
> > Mathis Marion <mathis.marion@silabs.com> wrote:
> >     > However, my observations suggest that it is actually not the case=
 when
> >     > forwarding packets. Instead, the IPv6 header of the packet is mod=
ified
> >     > in a way which violates the IPv6 specification (RFC 8200 section =
4):
> >
> > I have not sat down to read the code to understand what it actually doe=
s, so
> > I can't really comment at this point.  I salute you for having gotten i=
nto
> > whether the code is compliant.
> >
> > But, I did write spend way too much of my life writing
> >      https://datatracker.ietf.org/doc/rfc9008/
> > to deal with the perception that RPL networks had to violate 8200.
> >
> > I know that Linux does not (yet) deal with all the minutia in 9008.
> > I wish that I had time to fix that.
>
> To put everything into IPIP and back is not a question of doing a
> iptunnel ip6tnl [0] and doing the right configuration... just do get
> everything over "the internet" which I think is the whole reason why
> putting everything into IPIP?
>

what I mean is, that encap rpl will never do any IPIP itself, you need
to use existing iptunnel implementation [0] to make it working like
you want to work and this is in my opinion "if we have luck" only a
matter of configure everything "right".

- Alex

>
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/net/ipv6/ip6_tunnel.c

