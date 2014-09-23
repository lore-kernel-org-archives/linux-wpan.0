Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:28246 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750818AbaIWJO2 (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Tue, 23 Sep 2014 05:14:28 -0400
Message-ID: <1411463634.4860.65.camel@jrissane-mobl.ger.corp.intel.com>
Subject: Re: [PATCH linux-wpan v4] ieee802154: 6lowpan: ensure header
 compression does not corrupt ipv6 header
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Date: Tue, 23 Sep 2014 12:13:54 +0300
In-Reply-To: <20140922162148.GA7282@omega>
References: <1411401123-7790-1-git-send-email-simon.vincent@xsilon.com>
	 <20140922162148.GA7282@omega>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: Simon Vincent <simon.vincent@xsilon.com>, linux-wpan@vger.kernel.org, marcel@holtmann.org

Hi Alex,

On ma, 2014-09-22 at 18:21 +0200, Alexander Aring wrote:

> grml, I overlooked something the last version. But I will fix it while
> >  
> > -	cb->ackreq = !lowpan_is_addr_broadcast(daddr);
> > +	/* TODO: Currently we only support extended_addr */
> > +	info->daddr.mode = IEEE802154_ADDR_LONG;
> 
> now IEEE802154_ADDR_LONG is no little endian value copied from mac
> header. Somewhere else converted the little endian value to an host understandable
> enum/define number. For the rework I will remove this value. We should never
> ever convert this value for parsing.
> 
> We use it only for af_802154 and userspace specification what addresses
> should be used. But the above one to make this __le16 is incorrect. For
> userspace we should create some enums for declaring different address
> types. Then we can use this for 802.15.4 sockets.

BTW, at some point we might want to change the IEEE802154_ADDR_LONG in
net/6lowpan/iphc.c to more generic. Now this IEEE 802154 specific enum
needs to be mentioned in net/bluetooth/6lowpan.c which looks quite
confusing.

> 
> I will fix it while applying when all things are okay, it's only to
> replace the __le16 to u8.
> 
> 
> And I also know that 6LoWPAN GENERIC need this value for determined is EUI64
> or short. I don't forget this one, wasn't full finished at rework
> branch.
> 
> - Alex


Cheers,
Jukka


