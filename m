Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:54844 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753577AbaIKJyB (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 11 Sep 2014 05:54:01 -0400
Date: Thu, 11 Sep 2014 11:53:57 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH][linux-bluetooth 2/3] 6lowpan: Move skb delivery from
 IPHC.
Message-ID: <20140911095355.GB20686@omega>
References: <1410357968-27051-1-git-send-email-martin.townsend@xsilon.com>
 <1410357968-27051-4-git-send-email-martin.townsend@xsilon.com>
 <20140911081808.GA19675@omega>
 <54115C94.2050308@xsilon.com>
 <20140911090144.GC19675@omega>
 <54116C6D.3090004@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <54116C6D.3090004@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Martin Townsend <martin.townsend@xsilon.com>
Cc: Martin Townsend <mtownsend1973@gmail.com>, linux-zigbee-devel@lists.sourceforge.net, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, marcel@holtmann.org

On Thu, Sep 11, 2014 at 10:33:33AM +0100, Martin Townsend wrote:
> Hi Alex,
> 
> On 11/09/14 10:01, Alexander Aring wrote:
> > Hi Martin,
> >
> > On Thu, Sep 11, 2014 at 09:25:56AM +0100, Martin Townsend wrote:
> >> Hi Alex,
> >>
> >> On 11/09/14 09:18, Alexander Aring wrote:
> >>> On Wed, Sep 10, 2014 at 03:06:07PM +0100, Martin Townsend wrote:
> >>>> Passing the skb from 6lowpan up to the higher layers is not a
> >>>> function of IPHC.  By moving it out of IPHC we also remove the
> >>>> need to support error code returns with NET_RX codes.
> >>>> It also makes the lowpan_rcv function more extendable as we
> >>>> can support more compression schemes.
> >>>>
> >>> I will ack this. But please sperate this patch in two. First renaming
> >>> the function namens and then removing deliver callback.
> >> ok, but should this not be the other way around
> >> moving delivery into receive and then by doing this processs_data naturally becomes IPHC decompress so it can be renamed.
> >>> btw. The correct tag is bluetooth not linux-bluetooth, or bluetooth-next.
> >>>
> >>>
> >>>
> >>> Also this doesn't fix anything? Then this is for bluetooth-next. I know
> >>> this depends on the Patch 1/3. Marcel, do you have any a nice solution
> >>> about this, that we can deal with huge fixes in bluetooth and new features
> >>> for bluetooth-next. Or simple wait when it's merged?
> >> I disagree, this with the previous patch fixes error handling in lowpan_rcv.  By moving the skb delivery out of IPHC you automatically fix the nightmare which is returning a mixture of NET_RX codes with error codes.  IPHC now only returns error codes or success.  Delivery is done where is should be in the receive function and can deal with NET_RX codes.
> > ok. When this is a part of the fix and 1/3 "prepare" the fix, then put
> > this handling into patch "1/3" to really fix the issue from patch 1/3.
> I'm sorry I don't quite understand.  Are you saying that I should combine patches 1 and 2 into a single patch?
> 

So far I understand this is also part of the fix from patch 1. So it's
necessary to have this in one patch, means between patch 1 and 2 it's
still broken. Or?

and remove the renaming. You can do that as cleanup into bluetooth-next.

- Alex
