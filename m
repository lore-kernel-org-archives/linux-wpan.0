Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751978AbeENPba (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Mon, 14 May 2018 11:31:30 -0400
Date: Mon, 14 May 2018 17:31:13 +0200
From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: net: ieee802154: 6lowpan: fix frag reassembly
Message-ID: <20180514153113.GA28919@kroah.com>
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
> 
> 
> Normally net/ patches would come through DaveM, but he asked me for this one to submit it directly when i sent him the pull request.
> 
> 
> First time stable request on my side here, let me know if I got something wrong.

Looks fine, I'll queue it up later this week in the next release after
these go out on Wednesday.

thanks,

greg k-h
