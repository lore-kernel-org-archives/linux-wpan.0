Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:36474 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752165AbbCWH62 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 23 Mar 2015 03:58:28 -0400
Received: by wibg7 with SMTP id g7so39945842wib.1
        for <linux-wpan@vger.kernel.org>; Mon, 23 Mar 2015 00:58:27 -0700 (PDT)
Date: Mon, 23 Mar 2015 08:58:21 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: hardware recommendation
Message-ID: <20150323075818.GA4069@omega>
References: <8575BDE3-5617-49A9-AF9C-D0C9359E074E@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8575BDE3-5617-49A9-AF9C-D0C9359E074E@cisco.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: "Ralph Droms (rdroms)" <rdroms@cisco.com>
Cc: "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>

Hi Ralph,

welcome back.

On Sun, Mar 22, 2015 at 03:28:36PM +0000, Ralph Droms (rdroms) wrote:
> What hardware - radio board, interface, Linux platform - are recommended for the 802.15.4 stack in the bluetooth-next kernel?
> 

See [0].

Radio board:

  - I would advice a 2.4 Ghz at86rf231 or at86rf233 [1].
     Supports async xmit handling and has the most supported hardware
     flags. Driver is at86rf230.

Interface:
  - What you mean with interface? Bus Interface? -> SPI. Or netlink
    interface? -> nl802154 with wpan-tools. Don't understand the
    question.

Linux platform:
  - I think you mean some architecture -> ARM. Then the platform, some
    board: The transceiver at [1] was made for RPi which works well on
    my side. But the RPi has a lack of mainline support. You have no
    USB, this means you have also no ethernet. If you don't need
    ethernet, then I would use a simple RPi. If you need ethernet I
    would advice to make some adapter board to add the [1] on a
    beaglebone [2], which have a good mainline support. This require
    some hardware hacking skills.

    Note: for RPi I also support you have no other support e.g. HDMI
    output or something else. SPI with RPi works mainline perfectly.

> - Ralph
> 
> BTW, is this list archived?  Where?
>

Over google I detected that spinics archive this mailinglist [3] (but
doesn't include the early days).

- Alex

[0] http://wpan.cakelab.org/
[1] http://openlabs.co/store/Raspberry-Pi-802.15.4-radio
[2] http://beagleboard.org/
[3] http://www.spinics.net/lists/linux-wpan/

