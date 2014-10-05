Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:52299 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751648AbaJESEH (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 5 Oct 2014 14:04:07 -0400
Date: Sun, 5 Oct 2014 20:03:58 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH v4 bluetooth] 6lowpan: fix incorrect return values in
 lowpan_rcv
Message-ID: <20141005180357.GA18715@omega>
References: <1412165422-31063-1-git-send-email-martin.townsend@xsilon.com>
 <1412165422-31063-2-git-send-email-martin.townsend@xsilon.com>
 <20141005175049.GA15923@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20141005175049.GA15923@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Martin Townsend <mtownsend1973@gmail.com>
Cc: linux-zigbee-devel@lists.sourceforge.net, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, marcel@holtmann.org, Martin Townsend <martin.townsend@xsilon.com>, werner@almesberger.net

On Sun, Oct 05, 2014 at 07:50:49PM +0200, Alexander Aring wrote:
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
> 
> I think we should split the movement of "passing skb to higher layer"
> into a separate patch.
> 

and now I realized that we had this also in some other mail, because the
netif call drops the skb, if "passing skb to higher layer" failed...

Maybe try to return 0; then instead an error if failed at this point.
I know I said, just merge these patches... but this is really much changes
here. I only want some clean patches which only fix the error handling
at first without any other changes -> KISS.

Sorry Martin.

- Alex
