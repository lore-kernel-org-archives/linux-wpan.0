Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:33867 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754022AbbDJIfK (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 10 Apr 2015 04:35:10 -0400
Received: by widjs5 with SMTP id js5so11046338wid.1
        for <linux-wpan@vger.kernel.org>; Fri, 10 Apr 2015 01:35:09 -0700 (PDT)
Date: Fri, 10 Apr 2015 10:35:03 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [RFC bluetooth-next 0/4] ieee802154: add support for phy
 capabilities
Message-ID: <20150410083500.GA709@omega>
References: <1428491912-14027-1-git-send-email-alex.aring@gmail.com>
 <55261CEA.9080503@gmail.com>
 <20150409092818.GC1261@omega>
 <55264853.7060404@gmail.com>
 <20150409113658.GF1261@omega>
 <20150409123334.GI1261@omega>
 <55274B1A.2050900@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <55274B1A.2050900@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, Phoebe Buckheister <phoebe.buckheister@itwm.fraunhofer.de>

Hi Varka,

On Fri, Apr 10, 2015 at 09:31:30AM +0530, Varka Bhadram wrote:
> 
> I think better interface would be get_tx_power() for returning the current power setting

No, we have already such functionality to get the current tx power and
the 802.15.4 standard describes this as part of the pib. [0] 802.15.4
describes this as integer and I hope s8 is enough as range. But this is
funny then, because transceivers allow also floating point dbm values :-)
That 802.15.4 describes this as integer we should use a int (s8) as well here,
that was a open question in my other mails.

This pib attribute should be also set if set_tx_power was successful
afterwards with the values which was set.

> and tx_power_supported() to get the all the available power levels.
> 

Yes we talking about the capabilities here only:

The general question about this capability is:

  1.  Does this interface will report all power levels for all page/channel?

  or

  2. Does this interface will report all power levels for current
     page/channel setting only?

  The second one is much easier to implement. But this is a question
  which should be answered before.

  If you asking yourself "which tx_powers for each ch/page?" This is not
  available for 2.4 Ghz transceivers, but transceivers like the
  at86rf212 which operates in 700/800/900Mhz have different tx power
  settings according the channel/page setting.


The subquestion is here more how we should implement it. Current
solutions are:

  1. Create a big array with some mask and set the bit about some
     tx_power range and do some mask |= BIT(SUPP_5DBM). But this will
     restrict the available setting of dbm levels.

  2. The second idea was do use a "context based iteration of available
     tx power settings". Netlink can do this quite well with nested
     attributes. Calltrace would look like:

     nla_nest_start
     rdev_get_tx_pwr(&pwr)
          rdev->ops->get_tx_pwr(&pwr)
	        mac802154_get_tx_pwr(&pwr)
		    /* driver_will_set_tx_pwr #1 */
     nla_put_s8(pwr)
     rdev_get_tx_pwr(&pwr)
          rdev->ops->get_tx_pwr(&pwr)
	        mac802154_get_tx_pwr(&pwr)
		    /* driver_will_set_tx_pwr #2 */
     nla_put_s8(pwr)
     rdev_get_tx_pwr(&pwr)
          rdev->ops->get_tx_pwr(&pwr)
	        mac802154_get_tx_pwr(&pwr)
		    /* driver_will_set_tx_pwr #3 */
     nla_put_s8(pwr)
     ....
     ....
     ....
     rdev_get_tx_pwr(&pwr)
          rdev->ops->get_tx_pwr(&pwr)
	        mac802154_get_tx_pwr(&pwr)
		    /* driver_will_set_tx_pwr last. Must return 1 */
     nla_put_s8(pwr)
     /* indicated because rdev_get_tx_pwr returned 1 */
     nla_nest_end


If you tell me you want "tx_power_supported()", please give me more
details how this interface will be look like.

- Alex

[0] http://lxr.free-electrons.com/source/include/net/cfg802154.h#L78
[1] http://www.atmel.com/images/doc8168.pdf page 107
