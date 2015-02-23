Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:34638 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752186AbbBWRci (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 23 Feb 2015 12:32:38 -0500
Received: by mail-wi0-f179.google.com with SMTP id hi2so19320382wib.0
        for <linux-wpan@vger.kernel.org>; Mon, 23 Feb 2015 09:32:36 -0800 (PST)
Date: Mon, 23 Feb 2015 18:32:33 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [Linux-zigbee-devel] mac802154 development
Message-ID: <20150223173228.GB16372@omega>
References: <02E1EC3037481742A4C5830E984A9E9AA474DF@SRV-DE08.ddel.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <02E1EC3037481742A4C5830E984A9E9AA474DF@SRV-DE08.ddel.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: "Ludwig, Mike" <ml@dresden-elektronik.de>
Cc: "linux-zigbee-devel@lists.sourceforge.net" <linux-zigbee-devel@lists.sourceforge.net>, linux-wpan@vger.kernel.org

Hi,

please DON'T use the sourceforge mailinglist. We have linux-wpan now
[1]. 

On Mon, Feb 23, 2015 at 04:38:29PM +0000, Ludwig, Mike wrote:
> Hi,
> 
> I'm currently trying to get a grip on the IEEE 802.15.4 stack in mainline and bluetooth-next. I do succeed in using the fakehard.ko and fakelb.ko to add a wpan-phy for MAC or 6LoWPAN operations. However, doing real stuff on the MAC seems still broken as already mentioned here (Re: [Linux-zigbee-devel] 802.15.4 scan, scan_req and ieee802154_nl_scan_confirm()<http://www.spinics.net/lists/linux-wpan/msg00365.html>). That is, a scan - which would be the first step in network establishment - still fails

yes you are right any mlme ops was never "right" implemented. What you
see there is only some callbacks structures to make them available for
HardMAC drivers. (Then you need only to implement the interface and not
the real algorithm). That's my assumptation what the previous
maintainers did there.

> 
> As far as I can tell the status of the MAC in bluetooth-next has not changed since this post. I guess the rework is still in progress.

Yes the rework is still in progress and the MLME ops state isn't changed
yet. The rework will do some things more "generic" so we have the chance
to implement MLME ops.

The rework also contains various changes to grab some good things from
wireless stack but with 802.15.4 functionality.

> Are there may some preliminary rework results (without any support), that could be tested? My intention would be to test the kernel implementation against the current lowpan-tools, or is there anything blocking this?
> 

You need the wpan-tools which is based on iw now. See [0].

> I finally would like to establish a WPAN with linux being either  coordinator or device for plain IEEE 802.15.4 and 6LoWPAN communication using some simple modules (e.g. Atmel based Transceiver or SoC). I would hope this to be possible with the lowpan-tools but welcome any new tools there as well.
> 

See [0], but we also have no coordinator support. The further plans are
to add a "coordinator" interface type.

> I would welcome any hints on getting closer to this. Thanks a lot in advance.
> 
> Best regards
> 
> 

- Alex

[0] http://wpan.cakelab.org/
[1] http://vger.kernel.org/vger-lists.html#linux-wpan
