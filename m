Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B6CC25B48
	for <linux-wpan@archiver.kernel.org>; Thu, 26 Oct 2023 16:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjJZQpT (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Thu, 26 Oct 2023 12:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjJZQpT (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 26 Oct 2023 12:45:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBE8187
        for <linux-wpan@vger.kernel.org>; Thu, 26 Oct 2023 09:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698338670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=37b3dn9cm1bBKiOW0lI0W7gKZiHYc7304OkSbsYuH4I=;
        b=VeIjUFiNucABICzFPk9Qk2zevasI5ZTzcT6WK5AAy2lGrQtBAShg1eck7ydbM8TL/Vyd+f
        RKU+NYwN2dCnQPHc0t1fpuQMNiok1d1t+Gy0Bs0S+pjw2dPypzAObBj6FyxPWDpJktD9RX
        7gwtnOC0X4wLMSHkdPbhu79oR/V4m0s=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-haojV-nsOI2M7JLdtsAgCQ-1; Thu, 26 Oct 2023 12:44:28 -0400
X-MC-Unique: haojV-nsOI2M7JLdtsAgCQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9ae686dafedso79834366b.3
        for <linux-wpan@vger.kernel.org>; Thu, 26 Oct 2023 09:44:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698338667; x=1698943467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=37b3dn9cm1bBKiOW0lI0W7gKZiHYc7304OkSbsYuH4I=;
        b=pFYKTb8dWlKgXn4UmZ5NFhyqRWBfodu4coiV3a/xZHmmTH6drtS7Dqs2soD0vbpToo
         ezpGEDHPJyFN8p5PaP3KXOMe9wXs/hpQyEq3tboN92w/tjIBFOpsv+lwG98GMxRA4IKY
         i4X9bAiI1k1n+1+qFWekr1A6zTyGiq0hm5LZhAN0PbzxQhKQkAWnbQsmYhmSRHZLdQLx
         JTrHYc+jGuAv0O0XlY300JYpqZutqvkgkgzVOWQrpQnppPR7rdigU/UflkAacYdPw/kj
         A+ZcEuMEn/RS/JL8dJ6THjAzayH4s8oKcJSJ7CsuAMp1h0ociKW9VfmMF0iwHtXfaY3F
         HTlA==
X-Gm-Message-State: AOJu0YztGv0oDHpNEcJcKQ0InBUYIGdrmRQVvC9W1n6KeICNXraQs6E5
        XWqkpDLNsQr1pW/WD5HROfJecuoGiPfYCL24jPWXHnujWXPHVXwnb3FFU3duSuZ6ugIa6+s2M5d
        iJt21ZoIa1BoTN+epS72hvekgPOdZQyqMwtKC2Q==
X-Received: by 2002:a17:907:984:b0:9c7:56ee:b6e5 with SMTP id bf4-20020a170907098400b009c756eeb6e5mr190457ejc.40.1698338667297;
        Thu, 26 Oct 2023 09:44:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFy5ycRoinEnIVnF9Q2DCuPF54iN7BVh/sOMB47+2vZCS0hoISmwTS34+zwIkps9PhmneSjjJsckx2fc2PgKac=
X-Received: by 2002:a17:907:984:b0:9c7:56ee:b6e5 with SMTP id
 bf4-20020a170907098400b009c756eeb6e5mr190443ejc.40.1698338666957; Thu, 26 Oct
 2023 09:44:26 -0700 (PDT)
MIME-Version: 1.0
References: <d25926f8-84bd-4eef-9e44-86fb1e3e5932@silabs.com>
 <13794.1698248146@localhost> <CAK-6q+jCpWpoaX5acNEdOv=CybGUXUzNJ6Saa-s7ADevi5LjSA@mail.gmail.com>
 <3098774.1698328568@dyas>
In-Reply-To: <3098774.1698328568@dyas>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Thu, 26 Oct 2023 12:44:15 -0400
Message-ID: <CAK-6q+hbr5r9GOAOJ=L9Sj68u8xh356iVtBOgsjMzFBZ7_mM0w@mail.gmail.com>
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

On Thu, Oct 26, 2023 at 9:56=E2=80=AFAM Michael Richardson <mcr@sandelman.c=
a> wrote:
>
>
> Alexander Aring <aahringo@redhat.com> wrote:
>     >> Mathis Marion <mathis.marion@silabs.com> wrote: > However, my
>     >> observations suggest that it is actually not the case when >
>     >> forwarding packets. Instead, the IPv6 header of the packet is modi=
fied
>     >> > in a way which violates the IPv6 specification (RFC 8200 section=
 4):
>     >>
>     >> I have not sat down to read the code to understand what it actuall=
y
>     >> does, so I can't really comment at this point.  I salute you for
>     >> having gotten into whether the code is compliant.
>     >>
>     >> But, I did write spend way too much of my life writing
>     >> https://datatracker.ietf.org/doc/rfc9008/ to deal with the percept=
ion
>     >> that RPL networks had to violate 8200.
>     >>
>     >> I know that Linux does not (yet) deal with all the minutia in 9008=
.  I
>     >> wish that I had time to fix that.
>
>     > To put everything into IPIP and back is not a question of doing a
>     > iptunnel ip6tnl [0] and doing the right configuration... just do ge=
t
>     > everything over "the internet" which I think is the whole reason wh=
y
>     > putting everything into IPIP?
>
> I agree that modelling it an infinite series of iptunnel/ip6tnl is the wr=
ong approach.
> I would model it akin to how ND and ARP work: something that happens whic=
h
> then resolves into some bytes that get prefixed and/or removed.

then it is currently possible, but not in a nice way (you will
configure yourself to death)... there might be new config options of
iptunnel/ip6tnl to do your ND approach (maybe with accessing ND
cache?).

It is not that the rpl tunnel for source routing header needs to deal
with IP6IP6, it already exists in the kernel with ip6tnl
implementation... it's just terrible to configure it.

- Alex

