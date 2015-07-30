Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:55011 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753146AbbG3QRr (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Thu, 30 Jul 2015 12:17:47 -0400
Subject: Re: [PATCH bluetooth-next 2/2] mac802154: fix wpan mac setting while
 lowpan
References: <1437742905-5921-1-git-send-email-alex.aring@gmail.com>
 <1437742905-5921-3-git-send-email-alex.aring@gmail.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <55BA4E28.9010904@osg.samsung.com>
Date: Thu, 30 Jul 2015 18:17:44 +0200
MIME-Version: 1.0
In-Reply-To: <1437742905-5921-3-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org

Hello.

On 24/07/15 15:01, Alexander Aring wrote:
> If we currently change the mac address inside the wpan interface while
> we have a lowpan interface on top of the wpan interface, the mac address
> setting doesn't reach the lowpan interface. The effect would be that the
> IPv6 lowpan interface has the old SLAAC address and isn't working
> anymore because the lowpan interface use in internal mechanism sometimes
> dev->addr which is the old mac address of the wpan interface.
>
> This patch checks if a wpan interface belongs to lowpan interface, if
> yes then we need to check if the lowpan interface is down and change the
> mac address also at the lowpan interface. When the lowpan interface will
> be set up afterwards, it will use the correct SLAAC address which based
> on the updated mac address setting.
>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>

I have a bit trouble testing it though. With iwpan we only allow to set 
the short address while the extended address is set during device 
registration. Removing this device also removes the connected lowpan 
device so I wonder where we would run into this problem. Patch is fine 
in any case but having this in my test script would allow me to check 
for regressions on this one.

regards
Stefan Schmidt

> ---
>   net/mac802154/iface.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
>
> diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
> index 416de90..346c160 100644
> --- a/net/mac802154/iface.c
> +++ b/net/mac802154/iface.c
> @@ -132,6 +132,20 @@ static int mac802154_wpan_mac_addr(struct net_device *dev, void *p)
>   	memcpy(dev->dev_addr, addr->sa_data, dev->addr_len);
>   	sdata->wpan_dev.extended_addr = extended_addr;
>   
> +	/* update lowpan interface mac address when
> +	 * wpan mac has been changed
> +	 */
> +	if (sdata->wpan_dev.lowpan_dev) {
> +		/* lowpan need to be down for update
> +		 * SLAAC address after ifup
> +		 */
> +		if (netif_running(sdata->wpan_dev.lowpan_dev))
> +			return -EBUSY;
> +
> +		memcpy(sdata->wpan_dev.lowpan_dev->dev_addr, dev->dev_addr,
> +		       dev->addr_len);
> +	}
> +
>   	return mac802154_wpan_update_llsec(dev);
>   }
>   

