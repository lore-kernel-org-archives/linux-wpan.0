Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:46896 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752087AbaLSWhD (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 19 Dec 2014 17:37:03 -0500
Received: by mail-wi0-f177.google.com with SMTP id l15so3192150wiw.16
        for <linux-wpan@vger.kernel.org>; Fri, 19 Dec 2014 14:37:01 -0800 (PST)
Date: Fri, 19 Dec 2014 23:36:56 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next 2/2] ieee802154: iface: move multiple node
 type check
Message-ID: <20141219223653.GA21901@omega>
References: <1419028123-21367-1-git-send-email-alex.aring@gmail.com>
 <1419028123-21367-3-git-send-email-alex.aring@gmail.com>
 <40D0A383-0A03-457B-81BC-2C492D798D98@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <40D0A383-0A03-457B-81BC-2C492D798D98@holtmann.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi Marcel,

On Fri, Dec 19, 2014 at 11:33:11PM +0100, Marcel Holtmann wrote:
> Hi Alex,
> 
> > This patch moves the handling for checking on multiple node type
> > interface to the corresponding concurrent iface check function.
> > 
> > Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> > ---
> > net/mac802154/iface.c | 24 ++++++++++--------------
> > 1 file changed, 10 insertions(+), 14 deletions(-)
> > 
> > diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
> > index 509621a..b5aab5a 100644
> > --- a/net/mac802154/iface.c
> > +++ b/net/mac802154/iface.c
> > @@ -137,25 +137,11 @@ static int mac802154_wpan_mac_addr(struct net_device *dev, void *p)
> > static int mac802154_slave_open(struct net_device *dev)
> > {
> > 	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
> > -	struct ieee802154_sub_if_data *subif;
> > 	struct ieee802154_local *local = sdata->local;
> > 	int res = 0;
> > 
> > 	ASSERT_RTNL();
> > 
> > -	if (sdata->vif.type == NL802154_IFTYPE_NODE) {
> > -		mutex_lock(&sdata->local->iflist_mtx);
> > -		list_for_each_entry(subif, &sdata->local->interfaces, list) {
> > -			if (subif != sdata &&
> > -			    subif->vif.type == sdata->vif.type &&
> > -			    ieee802154_sdata_running(subif)) {
> > -				mutex_unlock(&sdata->local->iflist_mtx);
> > -				return -EBUSY;
> > -			}
> > -		}
> > -		mutex_unlock(&sdata->local->iflist_mtx);
> > -	}
> > -
> > 	set_bit(SDATA_STATE_RUNNING, &sdata->state);
> > 
> > 	if (!local->open_count) {
> > @@ -234,6 +220,16 @@ ieee802154_check_concurrent_iface(struct ieee802154_sub_if_data *sdata,
> > 	list_for_each_entry(nsdata, &local->interfaces, list) {
> > 		if (nsdata != sdata && ieee802154_sdata_running(nsdata)) {
> > 			int ret;
> > +
> > +			/* TODO currently we don't support multiple node types
> > +			 * we need to run skb_clone at rx path. Check if there
> > +			 * exist really an use case if we need to support
> > +			 * multiple node types at the same time.
> > +			 */
> > +			if (sdata->vif.type == NL802154_IFTYPE_NODE &&
> > +			    nsdata->vif.type == NL802154_IFTYPE_NODE)
> > +				return -EBUSY;
> > +
> 
> here you end up doing it correctly and fixing it, ..
> 
> > 			/* check all phy mac sublayer settings are the same.
> > 			 * We have only one phy, different values makes trouble.
> > 			 */
> 
> .. but that still leaves the extra empty line after this comment. You need to redo these two patches.
> 

ok.

- Alex
