Return-Path: <SRS0=4IKq=7M=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4AAC433DF
	for <linux-wpan@archiver.kernel.org>; Sat, 30 May 2020 15:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7DE820715
	for <linux-wpan@archiver.kernel.org>; Sat, 30 May 2020 15:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p577+f/z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbgE3PIw (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sat, 30 May 2020 11:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728927AbgE3PIw (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sat, 30 May 2020 11:08:52 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B7FC03E969
        for <linux-wpan@vger.kernel.org>; Sat, 30 May 2020 08:08:50 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id v11so5389863ilh.1
        for <linux-wpan@vger.kernel.org>; Sat, 30 May 2020 08:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IlKU74FJlV3XA4cr6Q0sYiRPGXEWXkPy+Jd95dSZe2s=;
        b=p577+f/zBOCTzzm3uKzqik4r0pYa3kUGqsplx1lIBya8RkEU4wO2qtOGE+EM0ATrD1
         sDw9j9U4YO9AqowV1KRzKSB6Oh469b6gNUbrmYukEjhlaB4BrUGdBzsSiYCspadlimcs
         8+F1mWapGjkAUxWgCn7xWkStc8uKpQ54+IRMUn0oiPnn1muBEGa8rnY6XOACza4US0UU
         2K1PgZtTwH1Q3zSeszSWh7E0TlaU4S/CHT9s9jbPcJ922vdwC0/PiV+wtX7B9xhGZZ9Z
         7kPZpv9q/Av9ML6gD05567NHKgms6aqIx2Enkj15z51iiIclUv2bDLhpsd+OiMO2LCYh
         0yIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IlKU74FJlV3XA4cr6Q0sYiRPGXEWXkPy+Jd95dSZe2s=;
        b=ETXeYpmLPcGuw+1ruMr64W+maq05L0idFf/ac02R53qQBuHmHqgJFTFATwthfKRZm3
         uuds0fG0x/v0jr5SiDuZ8/uvroBnwS46kZRACDa1n9XXSTQuEbCIZZ+YAGmNRNiErAjP
         4V8JRoNo77yOk1QWk+H29+amfL03NAqMIj53lOvXTcrop433XtvLrIO/hHZv29Eyi2Af
         V+DsaMoLotMg4ilHHXaZ9bHTry3iUfVdynepy3F92UAgUt6q+AHyKRF5wIcpLLto9xC/
         lCKzI7vyUBEDK0KAu10IT7v/Upd019efRa7W4Z3/LdRyOaliR0jlp+48PG4NIX/yid+V
         Zcuw==
X-Gm-Message-State: AOAM5310MgZf4BG0ln5ZaR6R87rl0Iow6l7OoefMdm9jSPBOQHRJ5WVs
        G8Oll0BjbATB/+UpKxfS7HKPcwdDWFccfL5/QdHjwjil5FE=
X-Google-Smtp-Source: ABdhPJz4SWnrkDzGfOcbnuF9wpennTshiPqyHN9FwdpBVd2D7TI08cSNPPB+EMCvmyC5vIcJiiOUmq/vtuTVN6L3gng=
X-Received: by 2002:a92:8946:: with SMTP id n67mr11817149ild.215.1590851330293;
 Sat, 30 May 2020 08:08:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAF4BF-SFHA=mPHLxpDHGMLvgu0UKO-6ujfYB+n2a6=XhFvT6DA@mail.gmail.com>
 <b009a2a8-64a5-fe66-a53e-5a93135cf1f8@datenfreihafen.org> <CAF4BF-SNRyXQzUBqx5k014nZou4q7=Gd8=dbUyK7JiDkaEEvFA@mail.gmail.com>
 <f98b4515-9570-ad48-2d8f-dcc5482a21a1@datenfreihafen.org>
In-Reply-To: <f98b4515-9570-ad48-2d8f-dcc5482a21a1@datenfreihafen.org>
From:   Christopher Friedt <chrisfriedt@gmail.com>
Date:   Sat, 30 May 2020 11:08:39 -0400
Message-ID: <CAF4BF-SipApoY=7CY8fWs8cSi8rKZaYMxOZHAqoKv=poAgVm=Q@mail.gmail.com>
Subject: Re: wpanusb?
To:     Stefan Schmidt <stefan@datenfreihafen.org>
Cc:     linux-wpan@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wpan-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

On Sat, May 30, 2020 at 7:33 AM Stefan Schmidt
<stefan@datenfreihafen.org> wrote:
> On 29.05.20 21:33, Christopher Friedt wrote:
> > On Tue, May 26, 2020 at 3:38 PM Stefan Schmidt
> > <stefan@datenfreihafen.org> wrote:
> >> On 25.05.20 14:39, Christopher Friedt wrote:
> >>> Hi all,
> >>>
> >>> Bouncing around a bit, but in Zephyr, there is reference to a
> >>> "wpanusb" Linux kernel driver here:
> >>>
> >>> https://docs.zephyrproject.org/latest/samples/net/wpanusb/README.html
> >>>
> >>> This *might* be the driver in question:
> >>>
> >>> https://github.com/finikorg/wpanusb
> >>>
> >>> Just wondering if anyone has made any attempts to submit that, or
> >>> would that go directly upstream these days?
> >>
> >> I had a chance to talk to the author a while back. Not much activity
> >> from his side.
> >
> > I was chatting with him as well on Zephyr Slack and let him know that
> > there was significant interest in it going upstream. I worry though
> > that it might not be a high priority for his employer.
> >
> > Is there a linux-wpan IRC? Would be nice to chat in real-time at some point.
>
> #linux-wpan at Freenode :-)

I see some familiar nicks there ;-)

> >> For me this needs to be designed in a way where we could have bare
> >> metal, Zephyr, RIOT or Contiki based firmware implementing the interface
> >> and the driver would just work. The code available is a good start but
> >> needs more work.
> >
> > I'll bring it up in the Zephyr Slack. They want to incorporate it into
> > their "tools" repository, but it really should go into Linux at some
> > point.
>
> > We'll probably end up working on this for BB.O - even just having a
> > single driver that works for all boards in Zephyr is a pretty large
> > step.
>
> If work is going on for this and you are getting an idea on the level of
> abstraction I would be happy to discuss how this should result in a
> generic wpanusb driver.

Sounds good. If you want to email me directly I can see if I can fit
it into the current project, or even see if I can work with the
original wpanusb author.

> > Lastly, I feel like this is a recurring question, but a number of us
> > will likely need a bunch of 802.15.4 USB dongle to speak to our 15.4
> > nodes. I have a couple of ATUSB on my desk, but are there others in
> > our group that don't have any idea where to get parts, and likely
> > building one from scratch would be more time than they want to take.
> >
> > Do you know of an off-the-shelf product that works with existing
> > drivers upstream?
>
> ATUSB are still being produced and sold:
> http://shop.sysmocom.de/products/atusb
>
> Sysmocom is doing small batches (100-200 pieces) whenever their stock
> goes low. The price is not really making money for them and is mostly
> covering their expenses. Its one of their many contributions to help
> Open Source projects with hardware. (As you most likely can read from
> this I am _very_ happy they are handling all the hardware manufacturing
> and logistics for this).
>
> I am flashing every single one of these atusb's by hand as well (for
> free, just to keep the supply alive). :-)

That is dedication ;-) Hopefully this winter I should have some
dedicated manufacturing space, so I'm looking forward to spinning out
a few OSHW boards too.

> The available CC2531 dongles would be available for ~10 USD from China,
> but there is no driver support (it would be a perfect candidate for the
> wpanusb driver with a bare-metal firmware).

Excellent!

I also found this which seems like it should be supported (with
something out of linux-firmware maybe?)

http://www.ti.com/tool/CC2531EMK

C
