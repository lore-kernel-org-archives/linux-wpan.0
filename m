Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:36842 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093AbbCTQDK (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 20 Mar 2015 12:03:10 -0400
Received: by wgra20 with SMTP id a20so93034126wgr.3
        for <linux-wpan@vger.kernel.org>; Fri, 20 Mar 2015 09:03:09 -0700 (PDT)
Date: Fri, 20 Mar 2015 17:03:06 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next 2/3] cc2520: add set transmit power support
Message-ID: <20150320160302.GD3952@omega>
References: <1426836141-21528-1-git-send-email-varkab@cdac.in>
 <1426836141-21528-2-git-send-email-varkab@cdac.in>
 <105301d062ef$08380820$18a81860$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <105301d062ef$08380820$18a81860$@samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <s.schmidt@samsung.com>
Cc: 'Varka Bhadram' <varkabhadram@gmail.com>, linux-wpan@vger.kernel.org, 'Varka Bhadram' <varkab@cdac.in>

On Fri, Mar 20, 2015 at 09:19:56AM +0000, Stefan Schmidt wrote:
> Hello.
> 
> On 20/03/15 08:22, Varka Bhadram wrote:
> >Signed-off-by: Varka Bhadram <varkab@cdac.in>
> >---
> >  drivers/net/ieee802154/cc2520.c |   56
> >++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 55 insertions(+), 1 deletion(-)
> >
> >diff --git a/drivers/net/ieee802154/cc2520.c
> >b/drivers/net/ieee802154/cc2520.c
> >index f833b8b..f96cc50 100644
> >--- a/drivers/net/ieee802154/cc2520.c
> >+++ b/drivers/net/ieee802154/cc2520.c
> >@@ -53,6 +53,17 @@
> >  #define	CC2520_MAXCHANNEL		26
> >  #define	CC2520_CHANNEL_SPACING		5
> >

...

> >+}
> >+
> 
> Thanks for working on the power setting API.
> 

agree.

> One thing I find problematic here is that the user has to know the values it
> can set for the db level beforehand and these values can change for
> different transceivers. Which makes these nl call hardware depended.
> 
> We should at least have a way to query what db levels are available or
> better see if we can harmonize the setting over different drivers and
> transceivers.
> 

agree, here too. But we also need that for the current others phy
settings like cca modes. There exist also MAC settings like
MIN_BE/MAX_BE (csma backoffs) which cannot support every phy. (I also
saw transceivers like mrf24j40 [0] which can set MIN_BE only. I suppose
that MAX_BE is always be 802.15.4 default).

Back to the txpower setting, what I previous mention in another mail is
that for transceivers which supports mutliple bands/modulations the supported
txpower dbm values differs. For example the at86rf212 [1]. This means
that we need some mechanism to handle that.

I imagine the following scenario.

1. Somebody wants to know all txpower settings for all bands.

   Then we need some big array which is filled at probe time.



2. Somebody wants to know all txpower settings of the current
   page/channel setting.

   This would be much easier, I found two solutions:

     1. add some supported_txpower array, which is updated while channel
        /page setting. (Also for reset values while probing).

     2. have a driver callback which will fill some dbm values and the driver
        decide of the current channel/page settings how this array is filled.

   I would prefer the 1. solution because that's similar like the PHY
   PIB handles the channels_supported array, then we have something like
   txpower_supported.


The point is we can support such feature later, currently the only one
way is to do try and error and look if -EINVAL is returned. :D

btw:
All phy settings are direct calls to the driver layer, but for mac
settings this is more problematic, because we only can decide if the phy
supports the setting on an interface up. This sucks! This means you set
some value which is 802.15.4 complaint and is successful on interface
down. Then an interface up will return -EINVAL and you don't know why.
:-/

That's why we need also something like "csma_backoffs_supported" thing
(array/flag/I don't know, better flags) and check this while setting
the backoffs while interface down.

The good thing is, we don't have such transceiver currently. The
at86rf230 supports all 802.15.4 values and (sometimes) beyond.

All MAC settings which is handled by phy need such checking and
supported array.

- Alex

[0] http://ww1.microchip.com/downloads/en/DeviceDoc/39776C.pdf
[1] http://www.atmel.com/images/doc8168.pdf
