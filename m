Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:38736 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751973AbcGXUct (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 24 Jul 2016 16:32:49 -0400
Received: by mail-wm0-f43.google.com with SMTP id o80so130737592wme.1
        for <linux-wpan@vger.kernel.org>; Sun, 24 Jul 2016 13:32:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1a77b106-bc45-e5da-e122-d4e0713539d8@pengutronix.de>
References: <CADaJnMajA0y7t7=+vAE6FcSnY3a0_uLg5wpa2ThgRZRj3Qny3w@mail.gmail.com>
 <CADaJnMYdcj0RDR2iZW2FmAzgpS2X7KxE4RkTA5XzY0im12UbDg@mail.gmail.com> <1a77b106-bc45-e5da-e122-d4e0713539d8@pengutronix.de>
From: Aaron Sowry <aeneby@gmail.com>
Date: Mon, 25 Jul 2016 08:32:46 +1200
Message-ID: <CADaJnMabq8EE11a-18iaQr7yECRKEMKZsBPUbi65Tdk2F==+6A@mail.gmail.com>
Subject: Re: Packets not reaching lowpan interface
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>
Cc: linux-wpan@vger.kernel.org

Hi Alex

2016-07-24 22:03 GMT+12:00 Alexander Aring <aar@pengutronix.de>:
>
> I don't know which version on RIOT does this behaviour, we should open
> an issue at github RIOT-OS project if this issue still exists. Please
> check if you seeing on wireshark that it is intra pan communication but
> the intra pan id bit isn't set.

You're absolutely right - both SRC and DST PANs are being put in the
header by RIOT, and the intra-pan bit set to 0, even though the PANs
are the same. If I cook the packet slightly so it is properly
constructed before sending, everything starts working fine.

> Another chance to fix this issue is to backport [0] and some other
> patches to get it working.

Actually, I don't think the intra-pan packets currently being sent out
by RIOT are valid 802.15.4. From the spec (page 154):

"If the PAN identifiers are identical, the intra-PAN subfield of the
frame control field shall be set to 1, and the source PAN identifier
shall be omitted from the transmitted frame."

So IMO this is a bug in RIOT - whether or not Linux should handle this
type of packet anyway is a matter of opinion, I guess.

> We should really open a issue on that, that this is broken @RIOT-OS git
> version. Maybe somebody can bisect it? To get the broken commit id.

https://github.com/RIOT-OS/RIOT/issues/5684

Thanks very much for your insight on this one.

/Aaron
