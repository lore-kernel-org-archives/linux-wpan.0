Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:64603 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752744AbbEHMyD (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 8 May 2015 08:54:03 -0400
Message-ID: <554CB1E7.5000302@xsilon.com>
Date: Fri, 08 May 2015 13:53:59 +0100
From: Martin Townsend <martin.townsend@xsilon.com>
MIME-Version: 1.0
Subject: Re: HW Address Filter
References: <554CA909.5030201@xsilon.com>
In-Reply-To: <554CA909.5030201@xsilon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org

Hi Alex,

False alarm, I needed to add the new IEEE802154_HW_XXX flags to my driver.  All is working now.

- Martin.

On 08/05/15 13:16, Martin Townsend wrote:
> Hi Alex,
>
> In my driver I have a set_hw_addr_filt ieee802154_ops but it doesn't seem to get called.  I setup the interface using
>
> iwpan phy phy0 interface add wpan0 type node 00:03:9a:00:00:00:01:2c
> iwpan dev wpan0 set pan_id 0x0777
> iwpan dev wpan0 set short_addr 0x012c
> iwpan phy phy0 set channel 0 11
> ip link add link wpan0 name lowpan0 type lowpan
> ifconfig lowpan0 up
> ifconfig wpan0 up
>
>
> I thought the first 3 lines would trigger the setting up of the HW address filter or do I need to do something else?
>
> - Martin.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-wpan" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

