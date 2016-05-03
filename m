Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:52513 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756148AbcECUHj (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 3 May 2016 16:07:39 -0400
Date: Tue, 03 May 2016 16:07:37 -0400 (EDT)
Message-Id: <20160503.160737.1681209955436308203.davem@davemloft.net>
Subject: Re: [PATCHv2 bluetooth-next 00/10] 6lowpan: introduce basic
 6lowpan-nd
From: David Miller <davem@davemloft.net>
In-Reply-To: <58926844-0338-4D63-A5B6-DB0EBE903A0E@holtmann.org>
References: <D212A5BF-A414-403B-A409-1F8C2D279883@holtmann.org>
	<870fdf5f-82ed-b621-a8d5-625bf9d81d0d@stressinduktion.org>
	<58926844-0338-4D63-A5B6-DB0EBE903A0E@holtmann.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: marcel@holtmann.org
Cc: hannes@stressinduktion.org, aar@pengutronix.de, linux-wpan@vger.kernel.org, kernel@pengutronix.de, jukka.rissanen@linux.intel.com, stefan@osg.samsung.com, mcr@sandelman.ca, werner@almesberger.net, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, kuznet@ms2.inr.ac.ru, jmorris@namei.org, yoshfuji@linux-ipv6.org, kaber@trash.net

From: Marcel Holtmann <marcel@holtmann.org>
Date: Mon, 2 May 2016 16:17:41 -0700

>> My proposal would be that the IPv6 patches go via net-next to reduce
>> merge conflicts with maybe upcoming changes. If they are split up, they
>> seem very much self contained and easy to review. The rest seems to be
>> also very much self contained and can go in via bluetooth-next, then.
>> What do you think?
>
> I am actually fine with having this all go via net-next. We only
> have driver patches pending in bluetooth-next for the next merge
> window. Which means I can just pull net-next back into
> bluetooth-next at any time.

Ok, just resubmit the series explicitly targetting net-next then.

Thanks.
