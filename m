Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:34385 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752245AbbFBGt7 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 2 Jun 2015 02:49:59 -0400
Received: by wibut5 with SMTP id ut5so59085756wib.1
        for <linux-wpan@vger.kernel.org>; Mon, 01 Jun 2015 23:49:58 -0700 (PDT)
Date: Tue, 2 Jun 2015 08:49:52 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [RFC bluetooth-next] nl802154: export supported commands
Message-ID: <20150602064949.GA795@omega>
References: <1433223599-22548-1-git-send-email-varkab@cdac.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1433223599-22548-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-wpan@vger.kernel.org, Varka Bhadram <varkab@cdac.in>

On Tue, Jun 02, 2015 at 11:09:59AM +0530, Varka Bhadram wrote:
> This patch will export the supported commands by the devices
> to the user. This is required because user should know supported
> commands by the IEEE-802.15.4 devices. Drivers that are there in
> the mainline are not supporting all the functionalities that the
> core is providing to us.
> 
> Signed-off-by: Varka Bhadram <varkab@cdac.in>
> ---
> Hi,
> 
> I am looking for the way to export the following commands
> 	o NL802154_CMD_SET_MAX_FRAME_RETRIES
>         o NL802154_CMD_SET_BACKOFF_EXPONENT
>         o NL802154_CMD_SET_MAX_CSMA_BACKOFFS
> 
> Any inputs..?
> 

These commands are always supported. If a driver doesn't support it,
indicated by the hw flags, then we assume 802.15.4 defaults.

If you driver doesn't fit to the 802.15.4 you need to change it,
otherwise it's a bug in your driver.

It's a little bit more complex, the backoffs and backoffs exponent depends
if max frame retries supports values above or equal 0. But then you should
assume the 802.15.4 defaults for these values if your transceiver supports
"-1" only.

These parameters above are for the MAC settings of 802.15.4 and the
802.15.4 standard describes for each a "default parameter". It's very
simple, if the driver doesn't tell anything we assume these defaults
parameters and you can't set your transceiver outside of this parameter
via nl802154.


PHY settings are different, because 802.15.4 describes no default
settings for PIB attributes. We don't assume nothing here, but is also a
bug inside your driver because you don't support WPAN_PHY_FLAG for e.g.
tx power, because sending without any tx power makes no sense.
Nevertheless the driver doesn't support to ask which one.

The same for CCA handling (when max frame retries are 0 or above, that
actually means CSMA-CA handling).



Now:

On MIB values the 802.15.4 describes default setting, if the driver
doesn't support it we assume "defaults". On PIB values the standard
describes no default values and we assume nothing, it's indicated by the
WPAN_PHY_FLAG if the driver supports to ask the current setting or not.

But also on phy settings (TX_POWER, CCA_MODE (CCA_ED_LEVEL depends if
the right CCA_MODE is supported)), but this _sometimes_ (in case of tx
power _always_) doesn't represent the reality. A phy which transmit has
always some tx power setting.

- Alex
