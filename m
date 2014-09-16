Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:32781 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740AbaIPHKg (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 16 Sep 2014 03:10:36 -0400
Date: Tue, 16 Sep 2014 09:10:32 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH v3 bluetooth] 6lowpan: fix incorrect return values in
 lowpan_rcv
Message-ID: <20140916071030.GC1244@omega>
References: <1410790194-17502-1-git-send-email-martin.townsend@xsilon.com>
 <1410790194-17502-2-git-send-email-martin.townsend@xsilon.com>
 <1410851097.4860.6.camel@jrissane-mobl.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1410851097.4860.6.camel@jrissane-mobl.ger.corp.intel.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Cc: Martin Townsend <mtownsend1973@gmail.com>, linux-zigbee-devel@lists.sourceforge.net, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, marcel@holtmann.org, Martin Townsend <martin.townsend@xsilon.com>

On Tue, Sep 16, 2014 at 10:04:57AM +0300, Jukka Rissanen wrote:
> Hi Martin,
> 
> On ma, 2014-09-15 at 15:09 +0100, Martin Townsend wrote:
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
> > With the above 2 lowpan_rcv is refacored so eliminate incorrect return values.
> 
> I like the idea that we get rid of the callback function.
> 
> We could probably refactor the patch a bit further thou as the
> lowpan_process_data() could return the skb directly instead of being
> passed as a parameter. In the caller we could use the IS_ERR() macro to
> check if the returned value is an error or a real pointer.
> 
> 
ack, then we can also drop the **inout_skb thing.

- Alex
