Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-it0-f48.google.com ([209.85.214.48]:37683 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932370AbeBTDhU (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 19 Feb 2018 22:37:20 -0500
Received: by mail-it0-f48.google.com with SMTP id d10so11565444itj.2
        for <linux-wpan@vger.kernel.org>; Mon, 19 Feb 2018 19:37:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <23732.1519061365@obiwan.sandelman.ca>
References: <1519037471-17668-1-git-send-email-liuxuenetmail@gmail.com>
 <1519037471-17668-4-git-send-email-liuxuenetmail@gmail.com> <23732.1519061365@obiwan.sandelman.ca>
From: Alexander Aring <alex.aring@gmail.com>
Date: Mon, 19 Feb 2018 22:37:19 -0500
Message-ID: <CAB_54W62Q+F80mxW4y_f4VuYOdiG=XPT=QcTwH2QwvXN9niLsQ@mail.gmail.com>
Subject: Re: [PATCHv2 3/3] ieee802154: Add MCR20A IEEE 802.15.4 device driver
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Michael Richardson <mcr@sandelman.ca>
Cc: Xue Liu <liuxuenetmail@gmail.com>, linux-wpan - ML <linux-wpan@vger.kernel.org>

Hi,

2018-02-19 12:29 GMT-05:00 Michael Richardson <mcr@sandelman.ca>:
> Xue Liu <liuxuenetmail@gmail.com> wrote:
>     > This driver implements a subset of ieee802154_ops. It has no support
>     > for CSMA due to lack of hardware support. It has currently no support
>     > for its proprietary feature: Dual PAN.
>
> I think you mean, that the driver has no support for the MCR20A Dual
> Pan feature, because the 802.15.4 layer has no way to deal with it.
>
> A suggestion is to create two virtual devices!
>

If they can run on two different frequencies:

Create two wpan-phy's - yes. (Which is a _device_ class)

If they run on two different PANs:

Create two wpan interfaces on top of one wpan phy.

----

But so far I remember it is some crazy "I can transmit on different
pans with internal channel hopping by doing hardware offload" (It's
still _one_ radio, in sense one transmit/receive medium) then do:

nothing of that above - this need to be handled by some internal
subsystem handling, if a use case exists.

- Alex
