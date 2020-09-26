Return-Path: <SRS0=ZGJA=DD=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50013C2D0A8
	for <linux-wpan@archiver.kernel.org>; Sat, 26 Sep 2020 12:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D87F20BED
	for <linux-wpan@archiver.kernel.org>; Sat, 26 Sep 2020 12:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6Grq6nq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgIZMrX (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sat, 26 Sep 2020 08:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbgIZMrU (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sat, 26 Sep 2020 08:47:20 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0331C0613CE
        for <linux-wpan@vger.kernel.org>; Sat, 26 Sep 2020 05:47:20 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id q21so4953580ota.8
        for <linux-wpan@vger.kernel.org>; Sat, 26 Sep 2020 05:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EIIAdlpLZ8QWBpnk1CRK2E0QztRVUXlgOgWtUcAY46M=;
        b=Y6Grq6nqmll35dkCEIN8Q9psVSg1VjlYS3daQgA8QnpipZhYcLgBFPnc8ZTLGBaCHW
         /4gfCap9XCeR+2h+Oi6epTKPux3tx3PUWl/P9ghGoZFxqSeIQEcy1kPkbmoN5W+6DQPa
         kYcWocoOmlIBicOnymUn3S9JveIoV3GA6zmrYses3YR1GK5ryG7x1AOAl8tqLY3YMANS
         tz6+Tj08xYs39+FPP2lqt/VdnvnXgriGKCwwNhFXZoP1LbUXr04MTi9PPgDXUWWD2xK2
         FzDQtgX9ksc7FjOBIteEfjd6bLeTDCSo+6f/4yxx4+USL+JhuDm46aeFQHnrsNTKtz5f
         BvMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EIIAdlpLZ8QWBpnk1CRK2E0QztRVUXlgOgWtUcAY46M=;
        b=osESOsNHsvKzPRo4J1EY43NjOzWjAlcIVJBplRkU+o7RNz0fr+aH877xurggajSVrS
         jZU3Tt4qVbAgynhxgD7mkhlFSK4A3JOoNFu7LqNUVGT3qzClCh3EgDEF15V5lsx5V+4v
         yiVrtcExb9bhKXmtXX8t+C41yIcanepbNL1ZoTMpiHsu3DLsvSQU0I92ao4YMMd9I86Q
         9i6ItBPr3SxpqlC/RPDNRZBhXz+1F6/ozRRptlbwRj++1klE7z+ZOSxfnOhKiW/6gZs9
         WTxjdMKDMlS0a2oevoM3pMg9qR9idh0J8TsPZw4hf0oJnxreJLEueWFjNkVzj5J9UWw0
         yfGw==
X-Gm-Message-State: AOAM531quUWlKaMG6bs1f8sWX0keJJuPzCKHgUT3w4mFbtPaxstY3QTV
        i5oSj/xbHZCEYitXSJ7/MCkmjPbpdylfCXJF+Qg=
X-Google-Smtp-Source: ABdhPJzlOLGaedvGY0t53LigT8Ie6XY07foLbBDtg/JBNERM7pSWvgWvvLebDl367og99Xdwz3l7eoxc7i+DH0UFv9g=
X-Received: by 2002:a9d:4a9c:: with SMTP id i28mr3342497otf.340.1601124440265;
 Sat, 26 Sep 2020 05:47:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAF4BF-SFHA=mPHLxpDHGMLvgu0UKO-6ujfYB+n2a6=XhFvT6DA@mail.gmail.com>
 <b009a2a8-64a5-fe66-a53e-5a93135cf1f8@datenfreihafen.org> <CAF4BF-SNRyXQzUBqx5k014nZou4q7=Gd8=dbUyK7JiDkaEEvFA@mail.gmail.com>
 <f98b4515-9570-ad48-2d8f-dcc5482a21a1@datenfreihafen.org> <CAF4BF-SipApoY=7CY8fWs8cSi8rKZaYMxOZHAqoKv=poAgVm=Q@mail.gmail.com>
 <61ffa93d-f8cf-b059-358c-84a6e04b96ac@bergzand.net> <CAF4BF-Re1CoR8abM=hvKN=TojDoLL_PRAJTvjWzB-Ak8tKTvRg@mail.gmail.com>
 <e5d22300-fccc-5a0f-6776-5438bfad57e1@datenfreihafen.org> <0ccbc151-cf8e-cd56-28f8-f1594d226056@bergzand.net>
 <6d787a84-56ba-2dcf-af5c-6f05cec6194a@datenfreihafen.org> <71f4ce0f-5614-6410-9c8b-72a87ab7473d@datenfreihafen.org>
In-Reply-To: <71f4ce0f-5614-6410-9c8b-72a87ab7473d@datenfreihafen.org>
From:   Christopher Friedt <chrisfriedt@gmail.com>
Date:   Sat, 26 Sep 2020 08:47:09 -0400
Message-ID: <CAF4BF-TG4wpX8TdEXY=EeTz4HV0b-nceFwKb=VkFBkMjfSLPew@mail.gmail.com>
Subject: Re: wpanusb?
To:     Stefan Schmidt <stefan@datenfreihafen.org>
Cc:     Koen Zandberg <koen@bergzand.net>, linux-wpan@vger.kernel.org,
        Andrei Emeltchenko <andrei.emeltchenko@intel.com>,
        erik@statropy.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

On Sat, Sep 26, 2020 at 8:28 AM Stefan Schmidt
<stefan@datenfreihafen.org> wrote:
> On 24.07.20 15:41, Stefan Schmidt wrote:
> > [Added Erik here to be part of the discussion]
> >
> > This mostly goes to Koen and Erik. Please coordinate how you are wanting
> > to work on this. And be pro-active. Waiting for the other one to start
> > will just lead to starving :-)
>
> With silence from both of you on this I would assume neither had time to
> look over this. Correct?

On the contrary, Erik & I are working on it right now (although mostly
from the Zephyr side) ;-)

We expect to have something demonstrable with the cc1352r within a
week or 2, at which point I would very much like to work on
upstreaming wpanusb with the additional features.

In Zephyr, I recently got Sub GHz IEEE 802.15.4g running on the
cc1352r1_launchxl. Did a fairly big overhaul of the 2.4 GHz driver as
well. SubG should be able to run simultaneously to 2.4 GHz, and beyond
that, the driver is written so that BLE will work concurrently at 2.4
GHz (with arbitration).

I might need to send you one more dev board though for testing
purposes, because the cc1352r requires a second chip for USB.
BeagleBoard.org is currently preparing for manufacturing of the
BeagleConnect which includes the cc1352 and the USB chip The official
release date is not announced yet.

I have not touched MLME yet unfortunately due to contractual obligations.

Also, somewhat annoying, but a shoddy USB hub damaged my ATUSB :( I
ordered 2 more, so hopefully they get to me shortly!

C
