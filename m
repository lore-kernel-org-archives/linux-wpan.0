Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f181.google.com ([74.125.82.181]:33131 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754448AbbCRLwQ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 18 Mar 2015 07:52:16 -0400
Received: by weop45 with SMTP id p45so30241015weo.0
        for <linux-wpan@vger.kernel.org>; Wed, 18 Mar 2015 04:52:15 -0700 (PDT)
Date: Wed, 18 Mar 2015 12:52:12 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next 1/2] nl802154: add set wpan phy cmd
Message-ID: <20150318115211.GB8079@omega>
References: <1426678822-26644-1-git-send-email-alex.aring@gmail.com>
 <1426678822-26644-2-git-send-email-alex.aring@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1426678822-26644-2-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, mkl@pengutronix.de

Hi,

On Wed, Mar 18, 2015 at 12:40:21PM +0100, Alexander Aring wrote:
...
>  	{
> +		.cmd = NL802154_CMD_SET_WPAN_PHY,
> +		.doit = nl802154_set_wpan_phy,
> +		.done = nl802154_dump_wpan_phy_done,

this should not belong there, please drop this patch Marcel.
It's a copy&paste error.

Thanks.

- Alex
