Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:56508 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752598AbaLSWdR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 19 Dec 2014 17:33:17 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH bluetooth-next 2/2] ieee802154: iface: move multiple node type check
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1419028123-21367-3-git-send-email-alex.aring@gmail.com>
Date: Fri, 19 Dec 2014 23:33:11 +0100
Content-Transfer-Encoding: 8BIT
Message-Id: <40D0A383-0A03-457B-81BC-2C492D798D98@holtmann.org>
References: <1419028123-21367-1-git-send-email-alex.aring@gmail.com> <1419028123-21367-3-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi Alex,

> This patch moves the handling for checking on multiple node type
> interface to the corresponding concurrent iface check function.
> 
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
> net/mac802154/iface.c | 24 ++++++++++--------------
> 1 file changed, 10 insertions(+), 14 deletions(-)
> 
> diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
> index 509621a..b5aab5a 100644
> --- a/net/mac802154/iface.c
> +++ b/net/mac802154/iface.c
> @@ -137,25 +137,11 @@ static int mac802154_wpan_mac_addr(struct net_device *dev, void *p)
> static int mac802154_slave_open(struct net_device *dev)
> {
> 	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
> -	struct ieee802154_sub_if_data *subif;
> 	struct ieee802154_local *local = sdata->local;
> 	int res = 0;
> 
> 	ASSERT_RTNL();
> 
> -	if (sdata->vif.type == NL802154_IFTYPE_NODE) {
> -		mutex_lock(&sdata->local->iflist_mtx);
> -		list_for_each_entry(subif, &sdata->local->interfaces, list) {
> -			if (subif != sdata &&
> -			    subif->vif.type == sdata->vif.type &&
> -			    ieee802154_sdata_running(subif)) {
> -				mutex_unlock(&sdata->local->iflist_mtx);
> -				return -EBUSY;
> -			}
> -		}
> -		mutex_unlock(&sdata->local->iflist_mtx);
> -	}
> -
> 	set_bit(SDATA_STATE_RUNNING, &sdata->state);
> 
> 	if (!local->open_count) {
> @@ -234,6 +220,16 @@ ieee802154_check_concurrent_iface(struct ieee802154_sub_if_data *sdata,
> 	list_for_each_entry(nsdata, &local->interfaces, list) {
> 		if (nsdata != sdata && ieee802154_sdata_running(nsdata)) {
> 			int ret;
> +
> +			/* TODO currently we don't support multiple node types
> +			 * we need to run skb_clone at rx path. Check if there
> +			 * exist really an use case if we need to support
> +			 * multiple node types at the same time.
> +			 */
> +			if (sdata->vif.type == NL802154_IFTYPE_NODE &&
> +			    nsdata->vif.type == NL802154_IFTYPE_NODE)
> +				return -EBUSY;
> +

here you end up doing it correctly and fixing it, ..

> 			/* check all phy mac sublayer settings are the same.
> 			 * We have only one phy, different values makes trouble.
> 			 */

.. but that still leaves the extra empty line after this comment. You need to redo these two patches.

Regards

Marcel

