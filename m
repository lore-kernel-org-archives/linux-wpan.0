Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:32954 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750833AbcFVIMt (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Wed, 22 Jun 2016 04:12:49 -0400
Subject: Re: [RFC bluetooth-next] 6lowpan: add debugfs to get lltype
References: <20160621144656.32469-1-aar@pengutronix.de>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <7d9424ba-6d55-1ca3-2bbe-787221ac4440@pengutronix.de>
Date: Wed, 22 Jun 2016 10:12:38 +0200
MIME-Version: 1.0
In-Reply-To: <20160621144656.32469-1-aar@pengutronix.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org, kernel@pengutronix.de, patrik.flykt@linux.intel.com, jukka.rissanen@linux.intel.com

Hi,

On 06/21/2016 04:46 PM, Alexander Aring wrote:
> This patch adds debugfs entry for get the link layer type for userspace.
> 
> Signed-off-by: Alexander Aring <aar@pengutronix.de>
> ---
> Patrik,
> 
> after changing the dev->addr_len = 6 in btle 6lowpan. I think you should
> add this patch to the end of your patch series. Then a "recent" radvd will use
> the correct hardware address length.
> 

please ignore this patch. After chatting with Marcel we need a better
UAPI for bringing features into upstream radvd... and maybe RTNL has the
feature to get the dev->addr_len. :-)

I will try to add the current stuff which we have in debugfs into some
netlink UAPI.

- Alex
