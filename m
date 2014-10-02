Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:60598 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752641AbaJBMn2 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 2 Oct 2014 08:43:28 -0400
Date: Thu, 2 Oct 2014 14:43:21 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH v4 bluetooth] 6lowpan: fix incorrect return values in
 lowpan_rcv
Message-ID: <20141002124320.GA20649@omega>
References: <1412165422-31063-1-git-send-email-martin.townsend@xsilon.com>
 <1412165422-31063-2-git-send-email-martin.townsend@xsilon.com>
 <20141001124223.GB25269@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20141001124223.GB25269@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Martin Townsend <mtownsend1973@gmail.com>
Cc: linux-zigbee-devel@lists.sourceforge.net, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, marcel@holtmann.org, Martin Townsend <martin.townsend@xsilon.com>

Martin,

On Wed, Oct 01, 2014 at 02:42:23PM +0200, Alexander Aring wrote:
> Hi Martin,
> 
> On Wed, Oct 01, 2014 at 01:10:22PM +0100, Martin Townsend wrote:
> > Currently there are a number of error paths in the lowpan_rcv function that
> > free the skb before returning, the patch simplifies the receive path by
> > ensuring that the skb is only freed from this function.
> > 
> > Passing the skb from 6lowpan up to the higher layers is not a
> > function of IPHC.  By moving it out of IPHC we also remove the
> > need to support error code returns with NET_RX codes.
> > It also makes the lowpan_rcv function more extendable as we
> > can support more compression schemes.
> > 
> > With the above 2 lowpan_rcv is refactored so eliminate incorrect return values.
> 
> I notice this patch and I need some time to take review of this. Also
> Jukka should ack these changes, so we don't break anything of 6lowpan bluetooth branch.
> 
> Thanks for your work Martin.
> 
> 
> Marcel, please wait until this patch will get Acked-by you, Jukka, others who like to give
> review notes and me.
> 
> It's a terrible issue and we need a longer audit for this one.
> 

I have some private workload at the moment, I need the weekend for
reviewing this one. I hope this is ok.

- Alex
