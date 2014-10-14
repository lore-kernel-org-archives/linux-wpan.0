Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:23949 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751937AbaJNIgg (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Tue, 14 Oct 2014 04:36:36 -0400
Message-ID: <1413275705.2705.114.camel@jrissane-mobl.ger.corp.intel.com>
Subject: Re: [PATCH v6 bluetooth-next] 6lowpan: Use skb_cow in IPHC
 decompression.
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Date: Tue, 14 Oct 2014 11:35:05 +0300
In-Reply-To: <20141013172229.GB25249@omega>
References: <1413194456-26351-1-git-send-email-martin.townsend@xsilon.com>
	 <1413194456-26351-2-git-send-email-martin.townsend@xsilon.com>
	 <1413200959.2705.90.camel@jrissane-mobl.ger.corp.intel.com>
	 <543BCF44.1030001@xsilon.com>
	 <1413211468.2705.104.camel@jrissane-mobl.ger.corp.intel.com>
	 <543BE816.80304@xsilon.com>
	 <1413212954.2705.106.camel@jrissane-mobl.ger.corp.intel.com>
	 <20141013171111.GA25249@omega> <20141013172229.GB25249@omega>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: Martin Townsend <martin.townsend@xsilon.com>, Martin Townsend <mtownsend1973@gmail.com>, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, marcel@holtmann.org

Hi Alex,

On ma, 2014-10-13 at 19:22 +0200, Alexander Aring wrote:
> Hi Jukka,
> 
> sorry.
> 
> I was a little too fast here, because I am sure now this should solve your
> lockdep issue.

Unfortunately this patch did not help with the issue.

> 
> On Mon, Oct 13, 2014 at 07:11:11PM +0200, Alexander Aring wrote:
> > Hi Jukka,
> > 
> > On Mon, Oct 13, 2014 at 06:09:14PM +0300, Jukka Rissanen wrote:
> > > Hi Martin,
> > > 
> > > On ma, 2014-10-13 at 15:56 +0100, Martin Townsend wrote:
> > > > Hi Jukka,
> > > > 
> > > > Does this patch help?
> > > 
> > > Unfortunately no, I still see inconsistent lock state. It would probably
> > > have been too easy :)
> > > 
> > 
> > I remeber something, I think 802.15.4 had similar issues long time ago.
> > 
> s/remeber/remember/
> 
> > The fix was 20e7c4e80dcd01dad5e6c8b32455228b8fe9c619 ("6lowpan: fix
> > lockdep splats"). Please check that, you need something like that!
> > 
> 
> Something like that:
> 
> diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
> index 4ebc806..02fd21a 100644
> --- a/net/bluetooth/6lowpan.c
> +++ b/net/bluetooth/6lowpan.c
> @@ -642,7 +642,27 @@ static netdev_tx_t bt_xmit(struct sk_buff *skb, struct net_device *netdev)
>         return err < 0 ? NET_XMIT_DROP : err;
>  }
>  
> +static struct lock_class_key bt_tx_busylock;
> +static struct lock_class_key bt_netdev_xmit_lock_key;
> +
> +static void bt_set_lockdep_class_one(struct net_device *dev,
> +                                    struct netdev_queue *txq,
> +                                    void *_unused)
> +{
> +       lockdep_set_class(&txq->_xmit_lock,
> +                         &bt_netdev_xmit_lock_key);
> +}
> +
> +
> +static int bt_dev_init(struct net_device *dev)
> +{
> +       netdev_for_each_tx_queue(dev, bt_set_lockdep_class_one, NULL);
> +       dev->qdisc_tx_busylock = &bt_tx_busylock;
> +       return 0;
> +}
> +
>  static const struct net_device_ops netdev_ops = {
> +       .ndo_init               = bt_dev_init,
>         .ndo_start_xmit         = bt_xmit,
>  };
> 
> 
> - Alex
> 
> [0] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=20e7c4e80dcd01dad5e6c8b32455228b8fe9c619


Martin had an idea about the issue being related to work queues, I will
investigate that further.


Cheers,
Jukka


