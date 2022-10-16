Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951BFC4332F
	for <linux-wpan@archiver.kernel.org>; Sun, 16 Oct 2022 01:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiJPBCd (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sat, 15 Oct 2022 21:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiJPBCb (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sat, 15 Oct 2022 21:02:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38AE640557
        for <linux-wpan@vger.kernel.org>; Sat, 15 Oct 2022 18:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665882150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W1QSFIDHhrtLW57n9F/jJOCUMJyr59NpBuUgh8GV6Ck=;
        b=CjWRL5mFj2gbQares9Z0MNs9B+5+9+zEHHab1c0o7UQO3QNlu9bpFs7HXLu6jP+Q/REU5T
        ORWYwpb4BF6WfUgdQ+BSwlHdi12iPrDe6ZZ7lrysMruVL11H3P8UxdUVgJxifPXOwpCIGj
        1tSgRq6CS+Lr72lYdhM0pQJqiiidzLU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-539-OQ-AOsTFNjCWhZI4UXhajA-1; Sat, 15 Oct 2022 21:02:21 -0400
X-MC-Unique: OQ-AOsTFNjCWhZI4UXhajA-1
Received: by mail-wm1-f69.google.com with SMTP id l1-20020a7bc341000000b003bfe1273d6cso3863994wmj.4
        for <linux-wpan@vger.kernel.org>; Sat, 15 Oct 2022 18:02:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W1QSFIDHhrtLW57n9F/jJOCUMJyr59NpBuUgh8GV6Ck=;
        b=UdXX5Q9I0jJh6+A2gLqFv59DqlzxXXD1TLJFuhJtYfSCjCb8kHiU3lnCnlKFAJO20e
         Zn5BY+PuF2L5FF9J/9qU0FohVE0amh/kLe0tnBhVIULbLnU+iSN2P6Nu8hjqgcZ4BR3L
         wAfGC4pbpsCYLV5x6B25/9CFUbk4xOAiSRuSFvxQyOPBSaExcon3Y+IstbpyES8BCBYy
         Y4UFDeu4K4uIPCKSQ5DStrvDyqP7I2a7vs0QMqxb7LOCpg+YIbArmapjYUVP9nqJlam0
         glQ1jz8clQu4LpqC8cL/VXhXdsdOBXm939RBJ+slSxr43ChEizYA2l57YWOF/v+PdX/C
         ADZA==
X-Gm-Message-State: ACrzQf0qihYsr1oQW+z+diBpPjOxeXAyMATNhrHWooDhCQfinkeD/hzz
        MGhc8FOYJNEwetTjptDsMqqpe/AZycjruAaqBOYwr3CNW5QrdkfnSDmb3vhtLUAXCGFus7xFhqw
        B9Hymnro9nQuykYCZpIp+0CKf5iO+l2zhiz5KQA==
X-Received: by 2002:a05:600c:4e15:b0:3b4:a621:b54e with SMTP id b21-20020a05600c4e1500b003b4a621b54emr2900308wmq.47.1665882140081;
        Sat, 15 Oct 2022 18:02:20 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5gl9R6C4WasLLr76pZVNbN9FOlbJTeZ+e+es8OPqXYMWu6zxOcgOsu1rbBKi6Er7rZ0bkob7HylVhUJsidcdw=
X-Received: by 2002:a05:600c:4e15:b0:3b4:a621:b54e with SMTP id
 b21-20020a05600c4e1500b003b4a621b54emr2900301wmq.47.1665882139926; Sat, 15
 Oct 2022 18:02:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220906082104.1338694-1-miquel.raynal@bootlin.com>
 <20220906082104.1338694-2-miquel.raynal@bootlin.com> <44a98eb6-e8bb-3065-4c6d-9ffb801182ae@datenfreihafen.org>
 <20221014081808.1b30bba7@xps-13>
In-Reply-To: <20221014081808.1b30bba7@xps-13>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Sat, 15 Oct 2022 21:02:08 -0400
Message-ID: <CAK-6q+jbAmTYfF8OTZNZ-KdUNWAfU2RRJE7p8N6nMyHB0xwGMg@mail.gmail.com>
Subject: Re: [PATCH atusb/fw v2 2/3] atusb: fw: Update toolchain instructions
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Stefan Schmidt <stefan@datenfreihafen.org>, werner@almesberger.net,
        Alexander Aring <alex.aring@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-wpan@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Sat, Oct 15, 2022 at 4:58 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hi Stefan,
>
> stefan@datenfreihafen.org wrote on Wed, 12 Oct 2022 19:54:49 +0200:
>
> > Hello Miquel.
> >
> > On 06.09.22 10:21, Miquel Raynal wrote:
> > > Those instructions do not work anymore for several reaons:
> > > - Two out of the three files to download return a 404 error:
> > >        * The binutils version does not exist, it was 2.21.1 or 2.21.1a
> > >          instead of just 2.21.
> > >        * The avr-libc is no longer hosted on the pointed website, I've
> > >          found an alternate.
> > > - The binutils version mentioned is not able to compile the firmware on
> > >    a recent distribution, the Internet advised to update its version and
> > >    it worked.
> > > - Most of these compilations will throw warnings if you use a recent
> > >    gcc. Sometimes -Werror is set and it fails the build. To avoid that,
> > >    just use --disable-werror in the ./configure options.
> > > - I had issues building the gcc doc but those issues are trivial to
> > >    fix inline.
> > >
> > > Update the instructions for building the toolchain and while at it,
> > > start the file by mentioning that this is maybe not useful anymore, and
> > > provide the packets to install.
> >
> > I can see that it was a frustrating process to get this working. :/
> > Sorry to hear. The truth is only a handful of people did ever build the firmware themself, I think. Even I have not done it in a while. (ugh, 5 years ago most likely judging from the git log).
>
> Oh I'm not blaming anyone here ;)
>
> By the way I would like to make a another round of tests because during
> my demos I could observe a wrong LQI, and I don't remember if the LQI
> was valid before my changes or not. I haven't got the time yet to get
> back to it. Or maybe the devices were too close to each other? I don't
> know, I'll need to figure it out so we don't break a useful existing
> feature.

What is a wrong LQI here?

- Alex

