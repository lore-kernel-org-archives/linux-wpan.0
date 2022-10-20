Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352ABC4332F
	for <linux-wpan@archiver.kernel.org>; Thu, 20 Oct 2022 23:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiJTXdJ (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Thu, 20 Oct 2022 19:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiJTXdI (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 20 Oct 2022 19:33:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D90920B135
        for <linux-wpan@vger.kernel.org>; Thu, 20 Oct 2022 16:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666308786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jXUbrn7gQYf5A0ahrCBrzC5Y59dXvP27ObT36Fqs2AQ=;
        b=dertq4s+K+OQKDmSkTn/vL+MYCT2iVIn5e3MoA/doaeRJsX5Jcseq/iqzvnMi8dMhFRlkL
        a3qqMZ91yZ0Uz7U2lfSG4SEmhWN6GoAjRZsXULS3efgFmXwbfA5TXe+KAaB2Jx6rYmWZU/
        jHDCpVUKX3zHkJNh+SnPpadRDfdbEec=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-151-0JCPM0LqOyO3mXglGRGPgQ-1; Thu, 20 Oct 2022 19:33:05 -0400
X-MC-Unique: 0JCPM0LqOyO3mXglGRGPgQ-1
Received: by mail-ed1-f72.google.com with SMTP id z20-20020a05640240d400b0045cec07c3dcso779158edb.3
        for <linux-wpan@vger.kernel.org>; Thu, 20 Oct 2022 16:33:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jXUbrn7gQYf5A0ahrCBrzC5Y59dXvP27ObT36Fqs2AQ=;
        b=IRwFWzHFEplOUDKlA4pRg4a45fRtnINR/ZfokvOK1BQJwArnsP3/IfPT9z2Mos6wGH
         M1KssLazd4Dv9w4F8TEoBVk0qgBk5qNlIaluk9gx8hsz6EBONDROQADofIYaQU84Kilm
         en6PMQ4M9BJUU8eckWGM+6Dx6F4BC8DwoAAWx/t6visyum9Dxm7LIDvlb5w+998RMbTO
         6+yr3wo1YewGZQT1tm6hzhLegPAHAwbpy4j1pA0NAgP7SQrKjfUKsJe/kEV6Ol58CUbg
         amDLlsa65vdasvHclPivHTZxkWX2Dnbvm9ux8sELoVQaURnVYdJh9fZiPtcynRui6gzE
         5u5Q==
X-Gm-Message-State: ACrzQf1FeAxhO4s+I2fwdD6f2NKLIBHTSme8VZX/HAYtOsruNMi1cAEj
        hwoiDHBMPGb74e0LC7771VVwBpyk3bwamJFbjd+Rrtv746bY+CkHCFdsnyOQfJYQFqiP36wNWm7
        +Gp7upfPt4Om2ycUhi+eRBuKliUVXvPfVAKdXXw==
X-Received: by 2002:a05:6402:5409:b0:44f:1e05:1e8 with SMTP id ev9-20020a056402540900b0044f1e0501e8mr14381888edb.373.1666308784301;
        Thu, 20 Oct 2022 16:33:04 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5hshHHlb0d3oNqoaCJDsIOS5JFwubBtil60fZgjJfoTrydqGUDPCx8k5WpbwIbAQ/wZ0+D5Fiwr7oeWGcYK5o=
X-Received: by 2002:a05:6402:5409:b0:44f:1e05:1e8 with SMTP id
 ev9-20020a056402540900b0044f1e0501e8mr14381872edb.373.1666308784137; Thu, 20
 Oct 2022 16:33:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220906082104.1338694-1-miquel.raynal@bootlin.com>
 <20220906082104.1338694-2-miquel.raynal@bootlin.com> <44a98eb6-e8bb-3065-4c6d-9ffb801182ae@datenfreihafen.org>
 <20221014081808.1b30bba7@xps-13> <CAK-6q+jbAmTYfF8OTZNZ-KdUNWAfU2RRJE7p8N6nMyHB0xwGMg@mail.gmail.com>
 <20221019214625.22101769@xps-13> <20221020161713.6004b0cf@xps-13>
In-Reply-To: <20221020161713.6004b0cf@xps-13>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Thu, 20 Oct 2022 19:32:52 -0400
Message-ID: <CAK-6q+iffiLx0U3W0Gaw=xtDn3ipRb5v5BPKEazxfpe343h5iA@mail.gmail.com>
Subject: Re: [PATCH atusb/fw v2 2/3] atusb: fw: Update toolchain instructions
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Stefan Schmidt <stefan@datenfreihafen.org>, werner@almesberger.net,
        Alexander Aring <alex.aring@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-wpan@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Thu, Oct 20, 2022 at 10:17 AM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
>
> Hello,
>
> miquel.raynal@bootlin.com wrote on Wed, 19 Oct 2022 21:46:25 +0200:
>
> > Hi Alexander,
> >
> > aahringo@redhat.com wrote on Sat, 15 Oct 2022 21:02:08 -0400:
> >
> > > Hi,
> > >
> > > On Sat, Oct 15, 2022 at 4:58 AM Miquel Raynal <miquel.raynal@bootlin.=
com> wrote:
> > > >
> > > > Hi Stefan,
> > > >
> > > > stefan@datenfreihafen.org wrote on Wed, 12 Oct 2022 19:54:49 +0200:
> > > >
> > > > > Hello Miquel.
> > > > >
> > > > > On 06.09.22 10:21, Miquel Raynal wrote:
> > > > > > Those instructions do not work anymore for several reaons:
> > > > > > - Two out of the three files to download return a 404 error:
> > > > > >        * The binutils version does not exist, it was 2.21.1 or =
2.21.1a
> > > > > >          instead of just 2.21.
> > > > > >        * The avr-libc is no longer hosted on the pointed websit=
e, I've
> > > > > >          found an alternate.
> > > > > > - The binutils version mentioned is not able to compile the fir=
mware on
> > > > > >    a recent distribution, the Internet advised to update its ve=
rsion and
> > > > > >    it worked.
> > > > > > - Most of these compilations will throw warnings if you use a r=
ecent
> > > > > >    gcc. Sometimes -Werror is set and it fails the build. To avo=
id that,
> > > > > >    just use --disable-werror in the ./configure options.
> > > > > > - I had issues building the gcc doc but those issues are trivia=
l to
> > > > > >    fix inline.
> > > > > >
> > > > > > Update the instructions for building the toolchain and while at=
 it,
> > > > > > start the file by mentioning that this is maybe not useful anym=
ore, and
> > > > > > provide the packets to install.
> > > > >
> > > > > I can see that it was a frustrating process to get this working. =
:/
> > > > > Sorry to hear. The truth is only a handful of people did ever bui=
ld the firmware themself, I think. Even I have not done it in a while. (ugh=
, 5 years ago most likely judging from the git log).
> > > >
> > > > Oh I'm not blaming anyone here ;)
> > > >
> > > > By the way I would like to make a another round of tests because du=
ring
> > > > my demos I could observe a wrong LQI, and I don't remember if the L=
QI
> > > > was valid before my changes or not. I haven't got the time yet to g=
et
> > > > back to it. Or maybe the devices were too close to each other? I do=
n't
> > > > know, I'll need to figure it out so we don't break a useful existin=
g
> > > > feature.
> > >
> > > What is a wrong LQI here?
> >
> > I just took the time to reproduce the demo, I get an LQI of 0xff with
> > both firmware versions (before and after my changes). There are 2
> > meters between the devices, isn't it enough?
>
> I hard a hard time putting my two devices "far enough from each other"
> on a radio POV, so I used a shielded bag, multiple USB cable
> extensions, a microwave and my co-worker K=C3=B6ry to finally get a
> reduced LQI. So nevermind, the hardware/firmware works as expected and
> the firmware update we proposed recently did not break anything.

note that one LQI value alone doesn't say anything about the link
quality, also LQI value is a _very_ weak vendor specific thing how
it's calculated.

I heard successful reports also using aluminium foil around transceivers...

- Alex

