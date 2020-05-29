Return-Path: <SRS0=/pyi=7L=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87496C433E0
	for <linux-wpan@archiver.kernel.org>; Fri, 29 May 2020 19:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C6F2207D4
	for <linux-wpan@archiver.kernel.org>; Fri, 29 May 2020 19:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFs4kRpy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgE2TeG (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 29 May 2020 15:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbgE2TeF (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 29 May 2020 15:34:05 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982A5C03E969
        for <linux-wpan@vger.kernel.org>; Fri, 29 May 2020 12:34:05 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id n18so346704pfa.2
        for <linux-wpan@vger.kernel.org>; Fri, 29 May 2020 12:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ivM9yQKOTvyNkm/bYd2RS6jlpervyV1eKUeGQwnEGzQ=;
        b=bFs4kRpyHf4yZBmJqawFh1j/h+C/wTfGN9QP6Oy1PfZDRO3Fu8fXqBtZljEV1xVfD8
         WTcpC73cFR7Op0vguHwe++QLj9Ml75hhPm9cvP6U0rGV0d4KNI9/doODjvO6c6AJo0ha
         kUsGb9Lks1toZbULXJmCncRg8eUZ+GCfhLs3BhWg7CkBSuERQ4y2irxaYbpxaer6bC/z
         oM5WrxoMG9YvRTkejVoMIF03dZnXOZj+0PzXQ2Z3Jwcs7TnslxraSDeA8ZxvIbnf2sGz
         dScgndv3Qrv0iAGkDZPfGwWIwaxriu2izZmXkTHG2u+qrAiRl6P+/dRIehIGQJgtB1Ty
         FqLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ivM9yQKOTvyNkm/bYd2RS6jlpervyV1eKUeGQwnEGzQ=;
        b=eEluBJqlQ1pHNk7x2W5kT8dhB32bLiioquA2+MD2jmp3NTQJlkyEXrQwyVOZW9mcdQ
         ExKYXkilX6Dy1obMUAQKIKt7356CWSSsCauO3rXxHCkBeJkQO/EKXDkxK4Woc87eI1eJ
         OKWohEL6WAXU/Kk+q5oxuh0NoYrRQTog8snlDIVSVFPPcFF/lFqh6KaZdVmcDtnmuYUX
         liQbkVdRJvYQBwrVAaSejD/0jtpOUj3oj3eoOttu7J66+78mP8r+sJ+/+kAopW5Q992r
         TUbjLjnMPvLGHQnw4rwB11cwge5Zb684LhoKvNvutvTOr9A3bhn2giHBcgioZjmZv874
         jVtg==
X-Gm-Message-State: AOAM5337fETlwNR95S5vtT09wlAsWZ6i8Chgg0gADYLd+wX5vSu3cwUI
        SJ+gL4tsiHIeIu+tnXsTFWbEGAy8gej6Q/dN70WdTQr5
X-Google-Smtp-Source: ABdhPJyy6uTIcWzrtyEng3c1gbnGh0yj6YKbfh6c9T2SOdJEIOshzlyh9YW3npMEgzcTxfPAqxjTGsxAKYzy21RCTTc=
X-Received: by 2002:a62:8f45:: with SMTP id n66mr1775537pfd.236.1590780845060;
 Fri, 29 May 2020 12:34:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAF4BF-SFHA=mPHLxpDHGMLvgu0UKO-6ujfYB+n2a6=XhFvT6DA@mail.gmail.com>
 <b009a2a8-64a5-fe66-a53e-5a93135cf1f8@datenfreihafen.org>
In-Reply-To: <b009a2a8-64a5-fe66-a53e-5a93135cf1f8@datenfreihafen.org>
From:   Christopher Friedt <chrisfriedt@gmail.com>
Date:   Fri, 29 May 2020 15:33:53 -0400
Message-ID: <CAF4BF-SNRyXQzUBqx5k014nZou4q7=Gd8=dbUyK7JiDkaEEvFA@mail.gmail.com>
Subject: Re: wpanusb?
To:     Stefan Schmidt <stefan@datenfreihafen.org>
Cc:     linux-wpan@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wpan-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi Stefan!

On Tue, May 26, 2020 at 3:38 PM Stefan Schmidt
<stefan@datenfreihafen.org> wrote:
> On 25.05.20 14:39, Christopher Friedt wrote:
> > Hi all,
> >
> > Bouncing around a bit, but in Zephyr, there is reference to a
> > "wpanusb" Linux kernel driver here:
> >
> > https://docs.zephyrproject.org/latest/samples/net/wpanusb/README.html
> >
> > This *might* be the driver in question:
> >
> > https://github.com/finikorg/wpanusb
> >
> > Just wondering if anyone has made any attempts to submit that, or
> > would that go directly upstream these days?
>
> I had a chance to talk to the author a while back. Not much activity
> from his side.

I was chatting with him as well on Zephyr Slack and let him know that
there was significant interest in it going upstream. I worry though
that it might not be a high priority for his employer.

Is there a linux-wpan IRC? Would be nice to chat in real-time at some point.

> For me this needs to be designed in a way where we could have bare
> metal, Zephyr, RIOT or Contiki based firmware implementing the interface
> and the driver would just work. The code available is a good start but
> needs more work.

I agree mostly. Of course each RTOS has their own headers, way of
declaring things, etc, but for the most part it could be platform
independent.

> I was, and somehow still am, planning on working on this. But with the
> world turned upside down there was always something else to look at
> before. Its on my list, just not very high. If anyone wants to have a
> stab at this feel free and let me know.

I'll bring it up in the Zephyr Slack. They want to incorporate it into
their "tools" repository, but it really should go into Linux at some
point.

We'll probably end up working on this for BB.O - even just having a
single driver that works for all boards in Zephyr is a pretty large
step.

Lastly, I feel like this is a recurring question, but a number of us
will likely need a bunch of 802.15.4 USB dongle to speak to our 15.4
nodes. I have a couple of ATUSB on my desk, but are there others in
our group that don't have any idea where to get parts, and likely
building one from scratch would be more time than they want to take.

Do you know of an off-the-shelf product that works with existing
drivers upstream?

M.f.G.

Chris
