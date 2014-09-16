Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:36511 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754150AbaIPLyH (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 16 Sep 2014 07:54:07 -0400
Date: Tue, 16 Sep 2014 13:53:58 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH v4 bluetooth] 6lowpan: fix incorrect return values in
 lowpan_rcv
Message-ID: <20140916115357.GE4969@omega>
References: <1410865319-16310-1-git-send-email-martin.townsend@xsilon.com>
 <1410865319-16310-2-git-send-email-martin.townsend@xsilon.com>
 <20140916113614.GC4969@omega>
 <5418215F.5050308@xsilon.com>
 <20140916114759.GD4969@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20140916114759.GD4969@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Martin Townsend <martin.townsend@xsilon.com>
Cc: Martin Townsend <mtownsend1973@gmail.com>, linux-zigbee-devel@lists.sourceforge.net, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, marcel@holtmann.org

On Tue, Sep 16, 2014 at 01:47:59PM +0200, Alexander Aring wrote:
> On Tue, Sep 16, 2014 at 12:39:11PM +0100, Martin Townsend wrote:
> > Hi Alex,
> > On 16/09/14 12:36, Alexander Aring wrote:
> > > On Tue, Sep 16, 2014 at 12:01:59PM +0100, Martin Townsend wrote:
...
> 
> and this also smells like side effects for me, because we have the
> local_skb which is sometimes freed inside of lowpan_process_data and
> returning skb. Then we don't know which we should kfree_skb now, the skb
> or local_skb now. Need to thing more about this to offer some solution,
> somebody agree here with me?
> 

I mean sometimes we do this *skb = *new and skb is the parameter and before we
did a consume_skb(skb); then local_skb is already freed after this and
returning an errno and we make kfree_skb(local_skb) will crash something,
I suppose.

- Alex
