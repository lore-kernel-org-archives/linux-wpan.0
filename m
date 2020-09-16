Return-Path: <SRS0=EzT3=CZ=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A07C433E2
	for <linux-wpan@archiver.kernel.org>; Wed, 16 Sep 2020 17:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E931D223EA
	for <linux-wpan@archiver.kernel.org>; Wed, 16 Sep 2020 17:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="HVnInjhx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbgIPRYO (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Wed, 16 Sep 2020 13:24:14 -0400
Received: from mout.gmx.net ([212.227.17.20]:56521 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726881AbgIPRV4 (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Wed, 16 Sep 2020 13:21:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600276885;
        bh=HAHYyp/gCgowUhq59So02NPDwcMzfhUhvY/sBKaK/v8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=HVnInjhxALbAaPGCrB5MlANs7sjHHQT2mkN1+0tvgO4uAhJ8QR++Q5vO2czw3gdAx
         bIATzd5RpCKS9DwUD9AOjLjh8E+gXvXwIKeYb+UQkel2LsCFVEi3ONv7/NNiguSlRJ
         ofIsAL6HF2vsb6RVXIavYCV7RijCaDvZAe3K788E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.45] ([178.10.252.75]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MI5UN-1kF45w45Hb-00FBio; Wed, 16
 Sep 2020 19:14:40 +0200
Subject: Re: 6lowpan Support for Raspberry PI 3B+ - CYW43455
To:     Michael Richardson <mcr@sandelman.ca>
Cc:     Alexander Aring <alex.aring@gmail.com>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>
References: <f1acad10-2fb3-a402-df58-907c2580c5ab@gmx.net>
 <21010.1600201310@localhost>
 <CAB_54W6S3+kf1Uowt9Y+nJVNOG4SS8GFwdd7F+6WJ8=W4Pbahg@mail.gmail.com>
 <a9280f74-54f0-917f-22a7-8907afd33c95@gmx.net> <10921.1600275993@localhost>
From:   Achim Kraus <achimkraus@gmx.net>
Message-ID: <43281eee-af0c-f050-79e4-9f02eda4be49@gmx.net>
Date:   Wed, 16 Sep 2020 19:14:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <10921.1600275993@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-AT-frami
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VPl85YXDpIExMmfU0hYrfLgm8TCrcXuCZrLiVZIZIrtcpJxh3J1
 sPHn+YN7bf4fq20iFWfpVihVO7EkNVGz8OdXifzd3C+F2MMHIIEczd4P3WRRyBKwZWIlg2W
 s+vjGUH6FJQJ+Et55pFDpLjMA/kQ7ZFY+GB/UzNO4nlGiKWC2H0DbOggr4sbiKkgVuu3bgA
 SmvqRyNZk6tLOpRA94E4Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:99ikHF4q9So=:os3EJFcKDifKJRYDwBB4v6
 Cr4ug+FRw6MZpQqQ8L/Yb+313W+hooICeqqL4z7o4maiH9GbHS3bBK1+LqEol0D275acZOTGO
 GWL6ZzcUAog6zFwxIZgx8GbNzBJx3qz75Qycwd81xiMtoaUvQJs5vi2EFva4dNrwJEPg1jsMF
 GkKfe/IUSiQxfiJn4wNo3io5PMaIw8o593Clt0ixywhH7wkgp/FR3zHjSiKgpeEthF4lPcCmx
 aZTafLAVQptRslYmBOXgMPYSFnlmEl/bBXwGVQZh+5EhZ3AGkPA+O4dWMmGmlSqPKRQm2d4d2
 XQmaZa9xVF93c8n8+g51/z/bu+SY9adJckX7slePZsek4AH6fFVxJCbSuy4XAa8b/dznD1DMr
 Eo0G+wDGFcpDStJKoXuqwy6VUPr09BhYcdWY6e6gF0dDbnmaRXkWiKVHSyTnrdXjcEezRzsQ6
 ZCJ4gp1gTtiapsVV1qavvZ3VLNTzqMB4a5WnMnuhbX64Sd/5eG5kyBmQHDOqaEa3gJfR5RLSu
 GyivfYVq7rIkZ/1q3YcgXTV9niv8M+H+IEr3qoX4WTxzcHK7CAvknucKpyJf4dPXF+eOcZN/w
 bw5ByIzPN7cmQ2f+ZjMjs2eaiwlyp4C5XalyBf2TyPtGaaJDPP3GMf4sK+jCkQFEaUaa4jkq/
 dtD4k22yGDynfqRdJMdzVK7hWxZvT/KH4oBztix5NJWKZXYtAWJ1Ue1O1kN3P0wlIJijPMtoj
 q6HTkW7qrUoRMVnwZA8F9MWzi04geKwjR0pJvslACGhH7JN6TewLxL2RSq5VE8Mi7531U66D2
 BPMpB0laKk80qL0HZMRMeWyjlAIFi6jykVsYamweGTmXF2Neuy8x/CSEai3sKWf6I+hiTPdLX
 YJuH2JGSssvdlnHzPOZOR80R45tGQOKOOGCpAzNyYNExSVfK8fUFdkBNbKnv6I2xxnSmeqOI8
 zOiGTkw22gHFbKuxwzCrarFAtMBcOZc/SzBRxFlzT1Sp4TfE9ZHZEYxfFt9vo4oB3oI801BlT
 gydl6jBpmBJte2hABvCLg16jeXDucuy8aryC3hGlOfxg18gi8SaG7Wbglm3esmxQUngHMnY44
 tKHnDFIP0mJJwTiUFQJzt5ETlR2sY1dI3bgcZtHUSNZLNGX5mzAr8UtGhdqejDcC+fPvtJdYu
 bNzMAcrZRH7+86/2ee5fev2p+GvuG3gtVM/FLwjfiaSAvyBJxxTVII5piNM6HTJRVye1xa38u
 AEJCze1NBR8/Ah1FvSTwJNp15lnK5h6wjMhpWfg==
Sender: linux-wpan-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi Michael,

Am 16.09.20 um 19:06 schrieb Michael Richardson:
>
> Achim Kraus <achimkraus@gmx.net> wrote:
>      >>> for any BT device.  I would love to be wrong!!
>
>      > Hi Michael,
>
>      > The current Raspi OS (based on Debian, kernel 5.4) contains a
>      > bluetooth_6lowpan module. With that it's possible to connect the
>      > nrf52840 using a "plain raspi 3b+" (without extra rf module).
>
> So, USB connection to this multi-radio device?

No, the raspberry PI on it's own is using bluetooth_6lowpan.
No USB to the nrf52840!

The nrf52840 is a separate peer, which communicates over
bluetooth_6lowpan with that raspberry PI.

>
>      > Unfortunately, nordic decided to provide precompile examples with=
 the
>      > old, deprecated address mapping and so I need to spend some time =
in
>      > compile these examples before I can report, if it works at all, a=
nd the
>      > experienced stability.
>
> I am unclear what the split of effort between this mcu the kernel is.

It's not split, these are just the two peers, and they communicate with
each other using bluetooth_6lowpan. The raspberry PI uses the linux
protocol-stack, the nrf52840 the protocol-stack from nordic.

best regards
Achim

> I get the impression that we need to load firmware, and that it can in f=
act
> run RIOTOS, etc. directly.
>
>      > P.S.: though linux-wpan is not bluetooth, I hope the misuse of th=
is list
>      > is still OK ;-). But I guess, moving it to the right list will al=
os have
>      > advantages. Does anyone know, which would be the proper list for =
that?
>
> --
> ]               Never tell me the odds!                 | ipv6 mesh netw=
orks [
> ]   Michael Richardson, Sandelman Software Works        |    IoT archite=
ct   [
> ]     mcr@sandelman.ca  http://www.sandelman.ca/        |   ruby on rail=
s    [
>

