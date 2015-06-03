Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:34391 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753465AbbFCHsf (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 3 Jun 2015 03:48:35 -0400
Received: by wibut5 with SMTP id ut5so92996229wib.1
        for <linux-wpan@vger.kernel.org>; Wed, 03 Jun 2015 00:48:34 -0700 (PDT)
Date: Wed, 3 Jun 2015 09:48:32 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next] nl802154: export supported commands
Message-ID: <20150603074828.GE731@omega>
References: <1433304841-12734-1-git-send-email-varkab@cdac.in>
 <20150603064950.GB731@omega>
 <556EA90D.4080203@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <556EA90D.4080203@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-wpan@vger.kernel.org, Varka Bhadram <varkab@cdac.in>

On Wed, Jun 03, 2015 at 12:43:17PM +0530, Varka Bhadram wrote:
> On 06/03/2015 12:19 PM, Alexander Aring wrote:
> 
> >Hi,
> >
> >On Wed, Jun 03, 2015 at 09:44:01AM +0530, Varka Bhadram wrote:
> >>This patch will export the supported commands by the devices
> >>to the user. This is required because user should know supported
> >>commands by the IEEE-802.15.4 devices. Drivers that are there in
> >>the mainline are not supporting all the functionalities that the
> >>core is providing to us.
> >>
> >I think this is not the reason why this was implemented. You check here
> >cfg802154_ops which ends in mac802154 (SoftMAC) OR _possible_ HardMAC drivers.
> >
> >If you want to make sure that a driver implement it _and_ really sure
> >you need to check on ieee802154_ops.
> >
> >I suppose the real reason why wireless has this implementation, is
> >because to check if HardMAC drivers can support a specific command.
> >This is because every HardMAC driver should implement then the full
> >cfg802154_ops callback structure. It's simple wrong here to say "to
> >check if the driver support the functionalities".
> 
> I found this thread for the reason used in wireless for implementation.
> 
> http://www.spinics.net/lists/linux-wireless/msg29923.html
> 

Yea, but in this case he means really HardMAC drivers only which
implements some cfg802154_ops which others doesn't implement.

I would split our use cases in two categories: setting phy or mac cmds.


for phy setttings cmds:

You can check if the phy supports the specific CMD. E.g. tx_power,
before calling the specific cmd. The cmd will not set because you check the
phy flags.


for mac setttings cmds:

This currently makes no sense, because these are all supported by the
mac802154 layer and we have currently no HardMAC drivers. Each HardMAC
driver implements the cfg802154_ops and then it could make sense to
check if the HardMAC driver supports a specific command.

At the moment for mac settings (in case of SoftMAC) it should display
always the same.



Nevertheless, I would ack this. This would be useful if somebody wants
to implement a HardMAC driver.

- Alex
