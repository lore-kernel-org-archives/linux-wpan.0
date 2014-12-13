Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:33510 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966264AbaLMJIa (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 13 Dec 2014 04:08:30 -0500
Received: by mail-wi0-f179.google.com with SMTP id ex7so4702856wid.6
        for <linux-wpan@vger.kernel.org>; Sat, 13 Dec 2014 01:08:28 -0800 (PST)
Date: Sat, 13 Dec 2014 10:08:26 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next 15/18] at86rf230: generate random perm
 extended address
Message-ID: <20141213090823.GB31962@omega>
References: <1415217089-24919-1-git-send-email-alex.aring@gmail.com>
 <1415217089-24919-16-git-send-email-alex.aring@gmail.com>
 <CAEUmHyb8VNaXVZKPuP-81ywMG_soVduT69sogD1Qa3DqR1SeiQ@mail.gmail.com>
 <20141106100552.GB1071@x61s.campuswlan.hs-rm.de>
 <20141212145619.GE381@omega>
 <CAEUmHya_1iG9Rs-Wq+bq8MT2rwjgG_zUvr8wB-zTLnSCyj-StA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEUmHya_1iG9Rs-Wq+bq8MT2rwjgG_zUvr8wB-zTLnSCyj-StA@mail.gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-wpan - ML <linux-wpan@vger.kernel.org>, kernel@pengutronix.de

Hi Varka,

On Sat, Dec 13, 2014 at 10:28:24AM +0530, Varka Bhadram wrote:
> For CC2520 the extended address is software defined.
> So the default case is possible for CC2520.
> 
> We may need to add ieee802154_random_extended_addr().
> 

ok, this sounds good.

I think if the transceiver chip doesn't support such function it could
be that some board designer for the transceiver place some eeprom on it.



What I mean is somebody builds a CC2520 transceiver board with an
eeprom. The eeprom contains the EUI-64 address. Then we need some
mechanism to connect them (I think the common way is devicetree) to
readout the eeprom and set the perm address.

I think this should not touch the driver layer, so random extended addr
should be fine. The same is for an eeprom which is placed on the dev
board and contains the necessary EUI-64 address information.

This is for some further 802.15.4 work.

- Alex
