Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750924AbeEQI7h (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Thu, 17 May 2018 04:59:37 -0400
Date: Thu, 17 May 2018 10:59:19 +0200
From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: net: ieee802154: 6lowpan: fix frag reassembly
Message-ID: <20180517085919.GD25318@kroah.com>
References: <142208d4-6ca6-5923-327c-8d1cb069ceb8@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <142208d4-6ca6-5923-327c-8d1cb069ceb8@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: stable@vger.kernel.org, Alexander Aring <aring@mojatatu.com>, "David S. Miller" <davem@davemloft.net>, "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>, Network Development <netdev@vger.kernel.org>

On Mon, May 14, 2018 at 05:22:18PM +0200, Stefan Schmidt wrote:
> Hello.
> 
> 
> Please apply f18fa5de5ba7f1d6650951502bb96a6e4715a948
> 
> (net: ieee802154: 6lowpan: fix frag reassembly) to the 4.16.x stable tree.
> 
> 
> Earlier trees are not needed as the problem was introduced in 4.16.

Really?  Commit f18fa5de5ba7 ("net: ieee802154: 6lowpan: fix frag
reassembly") says it fixes commit 648700f76b03 ("inet: frags: use
rhashtables for reassembly units") which did not show up until 4.17-rc1:
	$ git describe --contains 648700f76b03
	v4.17-rc1~148^2~20^2~11

Also, it did not get backported to 4.16.y, so I don't see how it is
needed in 4.16-stable.

To verify this, I tried applying the patch, and it totally fails to
apply to the 4.16.y tree.

So are you _sure_ you want/need this in 4.16?  If so, can you provide a
working backport that you have verified works?

thanks,

greg k-h
