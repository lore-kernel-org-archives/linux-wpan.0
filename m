Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:35332 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752474AbbETKdx (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 20 May 2015 06:33:53 -0400
Received: by wicmx19 with SMTP id mx19so149584750wic.0
        for <linux-wpan@vger.kernel.org>; Wed, 20 May 2015 03:33:51 -0700 (PDT)
Date: Wed, 20 May 2015 12:33:48 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH 7/8] mac802154: mac802154_header_create() optimisation.
Message-ID: <20150520103345.GD3978@omega>
References: <cover.1432064518.git.buytenh@wantstofly.org>
 <20150519195018.GS11014@wantstofly.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20150519195018.GS11014@wantstofly.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: linux-wpan@vger.kernel.org

On Tue, May 19, 2015 at 10:50:18PM +0300, Lennert Buytenhek wrote:
> mac802154_header_create() calls ieee802154_mlme_ops(dev)->get_dsn(dev),
> but 'dev' is always a mac802154 device, therefore we can just call
> mac802154_dev_get_dsn() instead directly.
> 

this is correct, but this code has currently more issues. Several days I
posted a draft about to handle the dsn value as atomic_t [0].

This depends on removal of pib and mib lock. The pib lock is a mutex and
mib lock a spinlock currently. See patch [1].

I think I need to explain something about the locking handling:
There exists now a new locking mechanism which protects all pib/mib
values with the rtnl mutex. The mib values are special now, we use them
while frame parsing and generation. For easy handling these values we
hold the rtnl lock and check if the interface is up. If the interface is
up we don't allow changes at mostly mib attributes. This means when a
interface is up we don't need to care about locking, because these
attributes are readonly and in the most hotpath we can remove the locks.

The mib values which are readonly depends "mostly" also on phy
registers, that are some mac operations which doing the phy. These
registers will set when we do a interface up (ndo_do_open). E.g. the
address filter settings, if the phy has the possibilty to set them.

btw: phy settings like channels/cca mode/cca ed level we allow by doing
this while interface up.


Now back to the dsn value, that's a mib setting which is writeable while
ifup and currently we don't have any locks there, but we need locks because
upper layers generates mac headers and they call dev_queue_xmit and this
can be occur at the same time. 


btw:
The dev_hard_header call. (Also at the moment it's ugly to set all parameters
through the skb->cb, we should insert our own dev_hard_dataheader,
dev_hard_beaconheader, dev_hard_cmdheader and have header_ops callbacks in the
wpan_dev structure. To do this over skb->cb will also broke very generic af
families like af_packet, which also call the dev_hard_header without
doing specific 802.15.4 handling inside skb-cb. Then simple let this
pointer to NULL so we don't support this and all 802.15.4 upper layers
call the wpan_dev header creations. Then af_packet will don't call this,
the current behaviour is broken and I believe af_packet works without it.


Sorry, I don't ack this patch. We need to handle this correct with an
atomic_t and we can remove the mib/pib locks because we have a better
locking handling now which follows some strategie.

- Alex

[0] http://www.spinics.net/lists/linux-wpan/msg01920.html
[1] http://www.spinics.net/lists/linux-wpan/msg01896.html
