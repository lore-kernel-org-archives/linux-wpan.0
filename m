Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:34034 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752783AbbETHjE (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 20 May 2015 03:39:04 -0400
Received: by wghq2 with SMTP id q2so43200528wgh.1
        for <linux-wpan@vger.kernel.org>; Wed, 20 May 2015 00:39:03 -0700 (PDT)
Date: Wed, 20 May 2015 09:38:57 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: Your recent work on at86rf230 kernel driver
Message-ID: <20150520073812.GA732@omega>
References: <CAK+9TkJKRgvNYzd5DULRAmCQuP19yxqS_god+s7202tXzpeauw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK+9TkJKRgvNYzd5DULRAmCQuP19yxqS_god+s7202tXzpeauw@mail.gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Craig Younkins <craig@freshtemp.com>
Cc: Ian Core <ic@freshtemp.com>, varkabhadram@gmail.com, linux-wpan@vger.kernel.org

On Tue, May 19, 2015 at 03:24:24PM -0400, Craig Younkins wrote:
> Hi Alex,
> 

...

> Unfortunately we still don't have it working. Quick question: Should
> wpan-tools support changing the TX power now? We have tried using
> wpan-tools commit 64a53f3 with a 212B.

Getting the values is currently supported and I reworked the transmit
power _setting_ in the at86rf230 driver. These steps are necessary to
support the transmit power setting. Varka Bhadram had support the
_setting_ of transmit power before [0]. He need to rebase his work and
change to mbm value handling, also he need to update the wpan-tools but
then it should work.


Varka are you already working on this? It's okay to make this now over
the NL802154_CMD_SET_TX_POWER cmd.

> 
> pi@raspberrypi ~/wpan-tools $ iwpan phy
> wpan_phy phy0
> supported channels:
> page 0: 0,1,2,3,4,5,6,7,8,9,10
> page 2: 0,1,2,3,4,5,6,7,8,9,10
> current_page: 0
> current_channel: 5
> cca_mode: 1
> tx_power: 5
> capabilities:
> iftypes: node,monitor
> channels:
> page 0: 0,1,2,3,4,5,6,7,8,9,10
> page 2: 0,1,2,3,4,5,6,7,8,9,10
> tx_powers:
> 5,4,3,2,1,0,-1,-2,-3,-4,-5,-6,-7,-8,-9,-10,-11,-12,-13,-14,-15,-16,-17,-18,-19,-20,-21,-22,-23,-24,-25,-26
> cca_ed_levels:
> -1e+02,-98,-96,-94,-92,-90,-88,-86,-84,-82,-80,-78,-76,-74,-72,0

Thanks for this output it shows me an issue with the cca_ed_levels and
the at86rf212 transceiver.

- Alex

[0] http://www.spinics.net/lists/linux-wpan/msg01560.html
