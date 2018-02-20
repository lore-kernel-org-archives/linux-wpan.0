Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-it0-f41.google.com ([209.85.214.41]:35646 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932410AbeBTDoJ (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 19 Feb 2018 22:44:09 -0500
Received: by mail-it0-f41.google.com with SMTP id v194so11097579itb.0
        for <linux-wpan@vger.kernel.org>; Mon, 19 Feb 2018 19:44:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAJuUDwv4re4ig9v4yZGW_xeQZr=yHfvMode-wgsoNGheoqqM=A@mail.gmail.com>
References: <1519037471-17668-1-git-send-email-liuxuenetmail@gmail.com>
 <1519037471-17668-4-git-send-email-liuxuenetmail@gmail.com>
 <20180219163107.GB27116@work.Speedport_W_724V_09011603_05_013>
 <CAJuUDwu_TmCMZt7sQpQdip0J5DOe-nJT47G0V4K4kg3cffEfsw@mail.gmail.com>
 <9bd4f9bc-e0be-a5e0-87ed-5245b5cf3642@osg.samsung.com> <CAJuUDwv4re4ig9v4yZGW_xeQZr=yHfvMode-wgsoNGheoqqM=A@mail.gmail.com>
From: Alexander Aring <alex.aring@gmail.com>
Date: Mon, 19 Feb 2018 22:44:08 -0500
Message-ID: <CAB_54W7GvgkCqd1HoGs3RrsarRHfyQ346tYbbWbDPjkUEd46-A@mail.gmail.com>
Subject: Re: [PATCHv2 3/3] ieee802154: Add MCR20A IEEE 802.15.4 device driver
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Xue Liu <liuxuenetmail@gmail.com>
Cc: Stefan Schmidt <stefan@osg.samsung.com>, linux-wpan - ML <linux-wpan@vger.kernel.org>

Hi,

2018-02-19 18:49 GMT-05:00 Xue Liu <liuxuenetmail@gmail.com>:
> Hello.
>
> I have one more question about ieee802154_ops.ed function. How to test
> this function ? Thanks

This function is/was never used by the subsystem. It has historical
reason _why_ this function is still there... The original repository
had "something" half working of MLME-SCAN (In my opinion). They got
this callback there but then nothing more...

What you could introduce is a netlink notifier command which reports
by reaching some threshold, e.g.

iwpan phy0 get edthresh $VAL -> blocks until ed reached above thresh,
which should happen when transmit is going on on your channel...

Or just a get command?

There exists also various way to receive ED values, we should offer
them as well than just trigger it from outside, e.g. after each frame
rx... this need to be collected at a main point.

- Alex
